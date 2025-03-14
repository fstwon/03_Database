-- DDL, CREATE 
-- ȸ�� ������ ������ ���̺� ����
-- ���̺�� : MEMBER
/*
    COLOUMN 
    - ȸ�� ��ȣ : ���� (NUMBER)
    - ȸ�� ���̵� : ���� (VARCHAR2(20))
    - ȸ�� ��й�ȣ : ���� (VARCHAR2(20))
    - ȸ�� �̸� : ���� (VARCHAR2(20))
    - ���� : ���� (CHAR(3)) 
    - ����ó : ���� (CHAR(13))
    - �̸��� : ���� (VARCHAR2(50))
    - ������ : ��¥ (DATE)
*/
CREATE TABLE MEMBER (
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
);

SELECT * FROM MEMBER;
--------------------------------------------------------------------------------
/*
    * �÷� ���� �߰�
*/
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ���̸�';
COMMENT ON COLUMN MEMBER.GENDER IS '����';
COMMENT ON COLUMN MEMBER.PHONE IS '����ó';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.ENROLLDATE IS '������';

-- ���̺� ���� : DROP TABLE ���̺��;
-- DROP TABLE MEMBER;

-- ���̺� ������ �߰�
INSERT INTO MEMBER VALUES (
    1, 'mrpark', 'mrpark0000', '�ڿ�ö', '��', '000-0000-0000', 'mrpark@email.com', SYSDATE
);
SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES (
    2, 'mrshee', 'mrshee0000', '�迵��', '��', '000-0000-0000', NULL, SYSDATE
);

COMMIT; -- ���� ���� ����
--------------------------------------------------------------------------------
/*
    * ���� ����
*/
-- NULL ������ ����
-- * NOT NULL ���� ������ �߰��� ȸ�� ���̺�
-- ���̺�� : MEMBER_NOTNULL
-- ��, ȸ����ȣ, ���̵�, ��й�ȣ, �̸��� ���� �����ʹ� NULL ���� ������� �ʴ´�. 
CREATE TABLE MEMBER_NOTNULL (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
);

SELECT * FROM MEMBER_NOTNULL;

INSERT INTO MEMBER_NOTNULL VALUES (
  1, 'mrpark', 'mrpark0000', '�ڿ�ö', '��', '000-0000-0000', 'mrpark@email.com', SYSDATE
);

INSERT INTO MEMBER_NOTNULL VALUES (
  2, 'mrshee', 'mrshee0000', '�迵��', NULL, NULL, NULL, NULL
);

INSERT INTO MEMBER_NOTNULL VALUES (
  3, NULL, 'mrshee0000', '�����', NULL, NULL, NULL, NULL
); -- ���� �������� ���� ȸ�� ���̵� NULL ���� �Է��� �� ��� ���� �߻� (������������)
--------------------------------------------------------------------------------
/*
    * �ߺ� ������ ����
*/
-- * UNIQUE ���� ������ �߰��Ͽ� ���̺� ����
-- ���̺�� : MEMBER_UNIQUE
-- ȸ�� ���̵� �ߺ����� �ʵ��� ����
CREATE TABLE MEMBER_UNIQUE (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- �÷� ���� ���. NOT NULL�� UNIQUE ���� ���� ����
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
    
    -- , UNIQUE (�÷���, ...) - ���̺� ���� ���
);

SELECT * FROM MEMBER_UNIQUE;

INSERT INTO MEMBER_UNIQUE VALUES (
    1, 'mrpark', 'mrpark0000', '�ڿ�ö', '��', '000-0000-0000', 'mrpark@email.com', SYSDATE
);

INSERT INTO MEMBER_UNIQUE VALUES (
    2, 'mrpark', 'mrshee0000', '�迵��', '��', '000-0000-0000', 'mrshee@email.com', SYSDATE
); -- UNIQUE ���� ���ǿ� ����Ǿ� ���� �߻�
--------------------------------------------------------------------------------
/*
    * ���� ���Ǹ� ����
*/
-- MEMBER_UNIQUE ���̺� ����
DROP TABLE MEMBER_UNIQUE;

-- ���� ���Ǹ��� �����Ͽ� �����
CREATE TABLE MEMBER_UNIQUE (
    MEM_NO NUMBER CONSTRAINT MEMNO_NT NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NT NOT NULL,
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NT NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNM_NT NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
    
    , CONSTRAINT MEMID_UQ UNIQUE (MEM_ID)
);

INSERT INTO MEMBER_UNIQUE 
    VALUES (1, 'mrpark', 'mrpark0000', '�ڿ�ö', '��', '000-0000-0000', 'mrpark@email.com', SYSDATE);

