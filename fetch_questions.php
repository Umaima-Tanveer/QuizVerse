<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

$host = "localhost";
$user = "root";
$pass = "";
$db = "quizverse_db";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    echo json_encode(["error" => "Connection failed: " . $conn->connect_error]);
    exit;
}

$category = $_GET['category'] ?? '';
$difficulty = $_GET['difficulty'] ?? '';

// Case-insensitive comparison
$sql = "
  SELECT 
    q.id, 
    q.question_text, 
    q.option1, 
    q.option2, 
    q.option3, 
    q.option4, 
    q.correct_option,
    c.category_name AS category_name, 
    d.difficulty_level AS difficulty_level 
  FROM questions q
  JOIN categories c ON q.category_id = c.id
  JOIN difficulties d ON q.difficulty_id = d.id
  WHERE LOWER(c.category_name) = LOWER(?) 
    AND LOWER(d.difficulty_level) = LOWER(?)
  LIMIT 5
";

$stmt = $conn->prepare($sql);
if (!$stmt) {
    echo json_encode(["error" => "Failed to prepare SQL statement: " . $conn->error]);
    exit;
}

$stmt->bind_param("ss", $category, $difficulty);
$stmt->execute();
$result = $stmt->get_result();

$questions = [];
while ($row = $result->fetch_assoc()) {
    $questions[] = $row;
}

echo json_encode($questions);

$stmt->close();
$conn->close();
?>
