-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 21, 2026 at 01:13 PM
-- Server version: 8.4.3
-- PHP Version: 8.3.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `photostudiodb`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id` int NOT NULL,
  `nama_customer` varchar(100) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `no_telp` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `jenis_member` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `nama_customer`, `alamat`, `no_telp`, `email`, `jenis_member`) VALUES
(1, 'Andi', 'Jl. Merdeka No.1', '081211122233', 'andi@mail.com', 'Reguler'),
(2, 'Budi', 'Jl. Merdeka No.2', '081211122244', 'budi@mail.com', 'VIP'),
(3, 'Citra', 'Jl. Merdeka No.3', '081211122255', 'citra@mail.com', 'Reguler'),
(4, 'Dewi Ratna', 'Jl. Merdeka No.4', '081211122266', 'dewi@mail.com', 'VIP');

-- --------------------------------------------------------

--
-- Table structure for table `detail_pembelian`
--

CREATE TABLE `detail_pembelian` (
  `id` int NOT NULL,
  `qty` int DEFAULT NULL,
  `harga` bigint DEFAULT NULL,
  `subtotal` bigint DEFAULT NULL,
  `id_pembelian` int DEFAULT NULL,
  `id_produk` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `detail_pembelian`
--

INSERT INTO `detail_pembelian` (`id`, `qty`, `harga`, `subtotal`, `id_pembelian`, `id_produk`) VALUES
(1, 100, 1500, 150000, 1, 1),
(2, 5, 150000, 750000, 2, 2),
(3, 10, 40000, 400000, 3, 3),
(4, 2, 200000, 400000, 4, 4),
(5, 5, 25000, 125000, 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `detail_penjualan`
--

CREATE TABLE `detail_penjualan` (
  `id` int NOT NULL,
  `qty` int DEFAULT NULL,
  `harga` bigint DEFAULT NULL,
  `subtotal` bigint DEFAULT NULL,
  `id_penjualan` int DEFAULT NULL,
  `id_produk` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `detail_penjualan`
--

INSERT INTO `detail_penjualan` (`id`, `qty`, `harga`, `subtotal`, `id_penjualan`, `id_produk`) VALUES
(1, 10, 3000, 30000, 1, 1),
(2, 1, 250000, 250000, 2, 2),
(3, 1, 75000, 75000, 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `foto`
--

CREATE TABLE `foto` (
  `id` int NOT NULL,
  `nama_file` varchar(255) DEFAULT NULL,
  `path_file` varchar(255) DEFAULT NULL,
  `tanggal_unggah` date DEFAULT NULL,
  `deskripsi` varchar(255) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `id_jadwal` int DEFAULT NULL,
  `id_fotografer` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `foto`
--

INSERT INTO `foto` (`id`, `nama_file`, `path_file`, `tanggal_unggah`, `deskripsi`, `status`, `id_jadwal`, `id_fotografer`) VALUES
(1, 'foto1.jpg', '/upload/foto1.jpg', '2025-10-15', 'Hasil sesi portrait Andi', 'Aktif', 1, 1),
(2, 'foto2.jpg', '/upload/foto2.jpg', '2025-10-16', 'Dokumentasi wedding Budi', 'Aktif', 2, 2),
(4, 'foto4.jpg', '/upload/foto4.jpg', '2025-10-18', 'Keluarga Dewi', 'Aktif', 4, 4),
(5, 'foto5.jpg', '/upload/foto5.jpg', '2025-10-19', 'Event kantor Eka', 'Aktif', 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `fotografer`
--

CREATE TABLE `fotografer` (
  `id` int NOT NULL,
  `nama_fotografer` varchar(100) DEFAULT NULL,
  `no_telp` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `spesialisasi` varchar(50) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `id_user` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `fotografer`
--

INSERT INTO `fotografer` (`id`, `nama_fotografer`, `no_telp`, `email`, `spesialisasi`, `alamat`, `id_user`) VALUES
(1, 'Fajar Hermawan', '083145678912', 'fajar@mail.com', 'Pernikahan', 'Jl. Melati No.3', 3),
(2, 'Yuda', '081345678911', 'yuda@mail.com', 'Produk', 'Jl. Sakura No.4', 6),
(4, 'Novi Andini', '081345678933', 'novi@mail.com', 'Keluarga', 'Jl. Kamboja No.6', 1),
(5, 'Adit Wijawa', '081345678944', 'adit@mail.com', 'Event', 'Jl. Teratai No.7', 1);

-- --------------------------------------------------------

--
-- Table structure for table `jadwal_foto`
--

CREATE TABLE `jadwal_foto` (
  `id` int NOT NULL,
  `tanggal` date DEFAULT NULL,
  `jenis_sesi` varchar(100) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `id_fotografer` int DEFAULT NULL,
  `id_customer` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `jadwal_foto`
--

INSERT INTO `jadwal_foto` (`id`, `tanggal`, `jenis_sesi`, `status`, `id_fotografer`, `id_customer`) VALUES
(1, '2025-10-15', 'Studio Portrait', 'Selesai', 1, 1),
(2, '2025-10-16', 'Outdoor Wedding', 'Selesai', 2, 2),
(4, '2025-10-18', 'Family Session', 'Selesai', 4, 4),
(5, '2025-10-19', 'Wisuda', 'Proses', 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `id` int NOT NULL,
  `nama_kategori` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id`, `nama_kategori`) VALUES
