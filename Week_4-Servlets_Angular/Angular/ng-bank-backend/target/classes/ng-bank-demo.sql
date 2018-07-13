-- DDL for NgBank App (Full Stack Angular & Java Servlets)
/*
DROP TABLE TRANSACTION_TYPES;
DROP TABLE TRANSACTIONS;
DROP TABLE ACCOUNT_ROLES;
DROP TABLE ACCOUNT_TYPES;
DROP TABLE ACCOUNT_STATUSES;
DROP TABLE USER_ACCOUNTS;
DROP TABLE ACCOUNTS;
DROP TABLE USER_ROLES;
DROP TABLE USER_STATUSES;
DROP TABLE USERS;
DROP SEQUENCE ACCT_ID_SEQ;
DROP SEQUENCE ACCT_ROLE_ID_SEQ;
DROP SEQUENCE ACCT_STATUS_ID_SEQ;
DROP SEQUENCE ACCT_TYPE_ID_SEQ;
DROP SEQUENCE TRANS_ID_SEQ;
DROP SEQUENCE TRANS_TYPE_ID_SEQ;
DROP SEQUENCE USER_ID_SEQ;
DROP SEQUENCE USER_ROLE_ID_SEQ;
DROP SEQUENCE USER_STATUS_ID_SEQ;
ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:NONE';
*/

CREATE TABLE USER_ROLES (
  user_role_id  NUMBER(1),
  user_role     VARCHAR2(25),
  
  CONSTRAINT pk_user_role_id PRIMARY KEY (user_role_id)
);

CREATE TABLE USER_STATUSES (
  user_status_id  NUMBER(1),
  user_status     VARCHAR2(25),
  
  CONSTRAINT pk_user_status_id PRIMARY KEY (user_status_id)
);

CREATE TABLE USERS (
  user_id     NUMBER(8),
  username    VARCHAR2(50) NOT NULL,
  password    VARCHAR2(256) NOT NULL,
  first_name  VARCHAR2(25) NOT NULL,
  last_name   VARCHAR2(25) NOT NULL,
  email       VARCHAR2(350) NOT NULL,
  role_id     NUMBER(1) DEFAULT 4,
  status_id   NUMBER(1) DEFAULT 1,
  
  CONSTRAINT pk_user_id PRIMARY KEY (user_id),
  CONSTRAINT fk_user_role_id FOREIGN KEY (role_id) REFERENCES USER_ROLES,
  CONSTRAINT fk_user_status_id FOREIGN KEY (status_id) REFERENCES USER_STATUSES,
  CONSTRAINT unq_username UNIQUE (username),
  CONSTRAINT unq_email UNIQUE (email)
);

CREATE TABLE ACCOUNT_STATUSES (
  acct_status_id  NUMBER(1),
  acct_status     VARCHAR2(25) NOT NULL,
  
  CONSTRAINT pk_status_type_id PRIMARY KEY (acct_status_id)
);

CREATE TABLE ACCOUNT_TYPES (
  acct_type_id  NUMBER(1),
  acct_type     VARCHAR2(25) NOT NULL,
  
  CONSTRAINT pk_acct_type_id PRIMARY KEY (acct_type_id)
);

CREATE TABLE ACCOUNTS (
  acct_id     NUMBER(8),
  balance     NUMBER(8,2) DEFAULT 0.00,
  type_id     NUMBER(1) DEFAULT 1,
  status_id   NUMBER(1) DEFAULT 1,
  
  CONSTRAINT pk_acct_id PRIMARY KEY (acct_id),
  CONSTRAINT fk_acct_type_id FOREIGN KEY (type_id) REFERENCES ACCOUNT_TYPES,
  CONSTRAINT fk_acct_status_id FOREIGN KEY (status_id) REFERENCES ACCOUNT_STATUSES
);

CREATE TABLE ACCOUNT_ROLES(
  acct_role_id  NUMBER(1),
  acct_role     VARCHAR(25) NOT NULL,
  
  CONSTRAINT pk_acct_role_id PRIMARY KEY (acct_role_id)
);

CREATE TABLE USER_ACCOUNTS (
  user_id         NUMBER(8),
  acct_id         NUMBER(8),
  acct_name       VARCHAR2(128) NOT NULL,
  acct_role_id    NUMBER(1),
  
  CONSTRAINT pk_user_acct_id PRIMARY KEY (user_id, acct_id),
  CONSTRAINT fk_acct_role_id FOREIGN KEY (acct_role_id) REFERENCES ACCOUNT_ROLES
);

CREATE TABLE TRANSACTION_TYPES (
  trans_type_id   NUMBER(1),
  trans_type      VARCHAR2(25) NOT NULL,
  
  CONSTRAINT pk_trans_type_id PRIMARY KEY (trans_type_id)
);

CREATE TABLE TRANSACTIONS (
  trans_id  NUMBER(8),
  acct_id   NUMBER(8),
  type_id   NUMBER(1) DEFAULT 3,
  amount    NUMBER(7,2) NOT NULL,
  memo      VARCHAR2(256) DEFAULT '',
  time      TIMESTAMP NOT NULL,
  
  CONSTRAINT pk_trans_id PRIMARY KEY (trans_id),
  CONSTRAINT fk_acct_id FOREIGN KEY (acct_id) REFERENCES ACCOUNTS,
  CONSTRAINT fk_type_id FOREIGN KEY (type_id) REFERENCES TRANSACTION_TYPES
);

