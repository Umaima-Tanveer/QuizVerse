<?php
// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Log incoming POST data
error_log("POST data: " . print_r($_POST, true));

// Validate POST input
if (!isset($_POST['player_name'], $_POST['score'], $_POST['total'])) {
    echo json_encode(['message' => 'Missing required data']);
    exit;
}

// Sanitize input
$player_name = trim($_POST['player_name']);
$score = intval($_POST['score']);
$total = intval($_POST['total']);

// Connect to database
$host = 'localhost';
$user = 'root';
$pass = '';
$db = 'quizverse_db';

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die(json_encode(['message' => 'Connection failed: ' . $conn->connect_error]));
}

// Insert into users table if not present
$insert_user = $conn->prepare("INSERT IGNORE INTO users (user) VALUES (?)");
if ($insert_user) {
    $insert_user->bind_param("s", $player_name);
    $insert_user->execute();
    $insert_user->close();
} else {
    error_log("Failed to prepare user insert: " . $conn->error);
    echo json_encode(['message' => 'Failed to insert user', 'error' => $conn->error]);
    $conn->close();
    exit;
}

// Insert into score table
$insert_score = $conn->prepare("INSERT INTO score (player_name, score, total_questions) VALUES (?, ?, ?)");
$insert_score->bind_param("sii", $player_name, $score, $total);

if ($insert_score->execute()) {
    // Check if user exists in leaderboard
    $check = $conn->prepare("SELECT score FROM leaderboard WHERE player_name = ?");
    $check->bind_param("s", $player_name);
    $check->execute();
    $check->store_result();

    if ($check->num_rows > 0) {
        $check->bind_result($existing_score);
        $check->fetch();
        if ($score > $existing_score) {
            $update = $conn->prepare("UPDATE leaderboard SET score = ? WHERE player_name = ?");
            $update->bind_param("is", $score, $player_name);
            $update->execute();
            $update->close();
            echo json_encode(['message' => '✅ Score saved and leaderboard updated.']);
        } else {
            echo json_encode(['message' => 'ℹ️ Score saved. Leaderboard unchanged (lower score).']);
        }
    } else {
        // Insert new leaderboard entry
        $insert_lb = $conn->prepare("INSERT INTO leaderboard (player_name, score) VALUES (?, ?)");
        $insert_lb->bind_param("si", $player_name, $score);
        $insert_lb->execute();
        $insert_lb->close();
        echo json_encode(['message' => '✅ Score saved and added to leaderboard.']);
    }

    $check->close();
} else {
    echo json_encode(['message' => '❌ Failed to save score.', 'error' => $insert_score->error]);
}

$insert_score->close();
$conn->close();
?>
