/*
    * VIEW
*/
-- ��� EMPLOYEE / �μ� DEPARTMENT / ���� LOCATION / ���� NATIONAL
-- �ѱ����� �ٹ��ϴ� ��� ���� ��ȸ (���, �̸�, �μ���, �޿�, �ٹ�������)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID 
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
    JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '�ѱ�';

-- ���þƿ��� �ٹ��ϴ� ��� ���� ��ȸ (���, �̸�, �μ���, �޿�, �ٹ�������)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID 
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
    JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '���þ�';

-- �Ϻ����� �ٹ��ϴ� ��� ���� ��ȸ (���, �̸�, �μ���, �޿� �ٹ�������)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID 
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
    JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '�Ϻ�';
--------------------------------------------------------------------------------
/*
    * VIEW ����
*/
CREATE VIEW VW_EMPLOYEE 
    AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
        FROM EMPLOYEE 
            JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID 
            JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
            JOIN NATIONAL USING (NATIONAL_CODE)
        );

-- VIEW ���� ���� �ο�
-- GRANT CREATE VIEW TO C##KH;

-- VW_EMPLOYEE�� ����Ͽ� '�ѱ�'���� �ٹ����� ��� ���� ��ȸ
SELECT * FROM VW_EMPLOYEE WHERE NATIONAL_NAME = '�ѱ�';
-- '���þ�'���� �ٹ����� ��� ���� ��ȸ 
SELECT * FROM VW_EMPLOYEE WHERE NATIONAL_NAME = '���þ�';

-- ���� �������� ������(����) 
-- �� ��� ��ȸ 
-- TEXT �÷��� SUBQUERY ���� Ȯ�� ����
SELECT * FROM USER_VIEWS;
-- ���̺� ��� ��ȸ 
SELECT * FROM USER_TABLES;

CREATE OR REPLACE VIEW VW_EMPLOYEE
    AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, BONUS
        FROM EMPLOYEE 
            JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID 
            JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
            JOIN NATIONAL USING (NATIONAL_CODE)
        
    );
SELECT * FROM VW_EMPLOYEE;
--------------------------------------------------------------------------------
-- * ���, �����, ���޸�, ����(��/��), �ٹ���� ���� ��ȸ 
SELECT 
    EMP_ID, EMP_NAME, JOB_NAME, 
    DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��') "����(��/��)", 
    EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) || '��' �ٹ����
FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE);


-- �� ������ �信 ����
CREATE OR REPLACE VIEW VW_EMP_JOB (���, �̸�, ���޸�, ����, �ٹ����)
AS (SELECT 
        EMP_ID, EMP_NAME, JOB_NAME, 
        DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��'), 
        EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
    FROM EMPLOYEE
        JOIN JOB USING (JOB_CODE)
); 
SELECT * FROM VW_EMP_JOB;

-- ����� ���� ��ȸ 
SELECT * FROM VW_EMP_JOB WHERE ���� = '��';

-- 20�� �̻� �ٹ��� ��� ���� ��ȸ
SELECT * FROM VW_EMP_JOB WHERE �ٹ���� >= 20;

-- �� ����
DROP VIEW VW_EMP_JOB;
--------------------------------------------------------------------------------
/*
    ������ �並 ���� DML ���
*/
-- JOB ���̺� �� ����
CREATE OR REPLACE VIEW VW_JOB
AS (SELECT JOB_CODE, JOB_NAME FROM JOB);

SELECT * FROM VW_JOB; -- JOB ���̺��� ������ ���̺�
SELECT * FROM JOB;

-- VW_JOB �並 ����Ͽ� ������ �߰� (INSERT)
INSERT INTO VW_JOB VALUES ('J8', '����');

-- VW_JOB �並 ����Ͽ� ������ ���� (UPDATE)
UPDATE VW_JOB SET JOB_NAME = '�˹�' WHERE JOB_CODE = 'J8';
--------------------------------------------------------------------------------
/*
    VIEW �ɼ�
*/
-- * FORCE/NOFORCE
CREATE VIEW VW_TEMP AS SELECT TCODE, TNAME, TCONTENT FROM TT;
CREATE FORCE VIEW VW_TEMP AS SELECT TCODE, TNAME, TCONTENT FROM TT;

SELECT * FROM VW_TEMP; 
-- FORCE �ɼ��� ����Ͽ� �並 �����Ͽ����� 
-- ���� �����͸� �����ϴ� ���̺��� �������� �ʾ� ��ȸ(SELECT) �� ���� �߻�

CREATE TABLE TT (
    TCODE NUMBER,
    TNAME VARCHAR2(20),
    TCONTENT VARCHAR2(100)
);
SELECT * FROM VW_TEMP; -- ���̺� ���� �� ��ȸ

-- * WITH CHECK OPTION 
-- �ɼ� ���� �޿��� 300���� �̻��� ��� ������ �� ����
CREATE VIEW VW_EMP AS (SELECT * FROM EMPLOYEE WHERE SALARY > 3000000);

SELECT * FROM VW_EMP;

-- 204�� ����� �޿��� 200�������� ���� (�� ���, �� ���� �� ���ǿ� ���� �ʴ� �� ���)
UPDATE VW_EMP SET SALARY = 2000000 WHERE EMP_ID = 204;

ROLLBACK;

-- �ɼ� �߰��Ͽ� �ٽ� ����
CREATE OR REPLACE VIEW VW_EMP 
AS (SELECT * FROM EMPLOYEE WHERE SALARY > 3000000) 
WITH CHECK OPTION;

SELECT * FROM VW_EMP;

UPDATE VW_EMP SET SALARY = 2000000 WHERE EMP_ID = 204; 
-- WITH CHECK OPTION���� ���� ���� ���ǿ� �������Ͽ� ���� �߻�

UPDATE VW_EMP SET SALARY = 4000000 WHERE EMP_ID = 204;

-- WITH READ ONLY 
CREATE OR REPLACE VIEW VW_EMP
AS (SELECT * FROM EMPLOYEE WHERE SALARY >= 3000000)
WITH READ ONLY;

SELECT * FROM VW_EMP;

DELETE FROM VW_EMP WHERE EMP_ID = 200;






















