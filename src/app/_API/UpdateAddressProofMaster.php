<?php
include('cors.php');
include('dbconfiguration.php');

$data = json_decode(file_get_contents("php://input"));

$sql = "call spUpdateAdressProofMaster('$data->AddressProofId_','$data->Title_')";
$result = $conn->query($sql);

// if($result->num_rows > 0) {
//     $data = array();

//     while ($row = $result->fetch_assoc()) {
//         $data[] = $row;
//     }
    
//     echo json_encode($data);
// } else {
//     echo "0";
// }

echo $result;

$conn->close();
?>