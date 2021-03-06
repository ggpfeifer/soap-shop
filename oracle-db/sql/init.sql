/*******************
*
* BILL SCHEMAS
* 
*********************/

CREATE USER bills_ws IDENTIFIED BY A6B2ECTrCeesnygK;

GRANT CREATE SESSION TO bills_ws;

GRANT CONNECT TO bills_ws;

CREATE SEQUENCE bills_ws.ID_SEQ
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 100
  INCREMENT BY 1
  CACHE 20;

CREATE TABLE bills_ws.bill
( 
  id NUMBER GENERATED BY DEFAULT AS IDENTITY,
  userhash VARCHAR2(255) NOT NULL ,
  creationdate TIMESTAMP WITH TIME ZONE DEFAULT SYSDATE  NOT NULL,
  paymentmethod VARCHAR2(255) NOT NULL, 
  confirmationdate TIMESTAMP WITH TIME ZONE,
  PRIMARY KEY (id)
);
CREATE INDEX bills_ws.bill_userhash_idx ON bills_ws.bill (userhash);
 
CREATE TABLE bills_ws.billitem
( 
 id NUMBER GENERATED BY DEFAULT AS IDENTITY,
  bill_id NUMBER NOT NULL,
  amount NUMBER NOT NULL,
  producthash VARCHAR2(255) NOT NULL,
  price NUMBER NOT NULL,
  discount NUMBER,
  PRIMARY KEY (id),
  FOREIGN KEY (bill_id)
        REFERENCES bills_ws.bill(ID)
        ON DELETE CASCADE
);
CREATE INDEX bills_ws.bill_producthash_idx ON bills_ws.billitem (producthash);

--required to insert values in table
GRANT UNLIMITED TABLESPACE TO bills_ws;

INSERT INTO bills_ws.BILL (userhash, paymentmethod)
VALUES
('user111', 'method1');
INSERT INTO bills_ws.BILL (userhash, paymentmethod)
VALUES
('user222', 'method1');
INSERT INTO bills_ws.BILL (userhash, paymentmethod)
VALUES
('user333', 'method3');


INSERT INTO bills_ws.BILLITEM (bill_id, amount, producthash, price)
VALUES
(
    (SELECT id from bills_ws.bill where userhash = 'user111'),
    1,
    'product123',
    5500
);

INSERT INTO bills_ws.BILLITEM (bill_id, amount, producthash, price)
VALUES
(
    (SELECT id from bills_ws.bill where userhash = 'user111'),
    2,
    'product456',
    10500
);

INSERT INTO bills_ws.BILLITEM (bill_id, amount, producthash, price)
VALUES
(
    (SELECT id from bills_ws.bill where userhash = 'user111'),
    10,
    'product789',
    2400
);

INSERT INTO bills_ws.BILLITEM (bill_id, amount, producthash, price)
VALUES
(
    (SELECT id from bills_ws.bill where userhash = 'user333'),
    20,
    'product1011',
    23000
);

COMMIT;

/*******************
*
* USER SCHEMAS
* 
*********************/

CREATE USER users_ws IDENTIFIED BY WKzTa7884VYv48Ez;

GRANT CREATE SESSION TO users_ws;

GRANT CONNECT TO users_ws;

CREATE SEQUENCE users_ws.ID_SEQ
  MINVALUE 1
  MAXVALUE 999999999999999999999999999
  START WITH 100
  INCREMENT BY 1
  CACHE 20;

CREATE TABLE users_ws.appuser
( 
  id NUMBER GENERATED BY DEFAULT AS IDENTITY,
  userhash VARCHAR2(255) NOT NULL ,
  creationdate TIMESTAMP WITH TIME ZONE DEFAULT SYSDATE  NOT NULL,
  modificationdate TIMESTAMP WITH TIME ZONE DEFAULT SYSDATE  NOT NULL,
  firstname VARCHAR2(255) NOT NULL, 
  lastname VARCHAR2(255) NOT NULL, 
  password VARCHAR2(255) NOT NULL, 
  address VARCHAR2(255) NULL, 
  phone VARCHAR2(255) NULL, 
  email VARCHAR2(255) NOT NULL, 
  roles VARCHAR2(255) NOT NULL,
  PRIMARY KEY (id)
);
CREATE INDEX users_ws.user_userhash_idx ON users_ws.appuser (userhash);
CREATE INDEX users_ws.user_creationdate_idx ON users_ws.appuser (creationdate);
CREATE INDEX users_ws.user_modificationdate_idx ON users_ws.appuser (modificationdate);
CREATE INDEX users_ws.user_firstname_idx ON users_ws.appuser (firstname);
CREATE INDEX users_ws.user_lastname_idx ON users_ws.appuser (lastname);
CREATE INDEX users_ws.user_password_idx ON users_ws.appuser (password);
CREATE INDEX users_ws.user_email_idx ON users_ws.appuser (email);
CREATE INDEX users_ws.user_roles_idx ON users_ws.appuser (roles);


--required to insert values in table
GRANT UNLIMITED TABLESPACE TO users_ws;

INSERT INTO users_ws.appuser (userhash, firstname, lastname, password, email, roles)
VALUES
('user111', 'myFirstname', 'myLastname', 'pass123', 'myEmail@test.com', 'CLIENT,ADMIN');

INSERT INTO users_ws.appuser (userhash, firstname, lastname, password, email, roles)
VALUES
('user111', 'aaaaName', 'aaaLastname', 'aaaa1111', 'aa@a.com', 'CLIENT');