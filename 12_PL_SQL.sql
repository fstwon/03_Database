/*
    * PROCEDURE
    
*/
-- * ȭ�鿡 ǥ���ϱ� ���� ����
SET SERVEROUTPUT ON;

-- "HELLO ORACLE" ���
-- ȭ�� ��� ��ɾ� : DBMS_OUTPUT.PUT_LINE(����ҳ���)

BEGIN 
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
    
END;
/
--------------------------------------------------------------------------------
/*
    * �����
    DECLARE
        ����, ��� ���� �� �ʱ�ȭ
*/
/*
    * �Ϲ� Ÿ�� ����
    ������ [CONSTANT] �ڷ���
*/
DECLARE
    -- EID �̸��� NUMBER Ÿ�� ���� ����
    EID NUMBER;
    -- ENAME �̸��� VARCHAR2(20) Ÿ�� ���� ����
    ENAME VARCHAR(20);
    -- PI �̸��� NUMBER Ÿ�� ��� ���� �� 3.14 �� �ʱ�ȭ
    PI CONSTANT NUMBER := 3.14;
BEGIN
    -- * ������ �� ����
    -- EID = 100
    EID := 100;
    -- ENAME = '�ڿ�ö'
    ENAME := '�ڿ�ö';
    -- ����, ��� ���
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
-- * ���� �Է� �޾� ���� ����
DECLARE 
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN 
    ENAME := '�ڿ�ö';
    EID := &�����ȣ;
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
--------------------------------------------------------------------------------

/*
    * ���۷��� Ÿ�� ���� 
*/

DECLARE    
    -- EID ���� EMPLOYEE ���̺��� EMP_ID Ÿ�� ����
    EID EMPLOYEE.EMP_ID%TYPE;
    -- ENAME ���� EMPLOYEE ���̺��� EMP_NAME Ÿ�� ����
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    -- SAL ���� EMPLOYEE ���̺� SALARY Ÿ�� ����
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN 
    -- EMPLOYEE ���̺��� �Է� ���� ����� ��� ���� ��ȸ
    
    SELECT EMP_ID, EMP_NAME, SALARY 
    INTO EID, ENAME, SAL
    FROM EMPLOYEE WHERE EMP_ID = &�����ȣ;
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/
--------------------------------------------------------------------------------
/*
    * ���۷��� Ÿ�� ���� ����
    EID, ENAME, JCODE, SAL, DTITLE 
    
    * ���� �ڷ���
    EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    
    * �Է� ���� ����� ��� ���� ��ȸ ���� ����
    
    * ���
    ���, �̸�, �����ڵ�, �޿�, �μ���
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE 
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    WHERE EMP_ID = &�����ȣ;
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('JCODE : ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
    DBMS_OUTPUT.PUT_LINE('DTITLE : ' || DTITLE);
END;
/
--------------------------------------------------------------------------------
/*
    * ROW Ÿ�� ����
*/
-- E ������ EMPLOYEE ���̺� ROW Ÿ�� ���� ����
DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN 
    SELECT * INTO E FROM EMPLOYEE WHERE EMP_ID = &���;
    
    -- �����, �޿�, ���ʽ� ���� ���
    DBMS_OUTPUT.PUT_LINE('����� : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || E.SALARY);
    -- DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || E.BONUS);
    -- NULL �� ���
    DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || NVL(E.BONUS, 0));
END;
/
--------------------------------------------------------------------------------
/*
    * ����� (BEGIN)
    
    * ���ǹ�
*/
/*
    �Է� ���� ����� ���, �̸�, �޿�, ���ʽ� ���� ���
    * ���� 
    EID, ENAME, SAL, BONUS
    * ���ʽ� ���� 0(NULL)�� ����� '���ʽ��� ���� �ʴ� ����Դϴ�.' ���
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN 
    SELECT 
        EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0) 
    INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SAL);
    
    IF BONUS = 0 THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���� �ʴ� ����Դϴ�.');
    ELSE     
        DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || BONUS);
    END IF;
END;
/
--------------------------------------------------------------------------------
/*
    �Է� ���� ����� �ڿ� ���� ��ȸ (���, �̸�, �μ���, ��������)
    
    * ������ : 'KO', '������', '�ؿ���'
    * ���۷��� Ÿ�� ���� 
    ���, �̸�, �μ���, �����ڵ�
    * �Ϲ� Ÿ�� ����
    �� ���� ����, ����Ÿ��
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.LOCAL_CODE%TYPE;
    TEAM VARCHAR(10);
BEGIN
    SELECT 
        EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE 
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
    WHERE EMP_ID = &���;
    
    IF NCODE = 'KO' THEN TEAM := '������';
    ELSE TEAM := '�ؿ���';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('�������� : ' || TEAM);
END;
/
--------------------------------------------------------------------------------
/*
    ����(SCORE) : �Է� ���� ���� ���� ����
    ���(GRADE) : ��� ���� ���� ����
    
    90 >= SCORE 'A'
    80 >= 'B'
    70 >= 'C'
    60 >= 'D'
    'F'
    
    '������ SCORE�̰�, ����� GRADE�Դϴ�.'
    F, '���� ����Դϴ�.'
*/
DECLARE
    SCORE NUMBER;
    GRADE CHAR(1);
