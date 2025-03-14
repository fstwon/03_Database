/*
    * DCL
*/
/*
    ���� ����
*/
-- SAMPLE/SAMPLE ���� ���� - ������ �������� �����ؾ� �Ѵ�.
CREATE USER C##SAMPLE IDENTIFIED BY SAMPLE;
-- ���� ���� (CREATE SESSION) �ο�
GRANT CREATE SESSION TO C##SAMPLE;

-- ���̺� ���� ���� (CREATE TABLE) �ο�
GRANT CREATE TABLE TO C##SAMPLE;

-- ���̺� �����̽� �Ҵ�
ALTER USER C##SAMPLE QUOTA 2M ON USERS; -- 2M ũ���� ���̺� �����̽� ���� �Ҵ�


/*
    * TCL
*/
-- * KH �������� ���� ���� *

-- EMP01 ���̺� ����
DROP TABLE EMP01;

-- EMP01 ���̺� ���� (AS EMPLOYEE (EMP_ID, EMP_NAME, DEPT_TITLE)) 
CREATE TABLE EMP01 AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID);

SELECT * FROM EMP01;

-- 217, 214 ����� ������ ����
DELETE FROM EMP01 WHERE EMP_ID IN (217, 214);

ROLLBACK;

--------------------------------------------------------------------------------
DELETE FROM EMP01 WHERE EMP_ID = 217;
DELETE FROM EMP01 WHERE EMP_ID = 214;

COMMIT; -- ���� DB�� ������� ����
ROLLBACK; -- ������ Ŀ�� �������� ����

--------------------------------------------------------------------------------
-- 208, 209, 210 ����� ��� ���� ���� 
DELETE FROM EMP01 WHERE EMP_ID IN (208, 209, 210);

SELECT * FROM EMP01;

SAVEPOINT SP;

-- 500�� ����� ��� ���� �߰� 
INSERT INTO EMP01 VALUES (500, '�����', '�λ������');

-- 211�� ����� ��� ���� ����
DELETE FROM EMP01 WHERE EMP_ID = 211;

-- SP �������� �ѹ� 
ROLLBACK TO SP;
COMMIT; -- SP �������� ���ư� �� COMMIT ���� SP ���� ���� ���׸� DB�� ����
--------------------------------------------------------------------------------
SELECT * FROM EMP01 ORDER BY EMP_ID;

-- 221�� ����� ��� ���� ���� 
DELETE FROM EMP01 WHERE EMP_ID = 221;

CREATE TABLE TEST (
    TID NUMBER
);

ROLLBACK;

























