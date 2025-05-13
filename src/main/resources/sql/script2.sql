UPDATE product_variants
SET stock_quantity = 11
WHERE product_id = (SELECT product_id FROM products WHERE name = 'KAPPA Women''s Sneakers')
  AND color = 'yellow'
  AND size = '36';

UPDATE product_stocks
SET quantity_on_hand = 11
WHERE product_id = (SELECT product_id FROM products WHERE name = 'KAPPA Women''s Sneakers')
  AND store_id = (SELECT store_id FROM stores WHERE name = 'KAPPA Store - Nguyễn Huệ');

INSERT INTO users (name, email, phone) VALUES
                                           ('User2', 'user2@gmail.com', '0902000002'),
                                           ('User3', 'user3@gmail.com', '0902000003'),
                                           ('User4', 'user4@gmail.com', '0902000004'),
                                           ('User5', 'user5@gmail.com', '0902000005'),
                                           ('User6', 'user6@gmail.com', '0902000006'),
                                           ('User7', 'user7@gmail.com', '0902000007'),
                                           ('User8', 'user8@gmail.com', '0902000008'),
                                           ('User9', 'user9@gmail.com', '0902000009'),
                                           ('User10', 'user10@gmail.com', '0902000010'),
                                           ('User11', 'user11@gmail.com', '0902000011');

INSERT INTO addresses (user_id, commune_id, street, housing_type_id)
SELECT user_id, 1, CONCAT(user_id, ' Street Address'), 1
FROM users
WHERE email IN ('user2@gmail.com', 'user3@gmail.com', 'user4@gmail.com', 'user5@gmail.com',
                'user6@gmail.com', 'user7@gmail.com', 'user8@gmail.com', 'user9@gmail.com',
                'user10@gmail.com', 'user11@gmail.com');

INSERT INTO orders (user_id, address_id, order_date, payment_method, total_amount)
SELECT u.user_id, a.address_id, '2024-11-01 10:00:00', 'COD', 980000
FROM users u
         JOIN addresses a ON u.user_id = a.user_id
WHERE u.email = 'user2@gmail.com';

INSERT INTO order_details (order_id, variant_id, store_id, quantity, unit_price)
SELECT o.order_id, pv.variant_id, s.store_id, 1, 980000
FROM orders o
         JOIN users u ON o.user_id = u.user_id
         JOIN product_variants pv ON pv.color = 'yellow' AND pv.size = '36'
         JOIN products p ON pv.product_id = p.product_id
         JOIN stores s ON s.name = 'KAPPA Store - Nguyễn Huệ'
WHERE u.email = 'user2@gmail.com'
  AND p.name = 'KAPPA Women''s Sneakers'
  AND o.order_date = '2024-11-01 10:00:00';

INSERT INTO orders (user_id, address_id, order_date, payment_method, total_amount)
SELECT u.user_id, a.address_id, '2024-11-02 10:00:00', 'COD', 980000
FROM users u
         JOIN addresses a ON u.user_id = a.user_id
WHERE u.email = 'user3@gmail.com';

INSERT INTO order_details (order_id, variant_id, store_id, quantity, unit_price)
SELECT o.order_id, pv.variant_id, s.store_id, 1, 980000
FROM orders o
         JOIN users u ON o.user_id = u.user_id
         JOIN product_variants pv ON pv.color = 'yellow' AND pv.size = '36'
         JOIN products p ON pv.product_id = p.product_id
         JOIN stores s ON s.name = 'KAPPA Store - Nguyễn Huệ'
WHERE u.email = 'user3@gmail.com'
  AND p.name = 'KAPPA Women''s Sneakers'
  AND o.order_date = '2024-11-02 10:00:00';

INSERT INTO orders (user_id, address_id, order_date, payment_method, total_amount)
SELECT u.user_id, a.address_id, '2024-11-03 10:00:00', 'COD', 980000
FROM users u
         JOIN addresses a ON u.user_id = a.user_id
WHERE u.email = 'user4@gmail.com';

INSERT INTO order_details (order_id, variant_id, store_id, quantity, unit_price)
SELECT o.order_id, pv.variant_id, s.store_id, 1, 980000
FROM orders o
         JOIN users u ON o.user_id = u.user_id
         JOIN product_variants pv ON pv.color = 'yellow' AND pv.size = '36'
         JOIN products p ON pv.product_id = p.product_id
         JOIN stores s ON s.name = 'KAPPA Store - Nguyễn Huệ'
WHERE u.email = 'user4@gmail.com'
  AND p.name = 'KAPPA Women''s Sneakers'
  AND o.order_date = '2024-11-03 10:00:00';

INSERT INTO orders (user_id, address_id, order_date, payment_method, total_amount)
SELECT u.user_id, a.address_id, '2024-11-04 10:00:00', 'COD', 980000
FROM users u
         JOIN addresses a ON u.user_id = a.user_id
WHERE u.email = 'user5@gmail.com';

INSERT INTO order_details (order_id, variant_id, store_id, quantity, unit_price)
SELECT o.order_id, pv.variant_id, s.store_id, 1, 980000
FROM orders o
         JOIN users u ON o.user_id = u.user_id
         JOIN product_variants pv ON pv.color = 'yellow' AND pv.size = '36'
         JOIN products p ON pv.product_id = p.product_id
         JOIN stores s ON s.name = 'KAPPA Store - Nguyễn Huệ'
WHERE u.email = 'user5@gmail.com'
  AND p.name = 'KAPPA Women''s Sneakers'
  AND o.order_date = '2024-11-04 10:00:00';

