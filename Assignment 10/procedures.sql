CREATE OR REPLACE FUNCTION PreReqsFor(wantedCourse int) RETURNS 
table(prereqnum integer) as $$

	SELECT prereqnum FROM prerequisites WHERE coursenum = wantedCourse

$$ language 'sql';

CREATE OR REPLACE FUNCTION isPreReqsFor(wantedPreReqNum int) RETURNS 
table(prereqnum integer) as $$

	SELECT prereqnum FROM prerequisites WHERE prereqnum = wantedPreReqNum

$$ language 'sql';