INSERT INTO MEMBER_UNIQUE 
    VALUES (2, 'mrspark', 'mrshee0000', '�迵��', '��', '000-0000-0000', 'mrshee@email.com', SYSDATE);

INSERT INTO MEMBER_UNIQUE 
    VALUES (3, 'mrpark', 'mrsok0000', '�ڿ���', '��', '000-0000-0000', 'mrsok@email.com', SYSDATE);
    
INSERT INTO MEMBER_UNIQUE 
    VALUES (3, NULL, NULL, '�ڿ���', '��', '000-0000-0000', 'mrsok@email.com', SYSDATE);
--------------------------------------------------------------------------------
/*
    * CHECK ���� ���� 
*/
-- CHECK ���� ���� ���̺� ����
-- ���̺�� : MEMBER_CHECK
-- ���� �÷��� '��' �Ǵ� '��' �����͸� �����ϵ��� ����
CREATE TABLE MEMBER_CHECK (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
    
    , UNIQUE (MEM_ID)
    -- CHECK(GENDER IN ('��', '��'))
);
SELECT * FROM MEMBER_CHECK;

INSERT INTO MEMBER_CHECK
    VALUES (1, 'mrpark', 'mrpark0000', '�ڿ�ö', '��', '000-0000-0000', 'mrpark@email.com', SYSDATE);

INSERT INTO MEMBER_CHECK
    VALUES (2, 'mrspark', 'mrshee0000', '�迵��', '��', '000-0000-0000', 'mrshee@email.com', SYSDATE);
--------------------------------------------------------------------------------
/*
    * PRIMARY KEY
*/

-- �⺻ Ű ���� ���� �߰� ���̺� ����
-- ���̺�� : MEMBER_PRI
-- ȸ�� ��ȣ�� �⺻Ű ����
CREATE TABLE MEMBER_PRI (
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
    
    , UNIQUE (MEM_ID)
    -- CHECK(GENDER IN ('��', '��'))
);

SELECT * FROM MEMBER_PRI;

INSERT INTO MEMBER_PRI
    VALUES(1, 'ID', 'PWD', 'NAME', NULL, NULL, NULL, SYSDATE);
    
INSERT INTO MEMBER_PRI
    VALUES(1, 'ID2', 'PWD', 'NAME2', NULL, NULL, NULL, SYSDATE); -- �ߺ��� PK (MEM_ID) ������ ������ �õ��Ͽ� ���� �߻� (MEMNO_PK)
INSERT INTO MEMBER_PRI
    VALUES(NULL, 'ID2', 'PWD', 'NAME2', NULL, NULL, NULL, SYSDATE); -- PK (MEM_ID) ������ NULL �� ������ �õ��Ͽ� ���� �߻� (MEMNO_PK)    
INSERT INTO MEMBER_PRI
    VALUES(2, 'ID2', 'PWD', 'NAME2', NULL, NULL, NULL, SYSDATE); -- PK (MEM_ID) ������ NULL �� ������ �õ��Ͽ� ���� �߻� (MEMNO_PK)    
SELECT * FROM MEMBER_PRI;

--------------------------------------------------------------------------------

-- * �� �� �÷��� �⺻Ű�� �����Ͽ� ���̺� ����
-- ���̺�� : MEMBER_PRI2
-- ȸ����ȣ, ȸ�����̵� �⺻Ű�� ���� (����Ű)
CREATE TABLE MEMBER_PRI2 (
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
    
    , UNIQUE (MEM_ID)
    , CONSTRAINT MEMPRI2_PK PRIMARY KEY (MEM_NO, MEM_ID)
);

SELECT * FROM MEMBER_PRI2;

INSERT INTO MEMBER_PRI2 
    VALUES (1, 'ID', 'PWD', 'NAME', NULL, NULL, NULL, NULL);
    
INSERT INTO MEMBER_PRI2 
    VALUES (1, 'ID2', 'PWD', 'NAME2', NULL, NULL, NULL, NULL);
--------------------------------------------------------------------------------
/*
    * FOREIGN KEY
*/
-- * ȸ�� ��� ���� ���� ���̺� ����
-- ���̺�� : MEMBER_GRADE
-- ��޹�ȣ(PK), ��޸� (NOT NULL)
CREATE TABLE MEMBER_GRADE (
    GRADE_NO NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);

SELECT * FROM MEMBER_GRADE;

INSERT INTO MEMBER_GRADE VALUES (100, '�Ϲ�ȸ��');
INSERT INTO MEMBER_GRADE VALUES (200, 'VIP');
INSERT INTO MEMBER_GRADE VALUES (300, 'VVIP');

