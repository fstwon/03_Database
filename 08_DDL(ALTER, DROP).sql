/*
    * ALTER
*/
/*
    �÷� �߰�/����/����
*/
/*
    �÷� �߰�
*/
-- DEPT_TABLE
ALTER TABLE DEPT_TABLE ADD CNAME VARCHAR(20);

SELECT * FROM DEPT_TABLE;

-- DEPT_TABLE ���̺� LNAME VARCHAR2(20) �÷� �߰�, �⺻���� ���� : '�ѱ�'
ALTER TABLE DEPT_TABLE ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';

/*
    �÷� ����
*/
-- DEPT_TABLE ���̺��� DEPT_ID �÷� ����
ALTER TABLE DEPT_TABLE MODIFY DEPT_ID CHAR(5);

-- DEPT_TABLE ���̺��� DEPT_ID �÷��� �����͸� NUMBER�� ����
ALTER TABLE DEPT_TABLE MODIFY DEPT_ID NUMBER; 
-- �̹� ���� ���·� �����Ͱ� ����Ǿ� �־� �ٸ� Ÿ�����δ� ���� �Ұ�

-- DEPT_TABLE ���̺��� DEPT_TITLE �÷� ����
-- ������ ũ�� ����
ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(10); 
-- �̹� ����� �������� ũ�Ⱑ ���� ũ�� �ʰ� �뷮���� ����Ǿ� �־� 
-- ���� ������ ũ�� �̸����� ũ�� ���� �Ұ�

-- ������ Ÿ�� : VARCHAR2(35) -> VARCHAR2(50)
ALTER TABLE DEPT_TABLE MODIFY DEPT_TITLE VARCHAR2(50);
-- ���� ������ ũ�� �̻����� ������ ����

-- EMP_TABLE ���̺��� SALARY �÷� ����
-- ������ Ÿ�� : NUMBER -> VARCHAR2(50)
ALTER TABLE EMP_TABLE MODIFY SALARY VARCHAR2(50);

-- �÷� ���� ����
-- DEPT_TABLE ���̺��� 
-- DEPT_TITLE �÷��� VARCHAR2(55);
-- LNAME �÷��� �⺻ ���� '�ڸ���'�� ���� 
ALTER TABLE DEPT_TABLE 
    MODIFY DEPT_TITLE VARCHAR2(55)
    MODIFY LNAME DEFAULT '�ڸ���';
    
SELECT * FROM DEPT_TABLE;

/*
    * �÷� ����
*/
-- DEPT_TABLE ���̺��� DEPT_COPY ���̺�� ���� 
CREATE TABLE DEPT_COPY AS (SELECT * FROM DEPT_TABLE);
SELECT * FROM DEPT_COPY;

-- DEPT_COPY ���̺��� LNAME �÷� ����
ALTER TABLE DEPT_COPY DROP COLUMN LNAME;

ALTER TABLE DEPT_COPY DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY DROP COLUMN DEPT_ID; -- ����
--------------------------------------------------------------------------------
/*
    * �������� �߰�/����
*/

-- DEPT_TABLE ���̺�
ALTER TABLE DEPT_TABLE 
    -- DEPT_ID �÷��� �⺻ Ű �߰� (PK), DT_PK
    ADD CONSTRAINT DT_PK PRIMARY KEY (DEPT_ID)
    -- DEPT_TITLE �÷��� UNIQUE �߰�, DT_UQ
    ADD CONSTRAINT DT_UQ UNIQUE (DEPT_TITLE)
    -- LNAME �÷��� NOT NULL �߰�
    MODIFY LNAME NOT NULL;

-- DEPT_TABLE ���̺��� �⺻ Ű ����
ALTER TABLE DEPT_TABLE DROP CONSTRAINT DT_PK;

ALTER TABLE DEPT_TABLE DROP CONSTRAINT DT_UQ MODIFY LNAME NULL;

/*
    �÷���, �������Ǹ�, ���̺�� ����
*/
-- 1) �÷��� ����
-- DEPT_TABLE ���̺��� DEPT_TITLE �÷� �̸��� DEPT_NAME���� ����
ALTER TABLE DEPT_TABLE RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 2) �������� ����
-- DEPT_TABLE ���̺��� DEPT_ID�� NOT NULL �������Ǹ��� DT_DEPTID_NN���� ����
ALTER TABLE DEPT_TABLE RENAME CONSTRAINT SYS_C008444 TO DT_DEPTID_NN;

-- 3) ���̺�� ���� 
-- DEPT_TABLE ���� DEPT_END�� ����
ALTER TABLE DEPT_TABLE RENAME TO DEPT_END;
SELECT * FROM DEPT_END;

/*
    ����
*/
-- DEPT_END ���̺� ����
DROP TABLE DEPT_END;























