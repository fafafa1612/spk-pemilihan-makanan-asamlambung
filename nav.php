<?php

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $page = $_POST['data'];
    switch ($page) {
        case 'dataalternatif':
            header('Location: cetakalter.php');
            break;
        case 'datanorma':
            header('Location: cetaknorma.php');
            break;
        case 'dataper':
                header('Location: cetakperhi.php');
                break;
        default:
            echo "Page not found.";
            break;
    }
    exit();
}

?>