-- MEMBER TABLE ���� �� �����
-- ȸ����ȣ, ȸ�����̵�, ȸ����й�ȣ, ȸ���̸�, ����, ������, ȸ����޹�ȣ(GRADE_NO)
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    ENROLLDATE DATE,
    -- �÷� ���� ��� �ܷ�Ű ����
    GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO)
    
    -- ���̺� ���� ���
    -- FOREIGN KEY (GRADE_NO) REFERENCES MEMBER_GRADE(GRADE_NO)
);

INSERT INTO MEMBER
    VALUES (1, 'ID', 'PWD', 'NAME', '��', SYSDATE, 100);

INSERT INTO MEMBER
    VALUES (2, 'ID2', 'PWD2', 'NAME2', '��', SYSDATE, 200);
    
INSERT INTO MEMBER
    VALUES (3, 'ID3', 'PWD3', 'NAME3', '��', SYSDATE, NULL);

INSERT INTO MEMBER
    VALUES (4, 'ID4', 'PWD4', 'NAME4', '��', SYSDATE, 400); -- �ܷ�Ű�� ������� ���� ������ ����Ͽ� ���� �߻�

INSERT INTO MEMBER
    VALUES (4, 'ID4', 'PWD4', 'NAME4', '��', SYSDATE, 300);
    
SELECT * FROM MEMBER;

-- �θ����̺��� �ڽ����̺� ����� �ܷ�Ű �����͸� �����ϴ� ���
-- ���Ἲ ���� ���ǿ� ���� ���� �Ұ�
-- ȸ�� ��� ���̺��� ��޹�ȣ�� 100�� ������ ����
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    ENROLLDATE DATE,
    -- �÷� ���� ��� �ܷ�Ű ����
    GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE SET NULL
    
    -- ���̺� ���� ���
    -- FOREIGN KEY (GRADE_NO) REFERENCES MEMBER_GRADE(GRADE_NO)
);

INSERT INTO MEMBER
    VALUES (1, 'ID', 'PWD', 'NAME', '��', SYSDATE, 100);

INSERT INTO MEMBER
    VALUES (2, 'ID2', 'PWD2', 'NAME2', '��', SYSDATE, 200);
    
INSERT INTO MEMBER
    VALUES (3, 'ID3', 'PWD3', 'NAME3', '��', SYSDATE, NULL);

-- ȸ����� ���� �� 100���� ���� ��� ����
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
SELECT * FROM MEMBER_GRADE;

ROLLBACK;

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    ENROLLDATE DATE,
    -- �÷� ���� ��� �ܷ�Ű ����
    GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE CASCADE
    
    -- ���̺� ���� ���
    -- FOREIGN KEY (GRADE_NO) REFERENCES MEMBER_GRADE(GRADE_NO)
);

INSERT INTO MEMBER
    VALUES (1, 'ID', 'PWD', 'NAME', '��', SYSDATE, 100);

INSERT INTO MEMBER
    VALUES (2, 'ID2', 'PWD2', 'NAME2', '��', SYSDATE, 200);
    
INSERT INTO MEMBER
    VALUES (3, 'ID3', 'PWD3', 'NAME3', '��', SYSDATE, NULL);

SELECT * FROM MEMBER;

DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
SELECT * FROM MEMBER_GRADE;
--------------------------------------------------------------------------------

/*
    * �⺻�� (DEFAULT)
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    AGE NUMBER,
    HOBBY VARCHAR2(30) DEFAULT '����',
    ENROLLDATE DATE
);

SELECT * FROM MEMBER;

INSERT INTO MEMBER
    VALUES (1, '�ڿ�ö', 30, '���ǰ���', SYSDATE);
    
INSERT INTO MEMBER
    VALUES (2, '�����', 23, '����', SYSDATE);

INSERT INTO MEMBER
    VALUES (3, '�迵��', 20, NULL, NULL);

INSERT INTO MEMBER (MEM_NO, MEM_NAME)
    VALUES (4, '��');
--------------------------------------------------------------------------------
/*
    * ���̺� ����
*/
CREATE TABLE MEMBER_COPY AS SELECT * FROM MEMBER;

SELECT * FROM MEMBER_COPY;

-- MEMBER_COPY ���̺� ȸ�� ��ȣ �÷��� �⺻Ű ����
ALTER TABLE MEMBER_COPY ADD PRIMARY KEY (MEM_NO);

-- MEMBER_COPY ���̺� ��� �÷��� �⺻�� ���� 
ALTER TABLE MEMBER_COPY MODIFY HOBBY DEFAULT '-';


