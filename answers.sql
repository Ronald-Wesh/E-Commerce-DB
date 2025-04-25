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