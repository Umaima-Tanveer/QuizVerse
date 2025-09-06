<?php
// Database connection
$host = "localhost";
$user = "root";
$pass = "";
$db = "quizverse_db";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Query to fetch leaderboard data
$sql = "SELECT u.username, u.email, l.score, l.difficulty
        FROM leaderboard l
        JOIN users u ON l.user_id = u.id
        ORDER BY l.score DESC";

$result = $conn->query($sql);

$leaderboard = [];
while ($row = $result->fetch_assoc()) {
    $leaderboard[] = $row;
}

// Output as JSON
echo json_encode($leaderboard);

$conn->close();
?>
