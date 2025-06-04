-- Laptops ThinkPad
INSERT INTO computers (model, serial_number, status, specs) VALUES
('ThinkPad X1 Carbon', 'TP-X1-001', 'AVAILABLE', 'Intel i7 11th Gen, 16GB RAM, 512GB SSD, Windows 11 Pro'),
('ThinkPad T14s', 'TP-T14-002', 'AVAILABLE', 'AMD Ryzen 7, 32GB RAM, 1TB SSD, Windows 11 Pro'),
('ThinkPad P1', 'TP-P1-003', 'AVAILABLE', 'Intel i9, 64GB RAM, 2TB SSD, NVIDIA RTX 3080, Windows 11 Pro');

-- MacBooks
INSERT INTO computers (model, serial_number, status, specs) VALUES
('MacBook Pro 14"', 'MB-P14-001', 'AVAILABLE', 'M1 Pro, 16GB RAM, 512GB SSD, macOS Monterey'),
('MacBook Pro 16"', 'MB-P16-002', 'AVAILABLE', 'M1 Max, 32GB RAM, 1TB SSD, macOS Monterey'),
('MacBook Air', 'MB-AIR-003', 'AVAILABLE', 'M2, 16GB RAM, 512GB SSD, macOS Monterey');

-- Dell XPS
INSERT INTO computers (model, serial_number, status, specs) VALUES
('Dell XPS 13', 'DL-XPS13-001', 'AVAILABLE', 'Intel i7 12th Gen, 16GB RAM, 512GB SSD, Windows 11 Pro'),
('Dell XPS 15', 'DL-XPS15-002', 'AVAILABLE', 'Intel i9 12th Gen, 32GB RAM, 1TB SSD, RTX 3050 Ti, Windows 11 Pro'),
('Dell XPS 17', 'DL-XPS17-003', 'AVAILABLE', 'Intel i9 12th Gen, 64GB RAM, 2TB SSD, RTX 3060, Windows 11 Pro');

-- Workstations
INSERT INTO computers (model, serial_number, status, specs) VALUES
('HP ZBook Fury', 'HP-ZB-001', 'AVAILABLE', 'Intel Xeon W, 128GB RAM, 4TB SSD, RTX A5000, Windows 11 Pro'),
('Dell Precision', 'DL-PR-002', 'AVAILABLE', 'Intel i9, 64GB RAM, 2TB SSD, RTX A4000, Windows 11 Pro');

-- Query para verificar la inserción
SELECT model, serial_number, status, 
       SUBSTRING(specs, 1, 50) as specs_preview 
FROM computers 
ORDER BY model;
