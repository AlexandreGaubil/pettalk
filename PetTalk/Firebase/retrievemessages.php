<?php

$servername = "localhost";
$username = "publicuser";
$password = "lam50)perl";

//Create connection
$conn = new mysqli($servername, $username, $password);

//Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

//Retrieve all rows from the database
$sql = "SELECT * FROM sql-database-previous-messages-pettalk.savedmessages";
$result = $conn->query($sql);

$dataArray = Array();

if ($result->num_rows > 0) {
	
	

	while($row = result->fetch_assoc()) {
		
		//Assign each row into an array
		$dataArray[] = $row;
		echo json_encode($dataArray);

	}  
} else {
	echo json_encode($dataArray);
}

//Close the connection
$conn->close();

?>
