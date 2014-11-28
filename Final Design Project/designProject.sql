--Create Statements--
CREATE TABLE Forums (
	ForumID serial NOT NULL,
	ForumName text NOT NULL, 
PRIMARY KEY(ForumID) 
);

CREATE TABLE SubForums (
	SubForumID serial NOT NULL,
	ForumID integer NOT NULL REFERENCES Forums(ForumID),
	SubForumName text NOT NULL, 
PRIMARY KEY(SubForumID) 
);

CREATE TABLE Users (
	UserID serial NOT NULL,
	Username text NOT NULL,
	Avatar text DEFAULT 'Avatar.png',
	FirstName text NOT NULL,
	LastName text NOT NULL,
	Facebook text DEFAULT 'facebook.com',
	Twitter text DEFAULT 'twitter.com',
	Tumlbr text DEFAULT 'tumblr.com', 
PRIMARY KEY(UserID) 
);

CREATE TABLE Posts (
	PostID serial NOT NULL,
	ForumID integer NOT NULL REFERENCES Forums(ForumID),
	SubForumID integer NOT NULL REFERENCES SubForums(SubForumID), 
	UserID integer NOT NULL REFERENCES Users(UserID), 
	Post text NOT NULL, 
	DatePosted date NOT NULL,
PRIMARY KEY(PostID)  
);

CREATE TABLE Messages (
	MessageID serial NOT NULL,
	SenderID integer NOT NULL,
	ReceiverID integer NOT NULL,
	Message text NOT NULL,
	DatePosted date NOT NULL,
PRIMARY KEY(MessageID) 
);

CREATE TABLE ItemExchange (
	ItemID serial NOT NULL,
	SellerID integer NOT NULL REFERENCES Users(UserID),
	ItemName text NOT NULL,
	ItemPrice integer NOT NULL,
	ItemDesc text NOT NULL,
	DatePosted date NOT NULL,
PRIMARY KEY(ItemID) 
);

CREATE TABLE Offers (
	OfferID serial NOT NULL,
	ItemID integer NOT NULL REFERENCES ItemExchange(ItemID),
	UserID integer NOT NULL REFERENCES Users(UserID),
	OfferPrice integer NOT NULL,
	OfferDesc text NOT NULL,
PRIMARY KEY(OfferID) 
);

CREATE OR REPLACE VIEW PostInfo 
AS
	SELECT f.ForumName, s.SubForumName, u.UserName, p.Post, p.DatePosted 
	FROM Users u 
	INNER JOIN Posts p ON p.UserID = u.UserID
	INNER JOIN Subforums s ON p.SubForumID = s.SubForumID
	INNER JOIN Forums F ON s.ForumID = f.ForumID;	
	
--QUERIES--

SELECT f.forumName, s.subForumName FROM
	subforums s INNER JOIN forums f ON f.forumID = s.forumID;
	
SELECT * FROM Posts 
	WHERE subForumID IN 
		(SELECT subForumID FROM SubForums
			WHERE SubForumName = 'Alan Labouseur');
	
--FUNCTIONS--	
	
CREATE OR REPLACE FUNCTION MostUsedForum() RETURNS 
TABLE (forumName text, count integer) as $$

	SELECT forumID, max(num) FROM (SELECT forumID, COUNT(forumID) as num FROM subForums GROUP BY forumID) subForums GROUP BY forumID ORDER BY MAX DESC LIMIT 1;
	
$$ language 'sql' $$


CREATE TRIGGER UpdateOnOffer ON offers FOR INSERT
AS

BEGIN

SELECT @itemID = (SELECT itemID FROM offers ORDER BY itemID DESC LIMIT 1); 

SELECT @buyerID = (SELECT userID FROM offers ORDER BY itemID DESC LIMIT 1); 

SELECT @sellerID = (SELECT sellerID FROM ItemExchange WHERE itemID = @itemID);

SELECT @dateNum = (SELECT dateID FROM offers ORDER BY itemID DESC LIMIT 1);

INSERT INTO messages (SENDERID, RECEIVERID, MESSAGE, DATEID)
VALUES @buyerID, @sellerID, "You Received an offer on your item", @dateNum;

END;

--SECURITY--

CREATE ROLE db_admin

GRANT SELECT, INSERT, DELETE 
ON Forums, SubForums, Posts, Users, Messages, ItemExchange, Offers, Dates
TO db_admin;

CREATE ROLE campus_rep

GRANT SELECT, INSERT, DELETE
ON Forums, SubForums, Posts
TO campus_rep;