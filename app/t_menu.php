<?php



require('dbcon.php');



if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $data = json_decode(file_get_contents('php://input'), true);
    $name = $data["name"];
    $id = $data["id"];
    $price = $data["price"];
    $param = $data["param"];

    if ($param == "insert") {
        try {
            $sql = "INSERT INTO t_menu(name,price,id) VALUES (:name, :price,:id)";
            $stmt = $conn->prepare($sql);
            $stmt->bindParam(':name', $name);
            $stmt->bindParam(':price', $price);
            $stmt->bindParam(':id', $id);
            $stmt->execute();
    
            echo "New record created successfully";
        } catch(PDOException $e) {
            echo "Error: " . $e->getMessage();
        }
    }
    
}
