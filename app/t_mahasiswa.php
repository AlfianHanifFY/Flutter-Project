<?php
require('dbcon.php');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $nama = $_POST["nama"];
    $id = $_POST["id"];
    $param = $_POST["param"];

    if ($param == "insert") {
        try {
            $sql = "INSERT INTO t_mahasiswa (nama, id) VALUES (:nama, :id)";
            $stmt = $conn->prepare($sql);
            $stmt->bindParam(':nama', $nama);
            $stmt->bindParam(':id', $id);
            $stmt->execute();
    
            echo "New record created successfully";
        } catch(PDOException $e) {
            echo "Error: " . $e->getMessage();
        }
    }
    elseif ($param == "update"){
        try {
            $sql = "UPDATE t_mahasiswa SET nama = :nama WHERE id = :id";
            $stmt = $conn->prepare($sql);
            $stmt->bindParam(':nama', $nama);
            $stmt->bindParam(':id', $id);
            $stmt->execute();
    
            echo "New record updated successfully";
        } catch(PDOException $e) {
            echo "Error: " . $e->getMessage();
        }
    }
    elseif ($param == "delete"){
        try {
            $sql = "DELETE FROM t_mahasiswa WHERE id = :id";
            $stmt = $conn->prepare($sql);
            $stmt->bindParam(':id', $id);
            $stmt->execute();
    
            echo "New record deleted successfully";
        } catch(PDOException $e) {
            echo "Error: " . $e->getMessage();
        }
    }
    
}