BEGIN
    SCORE := &����;
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    DBMS_OUTPUT.PUT_LINE('������ ' || SCORE || '�̰�, ����� ' || GRADE || '�Դϴ�.');
    
    IF GRADE <> 'F'
    THEN DBMS_OUTPUT.PUT_LINE('���� ����Դϴ�.');
    END IF;
END;
/
--------------------------------------------------------------------------------
-- * �Է� ���� ����� �μ� �ڵ� ���� �μ��� ��� (JOIN ��� X)
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DTITLE VARCHAR2(20);
BEGIN 
    SELECT * INTO EMP FROM EMPLOYEE WHERE EMP_ID = &���;
    
    DTITLE := CASE EMP.DEPT_CODE 
                    WHEN 'D1' THEN '�λ������'
                    WHEN 'D2' THEN 'ȸ�������'
                    WHEN 'D3' THEN '�����ú�'
                    WHEN 'D4' THEN '����������'
                    WHEN 'D5' THEN '�ؿܿ���1��'
                    WHEN 'D6' THEN '�ؿܿ���2��'
                    WHEN 'D7' THEN '�ؿܿ���3��'
                    WHEN 'D8' THEN '���������'
                    WHEN 'D9' THEN '�ѹ���'
                END;
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME || ' ����� �ҼӺμ��� ' || DTITLE || '�Դϴ�.');
END;
/
--------------------------------------------------------------------------------
/*
    * �ݺ���
*/
-- �Ϲ� ���� 
DECLARE
    N NUMBER := 1;
BEGIN 
    LOOP 
        DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
        N := N + 1;
        IF N > 5 THEN EXIT;
        END IF;
    END LOOP;
END;
/
-- FOR LOOP �� 
BEGIN 
    FOR I IN 1..5
    LOOP 
        DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
    END LOOP;
END;
/
-- FOR LOOP REVERSE 
BEGIN 
    FOR I IN REVERSE 1..5
    LOOP 
        DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
    END LOOP;
END;
/
--------------------------------------------------------------------------------
-- TEST ���̺� ����
DROP TABLE TEST;
-- TEST ���̺� ����, TNO(PK), TDATE
CREATE TABLE TEST (
    TNO NUMBER CONSTRAINT TNO_PK PRIMARY KEY,
    TDATE DATE
);
-- SEQUENCE ����, SEQ_TNO, ������ 2, �ִ밪 1000, ��ȯ X, CACHE X
CREATE SEQUENCE SEQ_TNO INCREMENT BY 2 MAXVALUE 1000 NOCYCLE NOCACHE;

-- TEST ���̺� ������ 100�� �߰�. TDATE �� ���� ��¥ ���� �߰�
BEGIN 
    FOR I IN 1..100
    LOOP
        INSERT INTO TEST VALUES(SEQ_TNO.NEXTVAL, SYSDATE);
    END LOOP;
END;
/

SELECT * FROM TEST;
--------------------------------------------------------------------------------
/*
    EXCEPTION
*/
-- �Է� ���� ���ڷ� 10�� ���� ��� ���
DECLARE
    NUM NUMBER;
BEGIN 
    NUM := &����;
    DBMS_OUTPUT.PUT_LINE(10/NUM);
    EXCEPTION
    -- WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('0���� ���� �� �����ϴ�.);
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('0���� ���� �� �����ϴ�.');
END;
/

-- EMPLOYEE ���̺� EMP_ID �÷��� �⺻Ű�� ����
-- ALTER TABLE EMPLOYEE ADD PRIMARY KEY (EMP_ID);

-- �Է� ���� �����ȣ�� '���ö'����� ��� ����
BEGIN
    UPDATE EMPLOYEE
        SET EMP_ID = '&������_���'
    WHERE EMP_NAME = '���ö';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�ߺ��� �����ȣ �Դϴ�.');
END;
/

SELECT TO_DATE('220905', 'YYMMDD') - TO_DATE('221005', 'YYMMDD') FROM DUAL;




















