INSERT INTO orders (user_id, address_id, order_date, payment_method, total_amount)
SELECT u.user_id, a.address_id, '2025-04-01 10:00:00', 'COD', 980000
FROM users u
         JOIN addresses a ON u.user_id = a.user_id
WHERE u.email = 'user6@gmail.com';

INSERT INTO order_details (order_id, variant_id, store_id, quantity, unit_price)
SELECT o.order_id, pv.variant_id, s.store_id, 1, 980000
FROM orders o
         JOIN users u ON o.user_id = u.user_id
         JOIN product_variants pv ON pv.color = 'yellow' AND pv.size = '36'
         JOIN products p ON pv.product_id = p.product_id
         JOIN stores s ON s.name = 'KAPPA Store - Nguyễn Huệ'
WHERE u.email = 'user6@gmail.com'
  AND p.name = 'KAPPA Women''s Sneakers'
  AND o.order_date = '2025-04-01 10:00:00';

INSERT INTO orders (user_id, address_id, order_date, payment_method, total_amount)
SELECT u.user_id, a.address_id, '2025-04-02 10:00:00', 'COD', 980000
FROM users u
         JOIN addresses a ON u.user_id = a.user_id
WHERE u.email = 'user7@gmail.com';

INSERT INTO order_details (order_id, variant_id, store_id, quantity, unit_price)
SELECT o.order_id, pv.variant_id, s.store_id, 1, 980000
FROM orders o
         JOIN users u ON o.user_id = u.user_id
         JOIN product_variants pv ON pv.color = 'yellow' AND pv.size = '36'
         JOIN products p ON pv.product_id = p.product_id
         JOIN stores s ON s.name = 'KAPPA Store - Nguyễn Huệ'
WHERE u.email = 'user7@gmail.com'
  AND p.name = 'KAPPA Women''s Sneakers'
  AND o.order_date = '2025-04-02 10:00:00';

INSERT INTO orders (user_id, address_id, order_date, payment_method, total_amount)
SELECT u.user_id, a.address_id, '2025-04-03 10:00:00', 'COD', 980000
FROM users u
         JOIN addresses a ON u.user_id = a.user_id
WHERE u.email = 'user8@gmail.com';

INSERT INTO order_details (order_id, variant_id, store_id, quantity, unit_price)
SELECT o.order_id, pv.variant_id, s.store_id, 1, 980000
FROM orders o
         JOIN users u ON o.user_id = u.user_id
         JOIN product_variants pv ON pv.color = 'yellow' AND pv.size = '36'
         JOIN products p ON pv.product_id = p.product_id
         JOIN stores s ON s.name = 'KAPPA Store - Nguyễn Huệ'
WHERE u.email = 'user8@gmail.com'
  AND p.name = 'KAPPA Women''s Sneakers'
  AND o.order_date = '2025-04-03 10:00:00';

INSERT INTO orders (user_id, address_id, order_date, payment_method, total_amount)
SELECT u.user_id, a.address_id, '2025-04-04 10:00:00', 'COD', 980000
FROM users u
         JOIN addresses a ON u.user_id = a.user_id
WHERE u.email = 'user9@gmail.com';

INSERT INTO order_details (order_id, variant_id, store_id, quantity, unit_price)
SELECT o.order_id, pv.variant_id, s.store_id, 1, 980000
FROM orders o
         JOIN users u ON o.user_id = u.user_id
         JOIN product_variants pv ON pv.color = 'yellow' AND pv.size = '36'
         JOIN products p ON pv.product_id = p.product_id
         JOIN stores s ON s.name = 'KAPPA Store - Nguyễn Huệ'
WHERE u.email = 'user9@gmail.com'
  AND p.name = 'KAPPA Women''s Sneakers'
  AND o.order_date = '2025-04-04 10:00:00';

INSERT INTO orders (user_id, address_id, order_date, payment_method, total_amount)
SELECT u.user_id, a.address_id, '2025-04-05 10:00:00', 'COD', 980000
FROM users u
         JOIN addresses a ON u.user_id = a.user_id
WHERE u.email = 'user10@gmail.com';

INSERT INTO order_details (order_id, variant_id, store_id, quantity, unit_price)
SELECT o.order_id, pv.variant_id, s.store_id, 1, 980000
FROM orders o
         JOIN users u ON o.user_id = u.user_id
         JOIN product_variants pv ON pv.color = 'yellow' AND pv.size = '36'
         JOIN products p ON pv.product_id = p.product_id
         JOIN stores s ON s.name = 'KAPPA Store - Nguyễn Huệ'
WHERE u.email = 'user10@gmail.com'
  AND p.name = 'KAPPA Women''s Sneakers'
  AND o.order_date = '2025-04-05 10:00:00';

INSERT INTO orders (user_id, address_id, order_date, payment_method, total_amount)
SELECT u.user_id, a.address_id, '2025-04-06 10:00:00', 'COD', 980000
FROM users u
         JOIN addresses a ON u.user_id = a.user_id
WHERE u.email = 'user11@gmail.com';

INSERT INTO order_details (order_id, variant_id, store_id, quantity, unit_price)
SELECT o.order_id, pv.variant_id, s.store_id, 1, 980000
FROM orders o
         JOIN users u ON o.user_id = u.user_id
         JOIN product_variants pv ON pv.color = 'yellow' AND pv.size = '36'
         JOIN products p ON pv.product_id = p.product_id
         JOIN stores s ON s.name = 'KAPPA Store - Nguyễn Huệ'
WHERE u.email = 'user11@gmail.com'
  AND p.name = 'KAPPA Women''s Sneakers'
  AND o.order_date = '2025-04-06 10:00:00';