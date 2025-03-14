/*
    * INSERT INTO TABLE VALUES (DATA, DATA, DATA, ...)
*/
SELECT * FROM EMPLOYEE;

INSERT INTO EMPLOYEE 
    VALUES (900, '�ڿ�ö', '990307-2000000', 'mrpark@email.com', '01012341234', 'D4', 'J4', 3000000, 0.3, NULL, SYSDATE, NULL, 'N');
--------------------------------------------------------------------------------
/*
    * INSERT INTO TABLE (COLUMN, COLUMN, COLUMN, ...) VALUES (DATA, DATA, DATA, ...)
*/
-- EMPLOYEE ���̺� ���, �����, �ֹι�ȣ, �̸���, �����ڵ� �����͸� ������ �ִ� ��� ���� �߰�
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, EMAIL, JOB_CODE)
    VALUES (901, '����Ŭ', '880909-1000000', 'oracle00@kh.or.kr', 'J7');

SELECT * FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    * INSERT INTO ���̺�� (SUBQUERY);
*/
-- EMP01 �̶�� ���̺� ��� EMP_ID, ����� EMP_NAME, �μ��� DEPT_TITLE �� �����ϴ� ���̺�
CREATE TABLE EMP01 (
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP01;

-- ��ü ����� ���, �����, �μ��� ��ȸ 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID(+);
-- SELECT EMP_ID, EMP_NAME, DEPT_TITLE FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
-- �� ������ ����� EMP01 ���̺� ������ �߰�
INSERT INTO EMP01 
    (SELECT EMP_ID, EMP_NAME, DEPT_TITLE FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID(+));
SELECT * FROM EMP01;
--------------------------------------------------------------------------------
/*
    * INSERT ALL
*/

-- EMP_DEPT ���̺� : ���, �����, �μ��ڵ�, �Ի���
CREATE TABLE EMP_DEPT 
    AS (SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE FROM EMPLOYEE WHERE 1 = 0); -- 1 = 0 => FALSE, ������ ���� �÷� ������ �����ϱ� ���� ���

SELECT * FROM EMP_DEPT;

-- EMP_MANAGER ���̺� : ���, �����, ������ 
CREATE TABLE EMP_MANAGER AS
    (SELECT EMP_ID, EMP_NAME, MANAGER_ID FROM EMPLOYEE WHERE 1 = 0);
    
SELECT * FROM EMP_MANAGER;

-- �μ��ڵ尡 'D1'�� ����� ���, �����, �μ��ڵ�, ������, �Ի��� ���� ��ȸ 

SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE FROM EMPLOYEE WHERE DEPT_CODE = 'D1';

INSERT ALL 
    INTO EMP_DEPT VALUES (EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
    INTO EMP_MANAGER VALUES (EMP_ID, EMP_NAME, MANAGER_ID)
    (SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE FROM EMPLOYEE WHERE DEPT_CODE = 'D1');
    
SELECT * FROM EMP_MANAGER;
SELECT * FROM EMP_DEPT;
--------------------------------------------------------------------------------
/*
    * UPDATE
*/
-- DEPT_TABLE ���̺� DEPARTMENT ���̺� ����
CREATE TABLE DEPT_TABLE AS (SELECT * FROM DEPARTMENT);

SELECT * FROM DEPT_TABLE;

-- �μ��ڵ尡 'D1'�� �μ��� �μ����� '�λ���'���� ����
UPDATE DEPT_TABLE SET DEPT_TITLE = '�λ���' WHERE DEPT_ID = 'D1';

-- �μ��ڵ尡 'D9'�� �μ��� �μ����� '������ȹ��'���� ����
UPDATE DEPT_TABLE SET DEPT_TITLE = '������ȹ��' WHERE DEPT_ID = 'D9';

SELECT * FROM DEPT_TABLE;

-- EMPLOYEE ���̺��� EMP_TABLE�� ���� (���, �̸�, �μ��ڵ�, �޿�, ���ʽ�)
CREATE TABLE EMP_TABLE AS (SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS FROM EMPLOYEE);

SELECT * FROM EMP_TABLE;

-- ����� 900���� ����� �޿��� 400�������� �λ�
UPDATE EMP_TABLE SET SALARY = 4000000 WHERE EMP_ID = 900;

SELECT * FROM EMP_TABLE WHERE EMP_ID = 900;

-- ���ȥ ����� �޿��� 500����, ���ʽ��� 0.2�� ����
UPDATE EMP_TABLE SET SALARY = 5000000, BONUS = 0.2 WHERE EMP_NAME = '���ȥ';

SELECT * FROM EMP_TABLE WHERE EMP_NAME = '���ȥ';

-- ��ü ����� �޿��� ���� �޿� + (���� �޿� * 1.1) �λ� 
UPDATE EMP_TABLE SET SALARY = SALARY * 1.1;

SELECT * FROM EMP_TABLE;
--------------------------------------------------------------------------------
/*
    * UPDATE ���� �������� ���
*/
-- ���� ����� �޿��� ���ʽ��� ����� ����� �޿��� ���ʽ� ���� �����ϰ� ����
SELECT SALARY, BONUS FROM EMP_TABLE WHERE EMP_NAME = '�����';

UPDATE EMP_TABLE 
    SET 
        SALARY = (SELECT SALARY FROM EMP_TABLE WHERE EMP_NAME = '�����'),
        BONUS = (SELECT BONUS FROM EMP_TABLE WHERE EMP_NAME = '�����')
    WHERE EMP_NAME = '����';
SELECT * FROM EMP_TABLE WHERE EMP_NAME = '����';

SELECT * FROM EMP_TABLE WHERE (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_TABLE WHERE EMP_NAME = '�����');

UPDATE EMP_TABLE 
    SET (SALARY, BONUS) = (SELECT SALARY, BONUS FROM EMP_TABLE WHERE EMP_NAME = '�����')
WHERE EMP_NAME = '������';

SELECT SALARY, BONUS FROM EMP_TABLE WHERE EMP_NAME = '������';

-- ASIA �������� �ٹ����� ������� ���ʽ��� 0.3���� ���� 
-- 1. ASIA ���� ���� ��ȸ
SELECT * FROM LOCATION WHERE LOCAL_NAME LIKE 'ASIA%';

-- 2. ASIA ������ �μ� ���� ��ȸ
SELECT * 
FROM DEPARTMENT 
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE 
WHERE LOCAL_NAME LIKE 'ASIA%';

-- 3. ASIA ������ �μ��� ���� ��� ���� ��ȸ 
SELECT EMP_ID FROM EMP_TABLE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME LIKE 'ASIA%';

-- ������ �������� (N�� 1��)
-- * �ش� ������� ���ʽ��� 0.3���� ����
UPDATE EMP_TABLE 
    SET BONUS = 0.3
WHERE EMP_ID 
    IN (
        SELECT EMP_ID FROM EMP_TABLE
            JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
            JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
        WHERE LOCAL_NAME LIKE 'ASIA%'
        );

SELECT * FROM EMP_TABLE;

COMMIT;
--------------------------------------------------------------------------------
-- EMPLOYEE ���̺��� ��� ������ ���� 
DELETE FROM EMPLOYEE;

SELECT * FROM EMPLOYEE;
ROLLBACK;

-- 901�� ����� ������ ����
SELECT * FROM EMPLOYEE WHERE EMP_ID = 901;
DELETE FROM EMPLOYEE WHERE EMP_ID = 901;

-- 900�� ����� �̸����� ������ ����
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '�ڿ�ö';
DELETE FROM EMPLOYEE WHERE EMP_NAME = '�ڿ�ö';

COMMIT;

-- �μ� ���̺��� �μ� �ڵ尡 'D1'�� �μ� ����
SELECT * FROM DEPARTMENT WHERE DEPT_ID = 'D1';
DELETE FROM DEPARTMENT WHERE DEPT_ID = 'D1';


ROLLBACK;
-- �ܷ�Ű�� �����Ǿ� �ִ� ��� ������� �����Ͱ� �����ϸ� ���� �Ұ� 

















