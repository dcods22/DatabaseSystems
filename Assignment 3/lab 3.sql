SELECT name, city FROM agents WHERE name='Bond';
SELECT pid, name, quantity FROM products WHERE priceusd >= '.99';
SELECT ordno, qty FROM orders;
SELECT name, city FROM customers WHERE city='Duluth';
SELECT name FROM agents WHERE city != 'New York' AND city != 'London';
SELECT * from products WHERE city != 'Dallas' OR (city = 'Deluth' AND priceusd < '1'); 
SELECT * from orders WHERE mon='jan' OR mon='apr';
SELECT * from orders WHERE mon='feb' AND dollars > '200';
SELECT * from customers WHERE cid='c005';