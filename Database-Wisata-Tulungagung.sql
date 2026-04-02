CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password TEXT NOT NULL,
    role VARCHAR(10) DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE user_profiles (
    profile_id SERIAL PRIMARY KEY,
    user_id INT UNIQUE,
    phone VARCHAR(20),
    address TEXT,
    birth_date DATE,
    CONSTRAINT fk_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE);

CREATE TABLE destinations (
    destination_id SERIAL PRIMARY KEY,
    user_id INT,
    name VARCHAR(150) NOT NULL,
    location VARCHAR(150),
    description TEXT,
    ticket_price NUMERIC(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_creator
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE SET NULL);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL);

CREATE TABLE destination_categories (
    id SERIAL PRIMARY KEY,
    destination_id INT,
    category_id INT,
    CONSTRAINT fk_destination
        FOREIGN KEY (destination_id)
        REFERENCES destinations(destination_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_category
        FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
        ON DELETE CASCADE);

INSERT INTO users (name, email, password, role) VALUES
('Admin Utama', 'admin@wisata.id', '123456', 'admin'),
('Salsabila Jasmine', 'bila@gmail.com', '123456', 'user'),
('Budi Santoso', 'budi@gmail.com', '123456', 'user'),
('Siti Aminah', 'siti@gmail.com', '123456', 'user'),
('Rizky Pratama', 'rizky@gmail.com', '123456', 'user'),
('Ahmad Fauzi', 'ahmad.fauzi@gmail.com', '123456', 'user'),
('Dewi Lestari', 'dewi.lestari@gmail.com', '123456', 'user'),
('Rizky Saputra', 'rizky.saputra@gmail.com', '123456', 'user'),
('Siti Nurhaliza', 'siti.nurhaliza@gmail.com', '123456', 'user'),
('Andi Pratama', 'andi.pratama@gmail.com', '123456', 'user'),
('Putri Maharani', 'putri.maharani@gmail.com', '123456', 'user'),
('Budi Hartono', 'budi.hartono@gmail.com', '123456', 'user'),
('Rina Kurniawati', 'rina.kurniawati@gmail.com', '123456', 'user'),
('Fajar Nugroho', 'fajar.nugroho@gmail.com', '123456', 'user'),
('Intan Permata', 'intan.permata@gmail.com', '123456', 'user');

INSERT INTO user_profiles (user_id, phone, address, birth_date) VALUES
(1, '081111111111', 'Tulungagung Kota', '1995-05-10'),
(2, '082222222222', 'Kediri', '2003-08-21'),
(3, '083333333333', 'Blitar', '1998-02-14'),
(4, '084444444444', 'Trenggalek', '2001-11-30'),
(5, '085555555555', 'Malang', '1997-07-19'),
(6, '081234567801', 'Tulungagung', '1998-02-10'),
(7, '081234567802', 'Kediri', '2000-05-21'),
(8, '081234567803', 'Blitar', '1999-08-15'),
(9, '081234567804', 'Malang', '2001-11-30'),
(10, '081234567805', 'Surabaya', '1997-07-12'),
(11, '081234567806', 'Trenggalek', '1996-03-25'),
(12, '081234567807', 'Jombang', '1995-09-18'),
(13, '081234567808', 'Nganjuk', '1998-12-05'),
(14, '081234567809', 'Madiun', '2002-04-09'),
(15, '081234567810', 'Kediri', '2001-06-17');

INSERT INTO categories (category_name) VALUES
('Pantai'),
('Religi'),
('Alam'),
('Edukasi'),
('Sejarah');
('Spot Foto'),
('Camping');

INSERT INTO destinations 
(user_id, name, location, description, ticket_price) VALUES

(1, 'Pantai Popoh', 'Besuki', 
 'Pantai populer dengan pemandangan indah', 10000),

(1, 'Pantai Sine', 'Kalidawir', 
 'Pantai dengan ombak besar dan sunrise indah', 8000),

(1, 'Pantai Kedung Tumpang', 'Pucanglaban', 
 'Kolam alami di tepi laut', 5000),

(1, 'Goa Pasir', 'Pagerwojo', 
 'Wisata alam dan petualangan', 5000),

(1, 'Waduk Wonorejo', 'Pagerwojo', 
 'Waduk terbesar di Tulungagung', 7000),

(1, 'Makam Sunan Kuning', 'Ngunut', 
 'Wisata religi terkenal', 0),

(1, 'Bukit Jomblo', 'Besuki', 
 'Spot foto romantis di atas bukit', 5000),

(1, 'Taman Aloon-Aloon', 'Kota Tulungagung', 
 'Taman kota Tulungagung tempat untuk bersantai sejenak dari kesibukan', 0),

(1, 'Museum Daerah', 'Kota Tulungagung', 
 'Wisata edukasi dan sejarah', 3000),

(1, 'Air Terjun Lawean', 'Sendang', 
 'Air terjun alami di pegunungan', 5000);

 INSERT INTO destination_categories (destination_id, category_id) VALUES
 (1,1), (1,3), (1,6), (1,7),
 (2,1), (2,3), (2,6), (2,7),
 (3,1), (3,3), (3,6),
 (4,3), (4,6),
 (5,3), (5,6), 
 (6,2),
 (7,3), (7,6),
 (8,4), (8,6),
 (9,4), (9,5),
 (10,3), (10,6);

SELECT * FROM destinations; 

SELECT name, location, ticket_price
FROM destinations
JOIN destination_categories USING (destination_id)
JOIN categories USING (category_id)
WHERE category_name = 'Pantai';

SELECT table_name 
FROM information_schema.tables
WHERE table_schema = 'public';

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'destinations';
