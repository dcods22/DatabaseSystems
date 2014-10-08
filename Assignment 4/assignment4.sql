SELECT city FROM agents WHERE aid IN 
	(SELECT aid FROM orders WHERE cid IN (SELECT cid FROM customers WHERE name='Tiptop'));

SELECT DISTINCT pid FROM orders WHERE aid IN (SELECT aid FROM orders WHERE cid IN 
	(SELECT cid FROM customers WHERE city='Kyoto'));

SELECT cid, name FROM customers WHERE cid in 
	(SELECT cid FROM orders WHERE aid != 'a04');

SELECT cid, name FROM customers WHERE cid in 
	(SELECT cid FROM orders WHERE pid = 'p01' INTERSECT 
	(SELECT cid from orders WHERE pid = 'p07'));

SELECT pid FROM orders WHERE aid = 'a04';

SELECT name, discount FROM customers WHERE cid in 
	(SELECT cid FROM orders WHERE aid in 
	(SELECT aid FROM agents WHERE city = 'Dallas' OR city = 'Newark'));

SELECT * FROM customers WHERE discount in 
	(SELECT discount FROM customers WHERE city = 'Dallas') OR discount in 
	(SELECT discount FROM customers WHERE city = 'Kyoto');