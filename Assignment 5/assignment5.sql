SELECT DISTINCT a.city FROM agents a, orders o, customers c WHERE (c.name='Tiptop') AND (o.cid = c.cid) AND (a.aid = o.aid);
SELECT DISTINCT o1.pid FROM orders o1, orders o2, customers c WHERE (c.city='Kyoto') AND (o2.cid = c.cid) AND (o1.aid = o2.aid);
SELECT name FROM customers WHERE cid NOT IN (SELECT cid FROM orders);
SELECT DISTINCT c.name FROM customers c LEFT OUTER JOIN orders o ON c.cid = o.cid WHERE o.cid is null;
SELECT DISTINCT c.name "Customer_Name", a.name "Agent_Name" FROM orders o, customers c LEFT OUTER JOIN agents a ON c.city = a.city WHERE o.aid = a.aid AND c.cid = o.cid
SELECT c.name "Customer_Name", a.name "Agent_Name", c.city "City" FROM agents a, customers c WHERE a.city = c.city;
SELECT DISTINCT customers.name, customers.city FROM customers WHERE customers.city IN (SELECT city FROM (SELECT p2.city, count(*) AS city_count FROM products p2 GROUP BY p2.city) AS city_count ORDER BY city_count ASC LIMIT 1);