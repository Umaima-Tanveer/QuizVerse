<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

$host = 'localhost';
$user = 'root';
$pass = '';
$db = 'quizverse_db';

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die(json_encode(['message' => 'Connection failed: ' . $conn->connect_error]));
}

$sql = "SELECT player_name, score, total_questions FROM score ORDER BY score DESC LIMIT 10";
$result = $conn->query($sql);

$scores = [];

if ($result && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $scores[] = $row;
    }
    echo json_encode($scores);
} else {
    echo json_encode(['message' => 'No scores found']);
}

$conn->close();
?>
