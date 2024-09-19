<?php
require_once('includes/init.php');

$user_role = get_role();
if ($user_role == 'admin' || $user_role == 'user') {
?>

	<html>
		<link href="assets/css/cetak.css" rel="stylesheet" />
	<head>
	<img src="assets/img/logo.png" alt="" style = "float : left ; height : 80px;">
		
	</head>
	<body onload="window.print();">
	<h2 style = "text-align : center"> HASIL PERANGKINGAN</h2>
	<hr>
		<div style="width:100%;margin:0 auto;text-align:center;">
			<table width="100%" cellspacing="0" cellpadding="5" border="1">
				<thead>
					<tr class = "table" align="center">
						<th>Nama Alternatif</th>
						<th>Nilai</th>
						<th width="15%">Rank</th>
					</tr>
				</thead>
				<tbody>
					<?php
					$no = 0;
					$query = mysqli_query($koneksi, "SELECT * FROM hasil JOIN alternatif ON hasil.id_alternatif=alternatif.id_alternatif ORDER BY hasil.nilai DESC");
					while ($data = mysqli_fetch_array($query)) {
						$no++;
					?>
						<tr align="center">
							<td align="left"><?= $data['alternatif'] ?></td>
							<td><?= $data['nilai'] ?></td>
							<td><?= $no; ?></td>
						</tr>
					<?php
					}
					?>
				</tbody>
			</table>
		</div>
<?php 
		function hari(){
			$hari  = date("D");

			switch($hari){
				case 'Sun':
					$hari_ini="Minggu";
					break;


				case 'Mon':
					$hari_ini="Senin";
					break;
					
				case 'Tue':
					$hari_ini="Selasa";
					break;

				case 'Wed':
					$hari_ini="Rabu";
					break;

				case 'Thu':
					$hari_ini="Kamis";
					break;

				case 'Fri':
					$hari_ini="Jumat";
					break;
				
				case 'Sat':
					$hari_ini="Sabtu";
					break;

					default :
						$hari_ini="Tidak Diketahui";
						break;
			}
			return $hari_ini ;
		}
		function tgl($tanggal){
				$bulan = array(
					1 => 'Januari',
						'Febuari',
						'Maret',
						'April',
						'Mei',
						'Juni',
						'Juli',
						'Agustus',
						'September',
						'Oktober',
						'November',
						'Desember'
				);
				$pecahan = explode ('-', $tanggal);

				return $pecahan [2].' '.$bulan[(int)$pecahan[1]].' '.$pecahan[0];
			}
?>
<div class = "ttd">
<div class="tempat">
	<p>Jakarta. <?= hari();?>, <?= tgl(date('Y-m-d'));?> </p>
</div>
<div class = "admin"><p>Admin</p></div>
<div class = "nama"><p>Fajar Adhi Prasetyo</p></div>
</div>
<div class="logo">
<img src="assets/img/SPK.png" alt="" style = "height : 80px;">
</div>

	</body>

	</html>

<?php
} else {
	header('Location: login.php');
}
?>