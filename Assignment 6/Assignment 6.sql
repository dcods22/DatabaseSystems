SELECT DISTINCT c.name, c.city
FROM customers c
WHERE c.city IN (SELECT city FROM 
	(SELECT p2.city, count(*) AS city_count
	FROM products p2
	GROUP BY p2.city) 
		AS city_count 
		ORDER BY city_count DESC
		LIMIT 1) LIMIT 1;
	
		
SELECT c.name, c.city
FROM customers c
WHERE c.city IN (SELECT city FROM 
	(SELECT p2.city, count(*) AS city_count
	FROM products p2
	GROUP BY p2.city) 
		AS city_count 
		ORDER BY city_count DESC
		LIMIT 1);
	
		
SELECT name 
FROM products
WHERE priceUSD > 
	(SELECT avg(priceUSD) 
	 FROM products)
		ORDER BY name ASC;
		
		
SELECT c.name, o.pid, o.dollars 
FROM customers c
	INNER JOIN orders o ON o.cid = c.cid
	ORDER BY dollars ASC;
	
	
SELECT c.name, coalesce(o.qty, '0') AS "Order Total"
FROM customers c
	LEFT OUTER JOIN orders o ON o.cid = c.cid
	ORDER BY c.name ASC;
	

SELECT DISTINCT c.name, p.name, a.name
FROM orders o1
	INNER JOIN customers c ON c.cid = o1.cid 
	INNER JOIN products p ON p.pid = o1.pid
	INNER JOIN orders o2 ON o2.aid = o1.aid
	INNER JOIN agents a ON (a.aid = o1.aid AND a.city = 'New York')
		ORDER BY c.name asc;
		

SELECT o.ordno, o.dollars AS "Accuracy of Total Costs"
FROM orders o 
WHERE o.dollars NOT IN (
	SELECT((p.priceUSD * o.qty) - ((c.discount * .01) * (p.priceUSD * o.qty))) 
	AS totalCost
	FROM customers c
	INNER JOIN orders o ON o.cid = c.cid
	INNER JOIN products p ON p.pid = o.pid
		ORDER BY o.dollars);
