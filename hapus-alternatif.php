<?php require_once('includes/init.php'); ?>
<?php cek_login($role = array(1)); ?>

<?php
$ada_error = false;
$result = '';

$id_alternatif = (isset($_GET['id'])) ? trim($_GET['id']) : '';

$sql = "DELETE FROM alternatif WHERE id_alternatif = ?";
$stmt = $koneksi->prepare($sql);

if ($stmt) {
    $stmt->bind_param("i", $id_alternatif);
    $stmt->execute();
    if ($stmt->affected_rows > 0) {
		redirect_to('list-alternatif.php?status=sukses-hapus');
    }
    $stmt->close();
} else {
    echo "Kesalahan dalam persiapan statement: " . $koneksi->error;
}

?>

<?php
$page = "Alternatif";
require_once('template/header.php');
?>
	<?php if($ada_error): ?>
		<?php echo '<div class="alert alert-danger">'.$ada_error.'</div>'; ?>	
	<?php endif; ?>
<?php
require_once('template/footer.php');
?>