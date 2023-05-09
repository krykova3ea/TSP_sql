CREATE TABLE CITIES(
AID NUMBER (2) NOT NULL,
ACITY VARCHAR2(200) NOT NULL,
BID NUMBER (2) NOT NULL,
BCITY VARCHAR2(200) NOT NULL,
DIST NUMBER (2) NOT NULL);

INSERT INTO cities
VALUES (1,'Moscow',2,'Tokyo',5);
INSERT INTO cities
VALUES (1,'Moscow',3,'Paris',3);
INSERT INTO cities
VALUES (1,'Moscow',4,'Dublin',1);
INSERT INTO cities
VALUES (1,'Moscow',5,'Berlin',2);
INSERT INTO cities
VALUES (2,'Tokyo',3,'Paris',1);
INSERT INTO cities
VALUES (2,'Tokyo',4,'Dublin',3);
INSERT INTO cities
VALUES (2,'Tokyo',5,'Berlin',6);
INSERT INTO cities
VALUES (3,'Paris',4,'Dublin',4);
INSERT INTO cities
VALUES (3,'Paris',5,'Berlin',2);
INSERT INTO cities
VALUES (4,'Dublin',5,'Berlin',7);
INSERT INTO cities
VALUES (1,'Moscow',6,'Tokyo1',5);
INSERT INTO cities
VALUES (1,'Moscow',7,'Paris1',3);
INSERT INTO cities
VALUES (1,'Moscow',8,'Dublin1',1);
INSERT INTO cities
VALUES (1,'Moscow',9,'Berlin1',2);
INSERT INTO cities
VALUES (6,'Tokyo1',7,'Paris1',1);
INSERT INTO cities
VALUES (6,'Tokyo1',8,'Dublin1',3);
INSERT INTO cities
VALUES (6,'Tokyo1',9,'Berlin1',6);
INSERT INTO cities
VALUES (7,'Paris1',8,'Dublin1',4);
INSERT INTO cities
VALUES (7,'Paris1',9,'Berlin1',2);
INSERT INTO cities
VALUES (8,'Dublin1',5,'Berlin',7);