(1, 'Cetak Foto'),
(2, 'Album Foto'),
(3, 'Frame Kayu'),
(4, 'Kanvas'),
(5, 'Kolase Polaroid');

-- --------------------------------------------------------

--
-- Table structure for table `pembelian`
--

CREATE TABLE `pembelian` (
  `id` int NOT NULL,
  `tanggal` date DEFAULT NULL,
  `metode_bayar` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `total` bigint DEFAULT NULL,
  `id_user` int DEFAULT NULL,
  `id_suplier` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `pembelian`
--

INSERT INTO `pembelian` (`id`, `tanggal`, `metode_bayar`, `status`, `total`, `id_user`, `id_suplier`) VALUES
(1, '2025-10-01', 'Transfer', 'Selesai', 1500000, 1, 1),
(2, '2025-10-02', 'Tunai', 'Selesai', 1000000, 1, 2),
(3, '2025-10-03', 'Transfer', 'Selesai', 750000, 1, 3),
(4, '2025-10-04', 'Transfer', 'Selesai', 500000, 1, 4),
(5, '2025-10-05', 'Transfer', 'Selesai', 2000000, 1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `penjualan`
--

CREATE TABLE `penjualan` (
  `id` int NOT NULL,
  `tanggal` date DEFAULT NULL,
  `invoice` int DEFAULT NULL,
  `metode_bayar` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `total` bigint DEFAULT NULL,
  `id_user` int DEFAULT NULL,
  `id_customer` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `penjualan`
--

INSERT INTO `penjualan` (`id`, `tanggal`, `invoice`, `metode_bayar`, `status`, `total`, `id_user`, `id_customer`) VALUES
(1, '2025-10-10', 1001, 'Tunai', 'Selesai', 50000, 2, 1),
(2, '2025-10-11', 1002, 'Transfer', 'Selesai', 250000, 2, 2),
(3, '2025-10-12', 1003, 'Tunai', 'Selesai', 75000, 2, 3);

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id` int NOT NULL,
  `nama_produk` varchar(100) DEFAULT NULL,
  `deskripsi` varchar(255) DEFAULT NULL,
  `harga_jual` bigint DEFAULT NULL,
  `harga_beli` bigint DEFAULT NULL,
  `stok` int DEFAULT NULL,
  `id_kategori` int DEFAULT NULL,
  `id_suplier` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id`, `nama_produk`, `deskripsi`, `harga_jual`, `harga_beli`, `stok`, `id_kategori`, `id_suplier`) VALUES
(1, 'Cetak Foto 10x15', 'Cetak foto ukuran 10x15cm, hasil tajam dan glossy.', 3000, 1500, 500, 1, 1),
(2, 'Album Premium', 'Album foto hardcover dengan 20 halaman.', 250000, 150000, 20, 2, 2),
(3, 'Frame Kayu 20x60', 'Bingkai kayu solid dengan kaca bening.', 75000, 40000, 40, 3, 3),
(4, 'Cetak Kanvas 60x90', 'Cetak foto besar di media kanvas kualitas tinggi.', 350000, 200000, 15, 4, 4),
(5, 'Kolase Polaroid 9pcs', 'Satu set kolase 9 foto ukuran 3x4 polaroid.', 50000, 25000, 35, 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `suplier`
--

CREATE TABLE `suplier` (
  `id` int NOT NULL,
  `nama_suplier` varchar(100) DEFAULT NULL,
  `no_telp` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `perusahaan` varchar(100) DEFAULT NULL,
  `nama_bank` varchar(100) DEFAULT NULL,
  `nama_akun_bank` varchar(100) DEFAULT NULL,
  `no_akun_bank` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `suplier`
--

INSERT INTO `suplier` (`id`, `nama_suplier`, `no_telp`, `email`, `alamat`, `perusahaan`, `nama_bank`, `nama_akun_bank`, `no_akun_bank`) VALUES
(1, 'CV Fototek', '081233344455', 'fototek@mail.com', 'Jl. Cempaka No.1', 'Fototek', 'BCA', 'CV Fototek', '1234567890'),
(2, 'StudioPlus', '081233344466', 'studioplus@mail.com', 'Jl. Anggrek No.2', 'Studio Plus', 'Mandiri', 'StudioPlus', '2233445566'),
(3, 'LensPro', '081233344477', 'lenspro@mail.com', 'Jl. Melati No.3', 'Lens Pro', 'BRI', 'LensPro', '3344556677'),
(4, 'MegaPrint', '081233344488', 'megaprint@mail.com', 'Jl. Dahlia No.4', 'Mega Print', 'BNI', 'MegaPrint', '4455667788'),
(5, 'LightGear', '081233344499', 'lightgear@mail.com', 'Jl. Mawar No.5', 'Light Gear', 'BCA', 'LightGear', '5566778899');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `nama_user` varchar(100) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `hak_akses` varchar(50) DEFAULT NULL,
  `no_telp` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `nama_user`, `username`, `password`, `hak_akses`, `no_telp`, `email`, `alamat`) VALUES
(1, 'Habiel Khafi', 'habel', '12345', 'Admin', '081234567890', 'habielsky004@mail.com', 'Jl. Merpati No.1'),
(2, 'Rina Zaukiah', 'rina01', 'abc123', 'Admin', '082134567891', 'rina@mail.com', 'Jl. Anggrek No.2'),
(3, 'Fajar Hermawan', 'fajar12', 'passf', 'Admin', '083145678912', 'fajar@mail.com', 'Jl. Melati No.3'),
(5, 'Doni Kaciw', 'doniph', 'passd', 'Fotografer', '082156789014', 'doni@mail.com', 'Jl. Dahlia No.5'),
(6, 'Yuda', 'yuda11', 'yuda123', 'fotografer', '081345678911', 'yuda@mail.com', 'Jl. Sakura No.4');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `detail_pembelian`
--
ALTER TABLE `detail_pembelian`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_detail_pembelian_pembelian` (`id_pembelian`),
  ADD KEY `fk_detail_pembelian_produk` (`id_produk`);

--
-- Indexes for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_detail_penjualan_penjualan` (`id_penjualan`),
  ADD KEY `fk_detail_penjualan_produk` (`id_produk`);

--
-- Indexes for table `foto`
--
ALTER TABLE `foto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_foto_jadwal` (`id_jadwal`),
  ADD KEY `fk_foto_fotografer` (`id_fotografer`);

--
-- Indexes for table `fotografer`
--
ALTER TABLE `fotografer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user` (`id_user`);

--
-- Indexes for table `jadwal_foto`
--
ALTER TABLE `jadwal_foto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_jadwal_foto_fotografer` (`id_fotografer`),
  ADD KEY `fk_jadwal_foto_customer` (`id_customer`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pembelian`
--
ALTER TABLE `pembelian`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_pembelian_user` (`id_user`),
  ADD KEY `fk_pembelian_suplier` (`id_suplier`);

--
-- Indexes for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_penjualan_user` (`id_user`),
  ADD KEY `fk_penjualan_customer` (`id_customer`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_produk_kategori` (`id_kategori`),
  ADD KEY `fk_produk_suplier` (`id_suplier`);

--
-- Indexes for table `suplier`
--
ALTER TABLE `suplier`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `detail_pembelian`
--
ALTER TABLE `detail_pembelian`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `foto`
--
ALTER TABLE `foto`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `fotografer`
--
ALTER TABLE `fotografer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `jadwal_foto`
--
ALTER TABLE `jadwal_foto`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pembelian`
--
ALTER TABLE `pembelian`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `penjualan`
--
ALTER TABLE `penjualan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `suplier`
--
ALTER TABLE `suplier`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_pembelian`
--
ALTER TABLE `detail_pembelian`
  ADD CONSTRAINT `fk_detail_pembelian_pembelian` FOREIGN KEY (`id_pembelian`) REFERENCES `pembelian` (`id`),
  ADD CONSTRAINT `fk_detail_pembelian_produk` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id`);

--
-- Constraints for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  ADD CONSTRAINT `fk_detail_penjualan_penjualan` FOREIGN KEY (`id_penjualan`) REFERENCES `penjualan` (`id`),
  ADD CONSTRAINT `fk_detail_penjualan_produk` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id`);

--
-- Constraints for table `foto`
--
ALTER TABLE `foto`
  ADD CONSTRAINT `fk_foto_fotografer` FOREIGN KEY (`id_fotografer`) REFERENCES `fotografer` (`id`),
  ADD CONSTRAINT `fk_foto_jadwal` FOREIGN KEY (`id_jadwal`) REFERENCES `jadwal_foto` (`id`);

--
-- Constraints for table `fotografer`
--
ALTER TABLE `fotografer`
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);

--
-- Constraints for table `jadwal_foto`
--
ALTER TABLE `jadwal_foto`
  ADD CONSTRAINT `fk_jadwal_foto_customer` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id`),
  ADD CONSTRAINT `fk_jadwal_foto_fotografer` FOREIGN KEY (`id_fotografer`) REFERENCES `fotografer` (`id`);

--
-- Constraints for table `pembelian`
--
ALTER TABLE `pembelian`
  ADD CONSTRAINT `fk_pembelian_suplier` FOREIGN KEY (`id_suplier`) REFERENCES `suplier` (`id`),
  ADD CONSTRAINT `fk_pembelian_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);

--
-- Constraints for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD CONSTRAINT `fk_penjualan_customer` FOREIGN KEY (`id_customer`) REFERENCES `customer` (`id`),
  ADD CONSTRAINT `fk_penjualan_user` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);

--
-- Constraints for table `produk`
--
ALTER TABLE `produk`
  ADD CONSTRAINT `fk_produk_kategori` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id`),
  ADD CONSTRAINT `fk_produk_suplier` FOREIGN KEY (`id_suplier`) REFERENCES `suplier` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
