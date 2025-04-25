-- Create databse

CREATE DATABASE Ecommerce;

-- Table: brand
CREATE TABLE brand (
    brand_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    logo_url VARCHAR(255)
);

-- Table: product_category
CREATE TABLE product_category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    parent_id INT,
    FOREIGN KEY (parent_id) REFERENCES product_category(category_id)
);

-- Table: product
CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    base_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id)
);

-- Table: color
CREATE TABLE color (
    color_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    hex_value CHAR(7),
    image VARCHAR(255)
);

-- Table: size_category
CREATE TABLE size_category (
    size_category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

-- Table: size_option
CREATE TABLE size_option (
    size_option_id INT PRIMARY KEY AUTO_INCREMENT,
    size_category_id INT NOT NULL,
    label VARCHAR(255) NOT NULL,
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

-- Table: product_variation
CREATE TABLE product_variation (
    variation_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    color_id INT,
    size_option_id INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id)
);

-- Table: product_item
CREATE TABLE product_item (
    product_item_id INT PRIMARY KEY AUTO_INCREMENT,
    sku VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    variation_id INT NOT NULL,
    FOREIGN KEY (variation_id) REFERENCES product_variation(variation_id)
);

-- Table: attribute_type
CREATE TABLE attribute_type (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

-- Table: attribute_category
CREATE TABLE attribute_category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

-- Table: product_attribute
CREATE TABLE product_attribute (
    attribute_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    attribute_category_id INT NOT NULL,
    type_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    value TEXT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(category_id),
    FOREIGN KEY (type_id) REFERENCES attribute_type(type_id)
);

-- Table: product_image
CREATE TABLE product_image (
    image_id INT PRIMARY KEY AUTO_INCREMENT,
    url VARCHAR(255) NOT NULL,
    alt_text VARCHAR(255),
    product_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);


-- inserting test data

-- brand table 
INSERT INTO brand (name, description, logo_url) VALUES
('Nike', 'Just Do It. World leader in athletic footwear and apparel.', 'https://nike.com/logos/nike.png'),
('Adidas', 'German multinational corporation that designs and manufactures shoes.', 'https://addidas.com/logos/adidas.png'),
('Apple', 'Technology company specializing in consumer electronics.', 'https://apple.com/logos/apple.png'),
('Samsung', 'South Korean multinational electronics company.', 'https://samsung.com/logos/samsung.png'),
('Levi''s', 'American clothing company known for its denim jeans.', 'https://levis.com/logos/levis.png');

-- product_category table
INSERT INTO product_category (name, description, parent_id) VALUES
('Electronics', 'Devices and gadgets', 1),
('Clothing', 'Apparel and fashion items', 2),
('Footwear', 'Shoes and boots', 3),
('Smartphones', 'Mobile phones with advanced computing capability', 4),
('Laptops', 'Portable personal computers', 5),
('Jeans', 'Denim pants', 6),
('T-Shirts', 'Short-sleeved casual tops', 7),
('Running Shoes', 'Footwear designed for running', 8),
('Sneakers', 'Casual athletic shoes', 9);

-- product table
INSERT INTO product (name, brand_id, base_price)
SELECT 'iPhone 15 Pro', brand_id, 999.00 FROM brand WHERE name = 'Apple'
UNION ALL
SELECT 'Galaxy S23 Ultra', brand_id, 1199.00 FROM brand WHERE name = 'Samsung'
UNION ALL
SELECT 'MacBook Pro 16"', brand_id, 2499.00 FROM brand WHERE name = 'Apple'
UNION ALL
SELECT '501 Original Fit Jeans', brand_id, 59.50 FROM brand WHERE name = 'Levi''s'
UNION ALL
SELECT 'Air Force 1', brand_id, 110.00 FROM brand WHERE name = 'Nike'
UNION ALL
SELECT 'Ultraboost 22', brand_id, 180.00 FROM brand WHERE name = 'Adidas'
UNION ALL
SELECT 'Classic Cotton T-Shirt', brand_id, 19.99 FROM brand WHERE name = 'Levi''s'
UNION ALL
SELECT 'Dri-FIT Running Shirt', brand_id, 29.99 FROM brand WHERE name = 'Nike';

-- color table
INSERT INTO color (name, hex_value, image) VALUES
('Black', '#000000', 'https://colors/black.jpg'),
('White', '#FFFFFF', 'https://colors/white.jpg'),
('Blue', '#0000FF', 'https://colors/blue.jpg'),
('Red', '#FF0000', 'https://colors/red.jpg'),
('Space Gray', '#343D46', 'https://colors/spacegray.jpg'),
('Silver', '#C0C0C0', 'https://colors/silver.jpg'),
('Indigo', '#4B0082', 'https://colors/indigo.jpg'),
('Green', '#008000', 'https://colors/green.jpg');


-- size_category table
INSERT INTO size_category (name) VALUES
('Clothing'),
('Footwear'),
('Electronics');

-- size_option table
INSERT INTO size_option (size_category_id, label) VALUES
(1, 'XS'), (1, 'S'), (1, 'M'), (1, 'L'), (1, 'XL'), (1, 'XXL'),
(2, 'US 7'), (2, 'US 8'), (2, 'US 9'), (2, 'US 10'), (2, 'US 11'), (2, 'US 12'),
(3, '64GB'), (3, '128GB'), (3, '256GB'), (3, '512GB'), (3, '1TB');


-- product_variation table
-- MacBook Pro variations
INSERT INTO product_variation (product_id, color_id, size_option_id)
SELECT 
    p.product_id, 
    c.color_id, 
    s.size_option_id
FROM 
    (SELECT product_id FROM product WHERE name = 'MacBook Pro 16"') p,
    (SELECT color_id FROM color WHERE name IN ('Space Gray', 'Silver')) c,
    (SELECT size_option_id FROM size_option WHERE label IN ('256GB', '512GB', '1TB')) s;

-- Jeans variations
INSERT INTO product_variation (product_id, color_id, size_option_id)
SELECT 
    p.product_id, 
    c.color_id, 
    s.size_option_id
FROM 
    (SELECT product_id FROM product WHERE name = '501 Original Fit Jeans') p,
    (SELECT color_id FROM color WHERE name IN ('Black', 'Blue')) c,
    (SELECT size_option_id FROM size_option WHERE label IN ('M', 'L', 'XL')) s;


-- MacBook Pro variations
INSERT INTO product_variation (product_id, color_id, size_option_id)
SELECT 
    p.product_id, 
    c.color_id, 
    s.size_option_id
FROM 
    (SELECT product_id FROM product WHERE name = 'MacBook Pro 16"') p,
    (SELECT color_id FROM color WHERE name IN ('Space Gray', 'Silver')) c,
    (SELECT size_option_id FROM size_option WHERE label IN ('256GB', '512GB', '1TB')) s;

-- Jeans variations
INSERT INTO product_variation (product_id, color_id, size_option_id)
SELECT 
    p.product_id, 
    c.color_id, 
    s.size_option_id
FROM 
    (SELECT product_id FROM product WHERE name = '501 Original Fit Jeans') p,
    (SELECT color_id FROM color WHERE name IN ('Black', 'Blue')) c,
    (SELECT size_option_id FROM size_option WHERE label IN ('M', 'L', 'XL')) s;


INSERT INTO product_variation (product_id, color_id, size_option_id)
SELECT 
    p.product_id, 
    c.color_id, 
    s.size_option_id
FROM 
    (SELECT product_id FROM product WHERE name = 'MacBook Pro 16"') p,
    (SELECT color_id FROM color WHERE name IN ('Space Gray', 'Silver')) c,
    (SELECT size_option_id FROM size_option WHERE label IN ('256GB', '512GB', '1TB')) s;

-- Jeans variations
INSERT INTO product_variation (product_id, color_id, size_option_id)
SELECT 
    p.product_id, 
    c.color_id, 
    s.size_option_id
FROM 
    (SELECT product_id FROM product WHERE name = '501 Original Fit Jeans') p,
    (SELECT color_id FROM color WHERE name IN ('Black', 'Blue')) c,
    (SELECT size_option_id FROM size_option WHERE label IN ('M', 'L', 'XL')) s;




-- product_item table





INSERT INTO product_item (sku, price, stock_quantity, variation_id)
SELECT 
    CONCAT('IP15P-',
           CASE WHEN c.name = 'Space Gray' THEN 'SG' ELSE 'SL' END,
           '-',
           REPLACE(so.label, 'GB', '')
          ) AS sku,
    CASE 
        WHEN so.label = '64GB' THEN 999.00
        WHEN so.label = '128GB' THEN 1099.00
        WHEN so.label = '256GB' THEN 1199.00
        WHEN so.label = '512GB' THEN 1399.00
        WHEN so.label = '1TB' THEN 1599.00
    END AS price,
    CASE 
        WHEN so.label = '64GB' AND c.name = 'Space Gray' THEN 50
        WHEN so.label = '128GB' AND c.name = 'Space Gray' THEN 45
        WHEN so.label = '256GB' AND c.name = 'Space Gray' THEN 40
        WHEN so.label = '512GB' AND c.name = 'Space Gray' THEN 35
        WHEN so.label = '1TB' AND c.name = 'Space Gray' THEN 30
        WHEN so.label = '64GB' AND c.name = 'Silver' THEN 48
        WHEN so.label = '128GB' AND c.name = 'Silver' THEN 43
        WHEN so.label = '256GB' AND c.name = 'Silver' THEN 38
        WHEN so.label = '512GB' AND c.name = 'Silver' THEN 33
        WHEN so.label = '1TB' AND c.name = 'Silver' THEN 28
    END AS stock_quantity,
    pv.variation_id
FROM product_variation pv
JOIN product p ON pv.product_id = p.product_id
JOIN color c ON pv.color_id = c.color_id
JOIN size_option so ON pv.size_option_id = so.size_option_id
WHERE p.name = 'iPhone 15 Pro'
AND c.name IN ('Space Gray', 'Silver')
AND so.label IN ('64GB', '128GB', '256GB', '512GB', '1TB');

-- Galaxy S23 items
INSERT INTO product_item (sku, price, stock_quantity, variation_id)
SELECT 
    CONCAT('GS23U-',
           CASE WHEN c.name = 'Black' THEN 'BK' ELSE 'GN' END,
           '-',
           REPLACE(so.label, 'GB', '')
          ) AS sku,
    CASE 
        WHEN so.label = '64GB' THEN 1199.00
        WHEN so.label = '128GB' THEN 1299.00
        WHEN so.label = '256GB' THEN 1399.00
        WHEN so.label = '512GB' THEN 1599.00
        WHEN so.label = '1TB' THEN 1799.00
    END AS price,
    CASE 
        WHEN so.label = '64GB' AND c.name = 'Black' THEN 40
        WHEN so.label = '128GB' AND c.name = 'Black' THEN 35
        WHEN so.label = '256GB' AND c.name = 'Black' THEN 30
        WHEN so.label = '512GB' AND c.name = 'Black' THEN 25
        WHEN so.label = '1TB' AND c.name = 'Black' THEN 20
        WHEN so.label = '64GB' AND c.name = 'Green' THEN 38
        WHEN so.label = '128GB' AND c.name = 'Green' THEN 33
        WHEN so.label = '256GB' AND c.name = 'Green' THEN 28
        WHEN so.label = '512GB' AND c.name = 'Green' THEN 23
        WHEN so.label = '1TB' AND c.name = 'Green' THEN 18
    END AS stock_quantity,
    pv.variation_id
FROM product_variation pv
JOIN product p ON pv.product_id = p.product_id
JOIN color c ON pv.color_id = c.color_id
JOIN size_option so ON pv.size_option_id = so.size_option_id
WHERE p.name = 'Galaxy S23 Ultra'
AND c.name IN ('Black', 'Green')
AND so.label IN ('64GB', '128GB', '256GB', '512GB', '1TB');

-- MacBook Pro items
INSERT INTO product_item (sku, price, stock_quantity, variation_id)
SELECT 
    CONCAT('MBP16-',
           CASE WHEN c.name = 'Space Gray' THEN 'SG' ELSE 'SL' END,
           '-',
           REPLACE(so.label, 'GB', '')
          ) AS sku,
    CASE 
        WHEN so.label = '256GB' THEN 2499.00
        WHEN so.label = '512GB' THEN 2699.00
        WHEN so.label = '1TB' THEN 2999.00
    END AS price,
    CASE 
        WHEN so.label = '256GB' AND c.name = 'Space Gray' THEN 20
        WHEN so.label = '512GB' AND c.name = 'Space Gray' THEN 18
        WHEN so.label = '1TB' AND c.name = 'Space Gray' THEN 15
        WHEN so.label = '256GB' AND c.name = 'Silver' THEN 19
        WHEN so.label = '512GB' AND c.name = 'Silver' THEN 17
        WHEN so.label = '1TB' AND c.name = 'Silver' THEN 14
    END AS stock_quantity,
    pv.variation_id
FROM product_variation pv
JOIN product p ON pv.product_id = p.product_id
JOIN color c ON pv.color_id = c.color_id
JOIN size_option so ON pv.size_option_id = so.size_option_id
WHERE p.name = 'MacBook Pro 16"'
AND c.name IN ('Space Gray', 'Silver')
AND so.label IN ('256GB', '512GB', '1TB');


-- product_attribute table
INSERT INTO attribute_type (name) VALUES
('Text'), ('Number'), ('Boolean'), ('Color'), ('Size'), ('Weight'), ('Dimension');


-- attribute_category table
INSERT INTO attribute_category (name) VALUES
('General'), ('Technical'), ('Material'), ('Care'), ('Dimensions'), ('Performance');

-- product_attribute table-- Jeans attributes
INSERT INTO product_attribute (product_id, attribute_category_id, type_id, name, value)
SELECT 
    p.product_id,
    ac.category_id,
    at.type_id,
    attr.name,
    attr.value
FROM 
    (SELECT '501 Original Fit Jeans' AS product_name, 'Material' AS category_name, 'Text' AS type_name, 'Material' AS name, '100% Cotton denim' AS value UNION ALL
     SELECT '501 Original Fit Jeans', 'Care', 'Text', 'Care Instructions', 'Machine wash cold, tumble dry low' UNION ALL
     SELECT '501 Original Fit Jeans', 'Dimensions', 'Dimension', 'Fit', 'Original fit - Straight leg' UNION ALL
     SELECT '501 Original Fit Jeans', 'General', 'Text', 'Closure', 'Button fly' UNION ALL
     SELECT '501 Original Fit Jeans', 'General', 'Text', 'Pockets', '5 pockets') attr
JOIN product p ON p.name = attr.product_name
JOIN attribute_category ac ON ac.name = attr.category_name
JOIN attribute_type at ON at.name = attr.type_name;

-- Air Force 1 attributes
INSERT INTO product_attribute (product_id, attribute_category_id, type_id, name, value)
SELECT 
    p.product_id,
    ac.category_id,
    at.type_id,
    attr.name,
    attr.value
FROM 
    (SELECT 'Air Force 1' AS product_name, 'Material' AS category_name, 'Text' AS type_name, 'Upper Material' AS name, 'Leather' AS value UNION ALL
     SELECT 'Air Force 1', 'Material', 'Text', 'Sole Material', 'Rubber' UNION ALL
     SELECT 'Air Force 1', 'Dimensions', 'Dimension', 'Shaft Height', 'Low-top' UNION ALL
     SELECT 'Air Force 1', 'Performance', 'Text', 'Cushioning', 'Nike Air cushioning' UNION ALL
     SELECT 'Air Force 1', 'General', 'Text', 'Closure', 'Lace-up') attr
JOIN product p ON p.name = attr.product_name
JOIN attribute_category ac ON ac.name = attr.category_name
JOIN attribute_type at ON at.name = attr.type_name;
