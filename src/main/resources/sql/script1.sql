DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE users (
                       user_id INT PRIMARY KEY AUTO_INCREMENT,
                       name VARCHAR(100) NOT NULL,
                       email VARCHAR(100) NOT NULL UNIQUE,
                       phone VARCHAR(20) UNIQUE,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE provinces (
                           province_id INT PRIMARY KEY,
                           name VARCHAR(100) NOT NULL
);

CREATE TABLE districts (
                           district_id INT PRIMARY KEY,
                           name VARCHAR(100) NOT NULL,
                           province_id INT NOT NULL,
                           FOREIGN KEY (province_id) REFERENCES provinces(province_id)
);

CREATE TABLE communes (
                          commune_id INT PRIMARY KEY,
                          name VARCHAR(100) NOT NULL,
                          district_id INT NOT NULL,
                          FOREIGN KEY (district_id) REFERENCES districts(district_id)
);

CREATE TABLE housing_types (
                               housing_type_id INT PRIMARY KEY,
                               name VARCHAR(50) NOT NULL
);

CREATE TABLE addresses (
                           address_id INT PRIMARY KEY AUTO_INCREMENT,
                           user_id INT NOT NULL,
                           commune_id INT NOT NULL,
                           street VARCHAR(100),
                           housing_type_id INT,
                           created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                           updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                           FOREIGN KEY (user_id) REFERENCES users(user_id),
                           FOREIGN KEY (commune_id) REFERENCES communes(commune_id),
                           FOREIGN KEY (housing_type_id) REFERENCES housing_types(housing_type_id)
);

CREATE TABLE categories (
                            category_id INT PRIMARY KEY AUTO_INCREMENT,
                            name VARCHAR(100) NOT NULL
);

CREATE TABLE brands (
                        brand_id INT PRIMARY KEY AUTO_INCREMENT,
                        name VARCHAR(100) NOT NULL
);

CREATE TABLE category_discounts (
                                    category_discount_id INT PRIMARY KEY AUTO_INCREMENT,
                                    category_id INT NOT NULL,
                                    discount_percent DECIMAL(5,2),
                                    valid_from DATE,
                                    valid_to DATE,
                                    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE products (
                          product_id INT PRIMARY KEY AUTO_INCREMENT,
                          name VARCHAR(100) NOT NULL,
                          category_id INT NOT NULL,
                          brand_id INT NOT NULL,
                          base_price DECIMAL(10,2),
                          description TEXT,
                          gender VARCHAR(20) NOT NULL,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          FOREIGN KEY (category_id) REFERENCES categories(category_id),
                          FOREIGN KEY (brand_id) REFERENCES brands(brand_id)
);

CREATE TABLE product_discounts (
                                   product_discount_id INT PRIMARY KEY AUTO_INCREMENT,
                                   product_id INT NOT NULL,
                                   discount_percent DECIMAL(5,2),
                                   valid_from DATE,
                                   valid_to DATE,
                                   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                   updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                   FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE product_variants (
                                  variant_id INT PRIMARY KEY AUTO_INCREMENT,
                                  product_id INT NOT NULL,
                                  color VARCHAR(30),
                                  size VARCHAR(10),
                                  stock_quantity INT,
                                  price_adjustment DECIMAL(12,2),
                                  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE stores (
                        store_id INT PRIMARY KEY AUTO_INCREMENT,
                        name VARCHAR(100) NOT NULL,
                        location VARCHAR(255),
                        description VARCHAR(255),
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE product_stocks (
                                id SERIAL PRIMARY KEY,
                                product_id INT NOT NULL,
                                store_id INT NOT NULL,
                                quantity_on_hand INT DEFAULT 0,
                                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                FOREIGN KEY (product_id) REFERENCES products(product_id),
                                FOREIGN KEY (store_id) REFERENCES stores(store_id),
                                UNIQUE (product_id, store_id)
);

CREATE TABLE vouchers (
                          voucher_id INT PRIMARY KEY AUTO_INCREMENT,
                          code VARCHAR(50) UNIQUE,
                          discount_percent DECIMAL(5,2),
                          valid_from DATE,
                          valid_to DATE,
                          voucher_type VARCHAR(255) NOT NULL,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE orders (
                        order_id INT PRIMARY KEY AUTO_INCREMENT,
                        user_id INT NOT NULL,
                        address_id INT NOT NULL,
                        order_date DATETIME,
                        payment_method VARCHAR(30),
                        total_amount DECIMAL(12,2),
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        FOREIGN KEY (user_id) REFERENCES users(user_id),
                        FOREIGN KEY (address_id) REFERENCES addresses(address_id)
);

CREATE TABLE order_details (
                               order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
                               order_id INT NOT NULL,
                               variant_id INT NOT NULL,
                               store_id INT NOT NULL,
                               quantity INT,
                               unit_price DECIMAL(10,2),
                               created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                               updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                               FOREIGN KEY (order_id) REFERENCES orders(order_id),
                               FOREIGN KEY (variant_id) REFERENCES product_variants(variant_id),
                               FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

CREATE TABLE order_fees (
                            order_fee_id INT PRIMARY KEY AUTO_INCREMENT,
                            order_id INT NOT NULL,
                            fee_type VARCHAR(50),
                            amount DECIMAL(10,2),
                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                            FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE order_discounts (
                                 order_discount_id INT PRIMARY KEY AUTO_INCREMENT,
                                 order_fee_id INT NOT NULL,
                                 voucher_id INT NOT NULL,
                                 discount_amount DECIMAL(10,2),
                                 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                 FOREIGN KEY (order_fee_id) REFERENCES order_fees(order_fee_id),
                                 FOREIGN KEY (voucher_id) REFERENCES vouchers(voucher_id)
);

CREATE TABLE product_images (
                                image_id SERIAL PRIMARY KEY,
                                product_id INT NOT NULL,
                                image_url TEXT NOT NULL,
                                is_main BOOLEAN DEFAULT FALSE,
                                FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- Question B:
INSERT INTO provinces (province_id, name)
VALUES (1, 'Bắc Kạn');

INSERT INTO districts (district_id, name, province_id)
VALUES (1, 'Ba Bể', 1);

INSERT INTO communes (commune_id, name, district_id)
VALUES (1, 'Phúc Lộc', 1);

INSERT INTO housing_types (housing_type_id, name)
VALUES (1, 'Nhà riêng');

INSERT INTO users (name, email, phone)
VALUES ('assessment', 'gu@gmail.com', '328355333');

INSERT INTO addresses (user_id, commune_id, street, housing_type_id)
SELECT user_id, 1, '73 tân hòa 2', 1
FROM users
WHERE email = 'gu@gmail.com';

INSERT INTO categories (name)
VALUES ('Giày nữ');

INSERT INTO brands (name)
VALUES ('KAPPA');

INSERT INTO products (name, category_id, brand_id, base_price, gender)
VALUES ('KAPPA Women''s Sneakers',
        (SELECT category_id FROM categories WHERE name = 'Giày nữ'),
        (SELECT brand_id FROM brands WHERE name = 'KAPPA'),
        980000, 'Nữ');

INSERT INTO product_variants (product_id, color, size, stock_quantity, price_adjustment)
SELECT product_id, 'yellow', '36', 1, 0
FROM products
WHERE name = 'KAPPA Women''s Sneakers';

INSERT INTO stores (name, location, description)
VALUES ('KAPPA Store - Nguyễn Huệ', '52 Nguyễn Huệ, Quận 1, TP.HCM', 'Ngã ba Mạc Thị Bưởi và Nguyễn Huệ');

INSERT INTO product_stocks (product_id, store_id, quantity_on_hand)
SELECT p.product_id, s.store_id, 1
FROM products p
         CROSS JOIN stores s
WHERE p.name = 'KAPPA Women''s Sneakers'
  AND s.name = 'KAPPA Store - Nguyễn Huệ';

INSERT INTO orders (user_id, address_id, order_date, payment_method, total_amount)
SELECT u.user_id, a.address_id, NOW(), 'COD', 980000
FROM users u
         JOIN addresses a ON u.user_id = a.user_id
WHERE u.email = 'gu@gmail.com';

INSERT INTO order_details (order_id, variant_id, store_id, quantity, unit_price)
SELECT o.order_id, pv.variant_id, s.store_id, 1, 980000
FROM orders o
         JOIN users u ON o.user_id = u.user_id
         JOIN product_variants pv ON pv.color = 'yellow' AND pv.size = '36'
         JOIN products p ON pv.product_id = p.product_id
         JOIN stores s ON s.name = 'KAPPA Store - Nguyễn Huệ'
WHERE u.email = 'gu@gmail.com'
  AND p.name = 'KAPPA Women''s Sneakers'
  AND o.order_date = (SELECT MAX(order_date) FROM orders WHERE user_id = u.user_id);


-- Question C:
SELECT SUM(od.quantity * od.unit_price), o.order_date
FROM orders o
         JOIN order_details od ON o.order_id = od.order_id
WHERE YEAR(o.order_date) = YEAR(CURDATE())
GROUP BY o.order_date;


SELECT ROUND(AVG(object_value)), MONTH(month_in_year)
FROM (
    SELECT SUM(od.quantity * od.unit_price) AS object_value, o.order_date AS month_in_year
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    WHERE YEAR(o.order_date) = YEAR(CURDATE())
    GROUP BY o.order_date
    ) AS ovmiy
GROUP BY MONTH(month_in_year)
ORDER BY MONTH(month_in_year) ASC;

-- Question D:
SELECT DISTINCT u.user_id
FROM users u
         LEFT JOIN orders o ON u.user_id = o.user_id
    AND o.order_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
WHERE o.order_id IS NULL;

SELECT COUNT(DISTINCT o.user_id) AS count_customer_buy_in_12month
FROM orders o
WHERE o.order_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 12 MONTH) AND DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

SELECT COUNT(DISTINCT old_customer) AS count_customer_buy_in_12month
FROM (
         SELECT DISTINCT u.user_id AS old_customer
         FROM users u
                  LEFT JOIN orders o ON u.user_id = o.user_id
             AND o.order_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
         WHERE o.user_id IS NULL
     ) AS churn_candidate
         JOIN orders o2 ON o2.user_id = churn_candidate.old_customer
WHERE o2.order_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
          AND DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

WITH ChurnedCustomers AS (
    SELECT COUNT(DISTINCT old_customer) AS count_customer_buy_in_12month
    FROM (
             SELECT DISTINCT u.user_id AS old_customer
             FROM users u
                      LEFT JOIN orders o ON u.user_id = o.user_id
                 AND o.order_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
             WHERE o.user_id IS NULL
         ) AS churn_candidate
             JOIN orders o2 ON o2.user_id = churn_candidate.old_customer
    WHERE o2.order_date BETWEEN DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
              AND DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
),
     TotalCustomers AS (
         SELECT COUNT(DISTINCT user_id) AS total_customers
         FROM orders
         WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
     )
SELECT
    ROUND((churned.count_customer_buy_in_12month / total_customers.total_customers) * 100, 2) AS churn_rate
FROM ChurnedCustomers churned
         CROSS JOIN TotalCustomers total_customers
WHERE total_customers.total_customers > 0;