CREATE SEQUENCE USER_ID_SEQ
MINVALUE 10000000
START WITH 10000000
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER USER_INSERT_TRIGGER
BEFORE INSERT ON USERS
FOR EACH ROW

BEGIN
  SELECT USER_ID_SEQ.NEXTVAL 
  INTO :new.USER_ID 
  FROM DUAL;
END;
/

CREATE SEQUENCE ACCT_ID_SEQ
MINVALUE 10000000
START WITH 10000000
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER ACCT_INSERT_TRIGGER
BEFORE INSERT ON ACCOUNTS
FOR EACH ROW

BEGIN
  SELECT ACCT_ID_SEQ.NEXTVAL 
  INTO :new.ACCT_ID 
  FROM DUAL;
END;
/

CREATE SEQUENCE TRANS_ID_SEQ
MINVALUE 1
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER TRANSACTIONS_INSERT_TRIGGER
BEFORE INSERT ON TRANSACTIONS
FOR EACH ROW

BEGIN
  SELECT TRANS_ID_SEQ.NEXTVAL 
  INTO :new.TRANS_ID 
  FROM DUAL;
END;
/

CREATE SEQUENCE ACCT_ROLE_ID_SEQ
MINVALUE 1
MAXVALUE 9
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER ACCT_ROLES_INSERT_TRIGGER
BEFORE INSERT ON ACCOUNT_ROLES
FOR EACH ROW

BEGIN
  SELECT ACCT_ROLE_ID_SEQ.NEXTVAL 
  INTO :new.ACCT_ROLE_ID 
  FROM DUAL;
END;
/

CREATE SEQUENCE USER_ROLE_ID_SEQ
MINVALUE 1
MAXVALUE 9
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER USER_ROLES_INSERT_TRIGGER
BEFORE INSERT ON USER_ROLES
FOR EACH ROW

BEGIN
  SELECT USER_ROLE_ID_SEQ.NEXTVAL 
  INTO :new.USER_ROLE_ID 
  FROM DUAL;
END;
/

CREATE SEQUENCE ACCT_STATUS_ID_SEQ
MINVALUE 1
MAXVALUE 9
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER ACCT_STATUSES_INSERT_TRIGGER
BEFORE INSERT ON ACCOUNT_STATUSES
FOR EACH ROW

BEGIN
  SELECT ACCT_STATUS_ID_SEQ.NEXTVAL 
  INTO :new.ACCT_STATUS_ID 
  FROM DUAL;
END;
/

CREATE SEQUENCE ACCT_TYPE_ID_SEQ
MINVALUE 1
MAXVALUE 9
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER ACCT_TYPES_INSERT_TRIGGER
BEFORE INSERT ON ACCOUNT_TYPES
FOR EACH ROW

BEGIN
  SELECT ACCT_TYPE_ID_SEQ.NEXTVAL 
  INTO :new.ACCT_TYPE_ID 
  FROM DUAL;
END;
/

CREATE SEQUENCE USER_STATUS_ID_SEQ
MINVALUE 1
MAXVALUE 9
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER USER_STATUSES_INSERT_TRIGGER
BEFORE INSERT ON USER_STATUSES
FOR EACH ROW

BEGIN
  SELECT USER_STATUS_ID_SEQ.NEXTVAL 
  INTO :new.USER_STATUS_ID 
  FROM DUAL;
END;
/

CREATE SEQUENCE TRANS_TYPE_ID_SEQ
MINVALUE 1
MAXVALUE 9
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER TRANS_TYPE_INSERT_TRIGGER
BEFORE INSERT ON TRANSACTION_TYPES
FOR EACH ROW

BEGIN
  SELECT TRANS_TYPE_ID_SEQ.NEXTVAL 
  INTO :new.TRANS_TYPE_ID 
  FROM DUAL;
END;
/

INSERT INTO TRANSACTION_TYPES (trans_type) VALUES ('DEPOSIT'); 
INSERT INTO TRANSACTION_TYPES (trans_type) VALUES ('WITHDRAWAL');
INSERT INTO TRANSACTION_TYPES (trans_type) VALUES ('UNSPECIFIED');

INSERT INTO USER_ROLES (user_role) VALUES ('ADMIN');
INSERT INTO USER_ROLES (user_role) VALUES ('DEV');
INSERT INTO USER_ROLES (user_role) VALUES ('CUSTOMER SUPPORT');
INSERT INTO USER_ROLES (user_role) VALUES ('CUSTOMER');

INSERT INTO USER_STATUSES (user_status) VALUES ('ACTIVE');
INSERT INTO USER_STATUSES (user_status) VALUES ('INACTIVE');
INSERT INTO USER_STATUSES (user_status) VALUES ('LOCKED');

INSERT INTO ACCOUNT_STATUSES (acct_status) VALUES ('OPEN');
INSERT INTO ACCOUNT_STATUSES (acct_status) VALUES ('CLOSED');

INSERT INTO ACCOUNT_TYPES (acct_type) VALUES ('CHECKING');
INSERT INTO ACCOUNT_TYPES (acct_type) VALUES ('SAVINGS');

INSERT INTO ACCOUNT_ROLES (acct_role) VALUES ('PRIMARY');
INSERT INTO ACCOUNT_ROLES (acct_role) VALUES ('SECONDARY');

COMMIT;