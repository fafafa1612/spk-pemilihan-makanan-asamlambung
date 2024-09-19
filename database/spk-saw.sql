-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 04 Agu 2024 pada 09.41
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `default_spk_saw`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `alternatif`
--

CREATE TABLE `alternatif` (
  `id_alternatif` int(11) NOT NULL,
  `alternatif` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `alternatif`
--

INSERT INTO `alternatif` (`id_alternatif`, `alternatif`) VALUES
(21, 'Kentang'),
(22, 'Roti Gandum'),
(23, 'Yoghurt'),
(24, 'Oathmeal'),
(25, 'Daging 95% tanpa Lemak'),
(26, 'Bubur Kacang Hijau');

-- --------------------------------------------------------

--
-- Struktur dari tabel `hasil`
--

CREATE TABLE `hasil` (
  `id_hasil` int(11) NOT NULL,
  `kode_hasil` varchar(255) DEFAULT NULL,
  `id_alternatif` int(11) NOT NULL,
  `nilai` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `hasil`
--

INSERT INTO `hasil` (`id_hasil`, `kode_hasil`, `id_alternatif`, `nilai`) VALUES
(1, 'kode-66af005dadae03.38923169', 21, 8.35),
(2, 'kode-66af005db07250.56661234', 22, 7.68),
(3, 'kode-66af005db4b194.05072618', 23, 6.86),
(4, 'kode-66af005dba0cb4.13813787', 24, 7.85),
(5, 'kode-66af005dbde891.04615619', 25, 7.49),
(6, 'kode-66af005dc0c5c5.98836603', 26, 8.67);

-- --------------------------------------------------------

--
-- Struktur dari tabel `kriteria`
--

CREATE TABLE `kriteria` (
  `id_kriteria` int(11) NOT NULL,
  `kode_kriteria` varchar(10) NOT NULL,
  `kriteria` varchar(50) NOT NULL,
  `type` enum('Benefit','Cost') NOT NULL,
  `bobot` float NOT NULL,
  `ada_pilihan` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `kriteria`
--

INSERT INTO `kriteria` (`id_kriteria`, `kode_kriteria`, `kriteria`, `type`, `bobot`, `ada_pilihan`) VALUES
(7, 'C1', 'Kandungan Asam', 'Cost', 1, 0),
(8, 'C2', 'Kandungan Lemak', 'Cost', 1, 0),
(9, 'C3', 'Kandungan Protein', 'Benefit', 2, 0),
(10, 'C4', 'Kandungan Karbohidrat', 'Benefit', 3, 0),
(11, 'C5', 'Kandungan Kalori', 'Benefit', 3, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `penilaian`
--

CREATE TABLE `penilaian` (
  `id_penilaian` int(11) NOT NULL,
  `id_alternatif` int(10) NOT NULL,
  `id_kriteria` int(10) NOT NULL,
  `nilai` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `penilaian`
--

INSERT INTO `penilaian` (`id_penilaian`, `id_alternatif`, `id_kriteria`, `nilai`) VALUES
(146, 22, 7, 3),
(147, 22, 8, 1),
(148, 22, 9, 2),
(149, 22, 10, 3),
(150, 22, 11, 2),
(151, 23, 7, 2),
(152, 23, 8, 1),
(153, 23, 9, 2),
(154, 23, 10, 2),
(155, 23, 11, 2),
(156, 24, 7, 2),
(157, 24, 8, 1),
(158, 24, 9, 2),
(159, 24, 10, 3),
(160, 24, 11, 2),
(186, 26, 7, 3),
(187, 26, 8, 1),
(188, 26, 9, 2),
(189, 26, 10, 3),
(190, 26, 11, 3),
(191, 25, 7, 2),
(192, 25, 8, 1),
(193, 25, 9, 3),
(194, 25, 10, 1),
(195, 25, 11, 3),
(211, 21, 7, 1),
(212, 21, 8, 1),
(213, 21, 9, 2),
(214, 21, 10, 3),
(215, 21, 11, 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `sub_kriteria`
--

CREATE TABLE `sub_kriteria` (
  `id_sub_kriteria` int(11) NOT NULL,
  `id_kriteria` int(11) NOT NULL,
  `sub_kriteria` varchar(50) NOT NULL,
  `nilai` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id_user` int(5) NOT NULL,
  `username` varchar(16) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama` varchar(70) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `role` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id_user`, `username`, `password`, `nama`, `email`, `role`) VALUES
(16, 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', 'ghifari', 'admin@gmail.com', '1'),
(18, 'fajar', 'd033e22ae348aeb5660fc2140aec35850c4da997', 'fajar', 'fajar123131@gmail.com', '2');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `alternatif`
--
ALTER TABLE `alternatif`
  ADD PRIMARY KEY (`id_alternatif`);

--
-- Indeks untuk tabel `hasil`
--
ALTER TABLE `hasil`
  ADD PRIMARY KEY (`id_hasil`),
  ADD KEY `fk_hasil` (`id_alternatif`);

--
-- Indeks untuk tabel `kriteria`
--
ALTER TABLE `kriteria`
  ADD PRIMARY KEY (`id_kriteria`);

--
-- Indeks untuk tabel `penilaian`
--
ALTER TABLE `penilaian`
  ADD PRIMARY KEY (`id_penilaian`),
  ADD KEY `fk_penilaian_alternatif` (`id_alternatif`),
  ADD KEY `fk_penilaian_kriteria` (`id_kriteria`);

--
-- Indeks untuk tabel `sub_kriteria`
--
ALTER TABLE `sub_kriteria`
  ADD PRIMARY KEY (`id_sub_kriteria`),
  ADD KEY `fk_sub_kriteria_id_kriteria` (`id_kriteria`);

--
-- Indeks untuk tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `alternatif`
--
ALTER TABLE `alternatif`
  MODIFY `id_alternatif` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT untuk tabel `hasil`
--
ALTER TABLE `hasil`
  MODIFY `id_hasil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `kriteria`
--
ALTER TABLE `kriteria`
  MODIFY `id_kriteria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT untuk tabel `penilaian`
--
ALTER TABLE `penilaian`
  MODIFY `id_penilaian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=216;

--
-- AUTO_INCREMENT untuk tabel `sub_kriteria`
--
ALTER TABLE `sub_kriteria`
  MODIFY `id_sub_kriteria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT untuk tabel `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `hasil`
--
ALTER TABLE `hasil`
  ADD CONSTRAINT `fk_hasil` FOREIGN KEY (`id_alternatif`) REFERENCES `alternatif` (`id_alternatif`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `penilaian`
--
ALTER TABLE `penilaian`
  ADD CONSTRAINT `fk_penilaian_alternatif` FOREIGN KEY (`id_alternatif`) REFERENCES `alternatif` (`id_alternatif`),
  ADD CONSTRAINT `fk_penilaian_kriteria` FOREIGN KEY (`id_kriteria`) REFERENCES `kriteria` (`id_kriteria`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `sub_kriteria`
--
ALTER TABLE `sub_kriteria`
  ADD CONSTRAINT `fk_sub_kriteria_id_kriteria` FOREIGN KEY (`id_kriteria`) REFERENCES `kriteria` (`id_kriteria`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
