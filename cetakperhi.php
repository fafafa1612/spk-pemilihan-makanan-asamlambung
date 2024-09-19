<?php
require_once('includes/init.php');

$user_role = get_role();
if ($user_role == 'admin' || $user_role == 'user') {
	$page = "Cetak Alternatif";

	mysqli_query($koneksi, "TRUNCATE TABLE hasil;");

	$kriteria = array();
	$q1 = mysqli_query($koneksi, "SELECT * FROM kriteria ORDER BY kode_kriteria ASC");
	while ($krit = mysqli_fetch_array($q1)) {
		$kriteria[$krit['id_kriteria']]['id_kriteria'] = $krit['id_kriteria'];
		$kriteria[$krit['id_kriteria']]['kode_kriteria'] = $krit['kode_kriteria'];
		$kriteria[$krit['id_kriteria']]['kriteria'] = $krit['kriteria'];
		$kriteria[$krit['id_kriteria']]['type'] = $krit['type'];
		$kriteria[$krit['id_kriteria']]['bobot'] = $krit['bobot'];
		$kriteria[$krit['id_kriteria']]['ada_pilihan'] = $krit['ada_pilihan'];
	}

	$alternatif = array();
	$q2 = mysqli_query($koneksi, "SELECT * FROM alternatif");
	while ($alt = mysqli_fetch_array($q2)) {
		$alternatif[$alt['id_alternatif']]['id_alternatif'] = $alt['id_alternatif'];
		$alternatif[$alt['id_alternatif']]['alternatif'] = $alt['alternatif'];
	}
	
?>

	<html>
		<link href="assets/css/cetak.css" rel="stylesheet" />
	<head>
	<img src="assets/img/logo.png" alt="" style = "float : left ; height : 80px;">
		
	</head>
	<body onload="window.print();">
	<h2 style = "text-align : center"> DATA PERHITUNGAN </h2>
	<hr>
		<div style="width:100%;margin:0 auto;text-align:center;">
			<table width="100%" cellspacing="0" cellpadding="5" border="1">
				<thead>
					<tr class = "table" align="center">
						<th>No</th>
						<th>Nama Alternatif</th>
						<th>Perhitungan</th>
						<th>Nilai</th>
					</tr>
				</thead>
				<tbody>
				<?php
						$no = 1;
						foreach ($alternatif as $keys) : ?>
							<tr align="center">
								<td><?= $no; ?></td>
								<td align="left"><?= $keys['alternatif'] ?></td>
								<td>
									SUM
									<?php
									$nilai_v = 0;
									foreach ($kriteria as $key) :
										$bobot = $key['bobot'];
										if ($key['ada_pilihan'] == 1) {
											$q4 = mysqli_query($koneksi, "SELECT sub_kriteria.nilai FROM penilaian JOIN sub_kriteria WHERE penilaian.nilai=sub_kriteria.id_sub_kriteria AND penilaian.id_alternatif='$keys[id_alternatif]' AND penilaian.id_kriteria='$key[id_kriteria]'");
											$dt1 = mysqli_fetch_array($q4);

											$q5 = mysqli_query($koneksi, "SELECT MAX(sub_kriteria.nilai) as max, MIN(sub_kriteria.nilai) as min, kriteria.type FROM penilaian JOIN sub_kriteria ON penilaian.nilai=sub_kriteria.id_sub_kriteria JOIN kriteria ON penilaian.id_kriteria=kriteria.id_kriteria WHERE penilaian.id_kriteria='$key[id_kriteria]'");
											$dt2 = mysqli_fetch_array($q5);
											if ($dt2['type'] == "Benefit") {
												$nilai_r = round(($dt1['nilai'] / $dt2['max']), 2);
											} else {
												$nilai_r = round(($dt2['min'] / $dt1['nilai']), 2);
											}
										} else {
											$q4 = mysqli_query($koneksi, "SELECT nilai FROM penilaian WHERE id_alternatif='$keys[id_alternatif]' AND id_kriteria='$key[id_kriteria]'");
											$dt1 = mysqli_fetch_array($q4);

											$q5 = mysqli_query($koneksi, "SELECT MAX(penilaian.nilai) as max, MIN(penilaian.nilai) as min, kriteria.type FROM penilaian JOIN kriteria ON penilaian.id_kriteria=kriteria.id_kriteria WHERE penilaian.id_kriteria='$key[id_kriteria]'");
											$dt2 = mysqli_fetch_array($q5);
											if ($dt2['type'] == "Benefit") {
												$nilai_r = round(($dt1['nilai'] / $dt2['max']), 2);
											} else {
												$nilai_r = round(($dt2['min'] / $dt1['nilai']), 2);
											}
										}
										$nilai_penjumlahan = $bobot * $nilai_r;
										$nilai_v += $nilai_penjumlahan;
										echo "(" . $bobot . "x" . $nilai_r . ") ";
									endforeach ?>
								</td>
								<td bgcolor = "#99FFCC">
									<?php
									echo $nilai_v;
									$kode = uniqid('kode-', true);
									mysqli_query($koneksi, "INSERT INTO hasil (id_hasil, kode_hasil, id_alternatif, nilai) VALUES ('', '$kode', '$keys[id_alternatif]', '$nilai_v')");
									?>
								</td>
							</tr>
						<?php
							$no++;
						endforeach
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