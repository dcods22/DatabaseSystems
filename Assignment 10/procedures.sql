CREATE OR REPLACE FUNCTION PreReqsFor(wantedCourse int) RETURNS 
table(prereqnum integer) as $$

	SELECT prereqnum FROM prerequisites WHERE coursenum = wantedCourse

$$ language 'sql';

CREATE OR REPLACE FUNCTION isPreReqsFor(wantedPreReqNum int) RETURNS 
table(prereqnum integer) as $$

	SELECT prereqnum FROM prerequisites WHERE prereqnum = wantedPreReqNum

$$ language 'sql';

CREATE OR REPLACE FUNCTION MostUsedForum() RETURNS 
TABLE (forumName text, count integer) as $$

	SELECT forumID, max(num) FROM (SELECT forumID, COUNT(forumID) as num FROM subForums GROUP BY forumID) subForums GROUP BY forumID ORDER BY MAX DESC LIMIT 1;
	
$$ language 'sql' $$