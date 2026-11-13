-- ==============================================================================
-- PRUTASAN FRESH FRUIT STORE & POS MANAGEMENT SYSTEM
-- MySQL / MariaDB (XAMPP phpMyAdmin) Complete Database Schema & Seed Data
-- Database Name: prutasan_db
-- ==============================================================================

CREATE DATABASE IF NOT EXISTS `prutasan_db` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `prutasan_db`;

-- 1. ACCOUNTS & ROLES TABLE
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts` (
    `id` VARCHAR(50) PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) UNIQUE NOT NULL,
    `role` ENUM('Admin', 'Manager', 'Cashier') NOT NULL,
    `status` ENUM('Active', 'Inactive', 'Suspended') NOT NULL DEFAULT 'Active',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `accounts` (`id`, `name`, `email`, `role`, `status`) VALUES
('acc-01', 'John Pirante', 'john@prutasan.ph', 'Admin', 'Active'),
('acc-02', 'Recca Maglasang', 'recca@prutasan.ph', 'Manager', 'Active'),
('acc-03', 'Blake Book', 'blake@prutasan.ph', 'Cashier', 'Active')
ON DUPLICATE KEY UPDATE `name`=VALUES(`name`);

-- 2. FRUIT INVENTORY TABLE
DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory` (
    `id` VARCHAR(50) PRIMARY KEY,
    `sku` VARCHAR(100) UNIQUE NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `category` VARCHAR(100) NOT NULL,
    `price` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    `stock` INT NOT NULL DEFAULT 0,
    `expiry_date` VARCHAR(50) DEFAULT 'N/A',
    `icon` VARCHAR(50) DEFAULT '🍎',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `inventory` (`id`, `sku`, `name`, `category`, `price`, `stock`, `expiry_date`, `icon`) VALUES
('inv-01', '4801001', 'Fuji Apple (Crisp Sweet, per kg)', 'Apples and Pears', 160.00, 35, '2026-11-15', '🍎'),
('inv-02', '4801002', 'Cavendish Bananas (Fresh Batch, per kg)', 'Bananas and Berries', 85.00, 8, '2026-11-04', '🍌'),
('inv-03', '4801003', 'Sweet Ripe Mango (Carabao, per kg)', 'Tropical Fruits', 210.00, 24, '2026-11-08', '🥭'),
('inv-04', '4801004', 'Navel Sweet Oranges (Pack of 5)', 'Citrus', 140.00, 5, '2026-11-12', '🍊'),
('inv-05', '4801005', 'Davao Red Seedless Watermelon (Whole)', 'Melons', 240.00, 15, '2026-11-10', '🍉'),
('inv-06', '4801006', 'Imported Red Seedless Grapes (500g Tub)', 'Bananas and Berries', 215.00, 3, '2026-11-05', '🍇'),
('inv-07', '4801007', 'Davao Golden Pomelo (Box / 2pcs)', 'Citrus', 280.00, 18, '2026-11-20', '🍈'),
('inv-08', '4801008', 'Fresh Dragon Fruit (Red Flesh, per kg)', 'Exotic and Seasonal', 190.00, 12, '2026-11-07', '🫐')
ON DUPLICATE KEY UPDATE `sku`=VALUES(`sku`);

-- 3. FRUIT SUPPLIERS TABLE
DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE `suppliers` (
    `id` VARCHAR(50) PRIMARY KEY,
    `company_name` VARCHAR(255) NOT NULL,
    `contact_person` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(50) NOT NULL,
    `category` VARCHAR(100) NOT NULL,
    `status` VARCHAR(50) NOT NULL DEFAULT 'Aktibo',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `suppliers` (`id`, `company_name`, `contact_person`, `phone`, `category`, `status`) VALUES
('sup-01', 'Davao Golden Orchard Agri Supply', 'Mang Jose Rodriguez', '0917-888-2341', 'Tropical Fruits', 'Aktibo'),
('sup-02', 'Benguet Highland Farm Harvest', 'Aling Teresa Baguio', '0918-555-9012', 'Bananas and Berries', 'Aktibo'),
('sup-03', 'Manila Port Fruit Importers Co.', 'David Tan', '0920-777-4433', 'Imported Fruits', 'Aktibo')
ON DUPLICATE KEY UPDATE `company_name`=VALUES(`company_name`);

-- 4. SALES TRANSACTIONS TABLE
DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
    `id` VARCHAR(50) PRIMARY KEY,
    `ref_number` VARCHAR(100) UNIQUE NOT NULL,
    `payment_method` VARCHAR(50) NOT NULL,
    `items_summary` TEXT NOT NULL,
    `items_json` JSON,
    `total_amount` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    `items_count` INT NOT NULL DEFAULT 1,
    `processed_by` VARCHAR(255) NOT NULL,
    `status` VARCHAR(50) NOT NULL DEFAULT 'Completed',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `transactions` (`id`, `ref_number`, `payment_method`, `items_summary`, `items_json`, `total_amount`, `items_count`, `processed_by`, `status`) VALUES
('trx-01', 'TRX-98214', 'Cash', 'Fuji Apple (x2 kg)', '[{"sku":"4801001","name":"Fuji Apple (Matamis, bawat kilo)","price":160,"qty":2}]', 320.00, 2, 'Blake Book', 'Completed')
ON DUPLICATE KEY UPDATE `ref_number`=VALUES(`ref_number`);

-- 5. HR & PAYROLL TABLE
DROP TABLE IF EXISTS `payroll`;
CREATE TABLE `payroll` (
    `id` VARCHAR(50) PRIMARY KEY,
    `employee_name` VARCHAR(255) NOT NULL,
    `hourly_rate` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    `worked_hours` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    `gross_salary` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    `deductions` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    `net_salary` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `payroll` (`id`, `employee_name`, `hourly_rate`, `worked_hours`, `gross_salary`, `deductions`, `net_salary`) VALUES
('pay-01', 'John Pirante (May-ari / Admin)', 150.00, 80, 12000.00, 850.00, 11150.00),
('pay-02', 'Recca Maglasang (May-ari / Manager)', 140.00, 80, 11200.00, 780.00, 10420.00),
('pay-03', 'Blake Book (Kaha / Cashier)', 95.00, 80, 7600.00, 650.00, 6950.00);

-- 6. SYSTEM AUDIT LOGS TABLE
DROP TABLE IF EXISTS `system_logs`;
CREATE TABLE `system_logs` (
    `id` VARCHAR(50) PRIMARY KEY,
    `time` VARCHAR(50) NOT NULL,
    `user` VARCHAR(255) NOT NULL,
    `module` VARCHAR(100) NOT NULL,
    `action` TEXT NOT NULL,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `system_logs` (`id`, `time`, `user`, `module`, `action`) VALUES
('log-01', '5:45 PM', 'John Pirante', 'Auth', 'User logged in as Admin'),
('log-02', '5:32 PM', 'Recca Maglasang', 'Inventory', 'Restocked Cavendish Bananas (+15 kg)'),
('log-03', '1:45 PM', 'Blake Book', 'POS', 'Completed fruit transaction TRX-98214 (Cash)');
