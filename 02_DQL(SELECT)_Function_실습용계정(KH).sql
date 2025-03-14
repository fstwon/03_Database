/*
    * �Լ� (Function)
    ���޵� �÷� ���� �о� �Լ� ���� ��� ��ȯ
    
    - ������ �Լ�
    ���� ���� �о� ���� ��� �� ��ȯ => �ึ�� �Լ� ���� ��� ��ȯ
    
    - �׷� �Լ�
    ���� ���� �о� �ϳ��� ��� �� ��ȯ => �׷� �� �Լ� ���� ��� ��ȯ
    
    * SELECT ���� ������ �Լ��� �׷� �Լ��� ���� ����� �Ұ����ϴ�. 
    => ��ȯ ��� ���� ������ �ٸ���.
    
    * �Լ����� ����ϴ� ��ġ : SELECT, WHERE, ORDER BY, GROUP BY, HAVING
*/
--==============================================================================
-- ������ �Լ� 
/*
    ���� Ÿ�� ������ ó�� �Լ�
    -> Varachar2(n), Char(n)
    
    * LENGTH (�÷��� �Ǵ� '���ڿ�') : �ش� ���ڿ��� ���� �� ��ȯ
    * LENGTHB (�÷��� �Ǵ� '���ڿ�') : �ش� ���ڿ��� ����Ʈ ���� ��ȯ
    
    => ����, ����, Ư������ : ���� �� 1byte�� ó��
    => �ѱ� : ���� �� 3byte�� ó��
*/
-- '����Ŭ' �ܾ��� ���ڼ�, ����Ʈ�� Ȯ��
SELECT LENGTH('����Ŭ') AS "���ڼ�", LENGTHB('����Ŭ') AS "����Ʈ��" FROM DUAL;

-- 'oracle' �ܾ��� ���ڼ�, ����Ʈ�� Ȯ��
SELECT LENGTH('ORACLE') AS ���ڼ�, LENGTHB('ORACLE') AS ����Ʈ�� FROM DUAL;

-- ��� ���� �� �����, ������� ���� ��, ������� ����Ʈ �� Ȯ��, �̸���, �̸����� ���� ��, �̸����� ����Ʈ �� ��ȸ
SELECT EMP_NAME AS �����, LENGTH(EMP_NAME) AS ���ڼ�, EMAIL AS �̸���, LENGTHB(EMP_NAME) AS ����Ʈ��, 
       LENGTH(EMAIL) AS "�̸��� ���� ��", LENGTHB(EMAIL) AS "�̸��� ����Ʈ ��" 
FROM EMPLOYEE;

/*
    * INSTR : ���ڿ� �� Ư�� ������ ���� ��ġ ��ȯ
    
    [ǥ����]
    INSTR(�÷� �Ǵ� '���ڿ�', 'Ư������'[, ���� ��ġ, ����])
    => ���� ��� ���� ���� Ÿ��(Number) ��ȯ
*/
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- ���ڿ��� ���� ��ġ���� ù��° 'B'�� ��ġ ��ȯ
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- ���� ��ġ �⺻ �� : 1
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- ���� ��ġ�� ���� ���� �����ϸ� ���ڿ��� ���������� ã�´�.
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- ���ڿ��� ���� ��ġ���� 2��° ��ġ�� 'B'�� ��ġ ��ȯ

-- ��� ���� �� �̸���, �̸��� �� '_'�� ù��° ��ġ, �̸��� �� '@'�� ù��° ��ġ ��ȸ 
SELECT EMAIL �̸���, INSTR(EMAIL, '_'), INSTR(EMAIL, '@') FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    * SUBSTR : ���ڿ����� Ư�� ���ڿ� �����ؼ� ��ȯ
    
    [ǥ����]
    SUBSTR('���ڿ�' �Ǵ� �÷�, ������ġ[, ����(����)]) 
    => ���̸� �����ϸ� ������ġ���� ���ڿ� ������ ����
*/

SELECT SUBSTR('ORACLE SQL DEVELOPER', 10) FROM DUAL; -- 10��° ��ġ ~ �� ����
SELECT SUBSTR('ORACLE SQL DEVELOPER', 12) FROM DUAL;

-- �� ���ڿ����� 'SQL' ����
SELECT SUBSTR('ORACLE SQL DEVELOPER', 8, 3) FROM DUAL; -- 8��° ��ġ���� �� ���� ����

SELECT SUBSTR('ORACLE SQL DEVELOPER', -3) FROM DUAL; -- �ڿ��� 3��° ��ġ ~ �� ����

SELECT SUBSTR('ORACLE SQL DEVELOPER', -9) FROM DUAL; 

SELECT SUBSTR('ORACLE SQL DEVELOPER', -9, 3) FROM DUAL; 

-- ��� �� ������� �̸�, �ֹι�ȣ ��ȸ 
SELECT EMP_NAME �̸�, EMP_NO �ֹι�ȣ FROM EMPLOYEE WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';
SELECT EMP_NAME �̸�, EMP_NO �ֹι�ȣ FROM EMPLOYEE WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

-- ��� �� ������� �̸�, �ֹι�ȣ ��ȸ (��� �̸� ���� �������� ����)
SELECT EMP_NAME �̸�, EMP_NO �ֹι�ȣ FROM EMPLOYEE WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3') ORDER BY EMP_NAME;

-- ��� ���� �� �����, �̸���, ���̵� ��ȸ (���̵� = �̸��� ���� '@' ������)
SELECT EMP_NAME �����, EMAIL �̸���, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')  - 1) ���̵� FROM EMPLOYEE;

--------------------------------------------------------------------------------
/*
    * LPAD / RPAD : ���ڿ� ��ȸ �� ���� ������ �����ϱ� ���� ���
    
    [ǥ����]
    LPAD('���ڿ�' �Ǵ� �÷�, �� ����[, '�����Ϲ���']) -- Left pad�� �������� '�����Ϲ���'�� �߰��Ͽ� ���� ���� ����
    RPAD('���ڿ�' �Ǵ� �÷�, �� ����[, '�����Ϲ���']) -- Right pad�� ���������� '�����Ϲ���'�� �߰��Ͽ� ���� ���� ����
    => '�����Ϲ���'�� �����ϸ� �������� ä������.
    => �� ���̴� ���ڿ��� ���Ե� ���ڿ� '�����Ϲ���' ������ ���� ����
*/
-- ��� ���� �� ����� �������� ������ ä�� ���� 20���� ��ȸ
SELECT EMP_NAME, LPAD(EMP_NAME, 20) "�����" FROM EMPLOYEE;

-- ��� ���� �� ����� ���������� ������ ä�� ���� 20���� ��ȸ 
SELECT EMP_NAME, RPAD(EMP_NAME, 20) "�����" FROM EMPLOYEE;

-- ��� ���� �� �����, �̸��� ��ȸ �� �̸��� ���� 20���� ������ ����
SELECT EMP_NAME �����, LPAD(EMAIL, 20) �̸��� FROM EMPLOYEE;

-- ��� ���� �� �����, �̸��� ��ȸ �� �̸��� ���� 20���� ���� ����
SELECT EMP_NAME �����, RPAD(EMAIL, 20) �̸��� FROM EMPLOYEE;

-- ��� ���� �� �����, �̸��� ��ȸ �� �̸��� '#'���� ���� ����
SELECT EMP_NAME �����, RPAD(EMAIL, 20, '#') �̸��� FROM EMPLOYEE;

-- �ֹι�ȣ ������
SELECT '000000-0' �ֹι�ȣ, RPAD('000000-0', 14, '#') ������ȣ FROM EMPLOYEE;

-- ��� ���� �� �����, �ֹι�ȣ ��ȸ
-- �ֹι�ȣ�� -1****** �� �������� ��ȸ
-- (������, ����, ����)

SELECT EMP_NO �ֹι�ȣ, RPAD(SUBSTR(EMP_NO, 1, 8), LENGTH(EMP_NO), '*') FROM EMPLOYEE;

--------------------------------------------------------------------------------

/*
    * LTRIM / RTRIM : ���ڿ����� Ư�� ���ڸ� ���� �� ������ ��ȯ
    [ǥ����]
    LTRIM(���ڿ� �Ǵ� �÷�[, '�����ҹ���'])
    RTRIM(���ڿ� �Ǵ� �÷�[, '�����ҹ���'])
    => ���� ���ڸ� �������� �ʴ� ��� ������ �����Ѵ�.
*/
SELECT LTRIM('     H I') FROM DUAL; -- ���ʺ��� ������ �ƴ� ���ڰ� ���ö����� ���� ����
SELECT RTRIM('H I     ') FROM DUAL;

SELECT LTRIM('123123H123', '123') FROM DUAL; -- H123
SELECT LTRIM('123123H123', '321') FROM DUAL; -- H123
SELECT RTRIM('123123H123', '123') FROM DUAL; -- 123123H

SELECT LTRIM('KKHHII', '123') FROM DUAL;

/*
    * TRIM : ���ڿ� ��/��/���ʿ� �ִ� '�����ѹ���'���� ���� �� ������ �� ��ȯ
    
    [ǥ����]
    TRIM([LEADING | TRAILING | BOTH] ['�����ҹ���' FROM] ���ڿ� �Ǵ� �÷�)
    
    * ù��° �ɼ� ���� �� �⺻ �� : BOTH
    * ������ ���� ���� �� ���� ����
*/
SELECT TRIM('      B    I       ') FROM DUAL; -- ���� ���� ����

-- 'LLLLLHLILLLLL' ���ڿ����� ���� 'L' ����
SELECT TRIM('L' FROM 'LLLLLHLILLLLL') FROM DUAL;
SELECT TRIM(BOTH 'L' FROM 'LLLLLHLILLLLL') FROM DUAL; -- �⺻ �� Ȯ��
SELECT TRIM(LEADING 'L' FROM 'LLLLLHLILLLLL') FROM DUAL; -- ���� �� ���� (LTRIM �� ����)
SELECT TRIM(TRAILING 'L' FROM 'LLLLLHLILLLLL') FROM DUAL; -- ������ �� ���� (RTRIM �� ����)

--------------------------------------------------------------------------------

/*
    * LOWER / UPPER / INICAP
    - LOWER : ���ڿ��� ��� �ҹ��ڷ� ��ȯ�Ͽ� ��ȯ
    - UPPER : ���ڿ��� ��� �빮�ڷ� ��ȯ�Ͽ� ��ȯ
    - INITCAP : ���� ���� ù ���ڸ��� �빮�ڷ� ��ȯ�Ͽ� ��ȯ
*/
-- * 'Oh my god'
SELECT LOWER('Oh my god') FROM DUAL; -- ��� ������ �ҹ��ڷ� ��ȯ
SELECT UPPER('Oh my god') FROM DUAL; -- ��� ������ �빮�ڷ� ��ȯ
SELECT INITCAP('Oh my god') FROM DUAL; -- ���� ���� ��� ù ���ڸ� �빮�ڷ� ��ȯ

--------------------------------------------------------------------------------

/*
    * Concat : ���ڿ� �� ���� �ϳ��� ���ڿ��� ��ģ �� ��ȯ
    
    [ǥ����]
    CONCAT(���ڿ�1, ���ڿ�2)
*/
SELECT 'KH', 'A������' FROM DUAL;
SELECT 'KH' || ' ' || 'A������' FROM DUAL;
SELECT CONCAT('KH ', 'A������') FROM DUAL;

-- ��� ���� �� ����� ��ȸ (* [�����]�� �������� ��ȸ)
SELECT EMP_NAME || ' ' || '��' FROM EMPLOYEE;
SELECT CONCAT(EMP_NAME, '��') ����� FROM EMPLOYEE;

-- 200�����ϴ� �������� ��ȸ *CONCAT �Լ� ���
SELECT CONCAT(EMP_ID, CONCAT(EMP_NAME, '��')) ������� FROM EMPLOYEE;

--------------------------------------------------------------------------------
/*
    * REPLACE : ���ڿ����� Ư�� ����/���ڿ��� ������ ����/���ڿ��� �����Ͽ� ��ȯ
    
    [ǥ����] 
    REPLACE(���ڿ�, 'Ư�����ڿ�', '�����ҹ���/���ڿ�')    
*/
SELECT REPLACE('����� ������', '������', '���α�') FROM DUAL;

-- ��� ���� �� �̸��� �������� '@kh.or.kr' �κ��� '@gmail.com'���� �����Ͽ� ��ȸ
SELECT EMAIL, REPLACE(EMAIL, '@kh.or.kr', '@gmail.com') �����̸��� FROM EMPLOYEE;

--==============================================================================

/*
    [ ���� Ÿ�� �Լ� ]
*/

/*
    ABS : ������ ���� ���� ���ϴ� �Լ�
*/
SELECT ABS(-100) FROM DUAL;
SELECT ABS(-12.34) FROM DUAL;

--------------------------------------------------------------------------------

/*
    * MOD : �� ���� ���� ������ ���� ���ϴ� �Լ�
    MOD(����1, ����2) => ����1 % ����2
*/
-- 10�� 3���� ���� ������
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;

--------------------------------------------------------------------------------

/*
    * ROUND : ������ ��ġ���� �ݿø� ���� ���ϴ� �Լ�
    ROUND(����[, �ݿø�������ġ]) : ���� �� ù°�ڸ��� �⺻ ��
*/
SELECT ROUND(123.456) FROM DUAL; -- ù°�ڸ� �� .4 ��ġ���� �ݿø�
SELECT ROUND(123.456, 1) FROM DUAL; -- ù°�ڸ� ������ ǥ��, ���� ������ �ݿø�
SELECT ROUND(123.456, 2) FROM DUAL; -- ��°�ڸ� ������ ǥ��, ���� ������ �ݿø�

SELECT ROUND(123.456, -1) FROM DUAL; -- 120
SELECT ROUND(546.456, -1) FROM DUAL; -- 550
-- > ��ġ ���� ����� �Ҽ� �κ�, ������ ���� �κ� �ݿø�

--------------------------------------------------------------------------------
/*
    * CEIL : �Ҽ��� �ø� ���� ���ϴ� �Լ� 
*/
SELECT CEIL(123.456) FROM DUAL; -- 124

/*
    * FLOOR : �Ҽ��� ���� ���� ���ϴ� �Լ�
*/
SELECT FLOOR(123.456) FROM DUAL; -- 123

/*
    * TRUNC : ����ó�� �� ����� ��ȯ�ϴ� �Լ� (��ġ ���� ����)
    ������ ��ġ���� ǥ��, �� �� ���� ����
*/

SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;

--==============================================================================
/*
    [ ��¥ Ÿ�� ���� �Լ� ]
*/
-- SYSDATE : �ý����� ���� ��¥ �� �ð� ��ȯ
SELECT SYSDATE FROM DUAL;

-- MONTHS_BETWEEN : �� ��¥ ������ ���� �� ��ȯ
-- [ǥ����] MONTHS_BETWEEN(��¥A, ��¥B) : ��¥A - ��¥B => ���� �� ��ȯ

-- ���� ���� ���� ���� �� (������: 24/12/31)
SELECT MONTHS_BETWEEN(SYSDATE, '24/12/31') || '����' FROM DUAL;

-- ������� ���� ���� �� (������: 25/06/18)
SELECT MONTHS_BETWEEN(SYSDATE, '25/06/18') FROM DUAL; -- -3.XXXXXXXXXXXXXXXXX
SELECT FLOOR(MONTHS_BETWEEN('25/06/18', SYSDATE)) || '����' FROM DUAL;
SELECT CEIL(ABS(MONTHS_BETWEEN(SYSDATE, '25/06/18'))) || '����' FROM DUAL;

-- ��� ���� �� �����, �Ի���, �ټӰ����� ��ȸ
SELECT EMP_NAME �����, HIRE_DATE �Ի���, CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '������' �ټӰ����� FROM EMPLOYEE WHERE ENT_DATE IS NULL;

/*
    * ADD_MONTHS : Ư�� ��¥�� N���� ���� ���� ���� ��ȯ
    [ǥ����]
    ADD_MONTHS(��¥, ���Ұ�����)
*/
-- ���� ��¥ ���� 3���� �� ��ȸ
SELECT SYSDATE ���糯¥, ADD_MONTHS(SYSDATE, 3) "3���� ��" FROM DUAL;

-- ��� ���� �� �����, �Ի���, ���� ������ ��ȸ
-- * �����Ⱓ : �Ի��� + 3����
SELECT EMP_NAME �����, HIRE_DATE �Ի���, ADD_MONTHS(HIRE_DATE, 3) "���� ������" FROM EMPLOYEE;

/*
    * NEXT_DAY : Ư�� ��¥ ���� ���� ������ ���� ����� ��¥ ��ȯ
    
    [ǥ����]
    NEXT_DAY(��¥, ����)
    * ���� : ���� �Ǵ� ����
    ���� : 1(��) ~ 7(��)
    
    - ���� Ÿ������ ���� �� ��� ������ ���� ����ؾ� �Ѵ�. 
    - ���� Ÿ���� ���� ���� ���� ����
*/
-- ���� ��¥ ���� ���� ����� �Ͽ����� ��¥ ��ȸ
ALTER SESSION SET NLS_LANGUAGE = KOREAN; -- ��� ���� ���� ��ɾ�
SELECT NEXT_DAY(SYSDATE, 1) FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '�Ͽ���') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT NEXT_DAY(SYSDATE, 'SUN') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 'SUNDAY') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;

--------------------------------------------------------------------------------
/*
    * LAST_DAY : �ش� �� ������ ��¥ ��ȯ 
*/
SELECT LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY(ADD_MONTHS(SYSDATE, 3)) FROM DUAL;

-- ��� ���� �� �����, �Ի���, �Ի��� ���� ������ ��¥, �Ի��� ���� �ٹ� �ϼ� ��ȸ
SELECT EMP_NAME �����, HIRE_DATE �Ի���, LAST_DAY(HIRE_DATE) "�Ի��� �� ������ ��¥", 
        LAST_DAY(HIRE_DATE) - HIRE_DATE + 1 "�Ի�� �ٹ��� ��"
FROM EMPLOYEE;

--------------------------------------------------------------------------------
/*
    * EXTRACT : Ư�� ��¥�κ��� ����/��/�� ���� �����Ͽ� ��ȯ
    [ǥ����]
    EXTRACT(YEAR FROM '��¥') : �ش� ��¥�� ����
    EXTRACT(MONTH FROM '��¥') : �ش� ��¥�� ��
    EXTRACT(DAY FROM '��¥') : �ش� ��¥�� ��
*/
-- ���� ��¥�� ����/��/�� �����Ͽ� ��ȸ
SELECT SYSDATE "���� ��¥", 
        EXTRACT(YEAR FROM SYSDATE) ����, 
        EXTRACT(MONTH FROM SYSDATE) ��,
        EXTRACT(DAY FROM SYSDATE) ��
FROM DUAL;

-- ��� ���� �� �����, �Ի翬��, �Ի��, �Ի��� ��ȸ (* ���� : �Ի翬�� -> �Ի�� -> �Ի��� �������� ����)
SELECT EMP_NAME �����, 
        EXTRACT(YEAR FROM HIRE_DATE) �Ի翬��, 
        EXTRACT(MONTH FROM HIRE_DATE) �Ի��, 
        EXTRACT(DAY FROM HIRE_DATE) �Ի���
FROM EMPLOYEE
ORDER BY 2, 3, 4;
        -- "�Ի翬��", "�Ի��", "�Ի���"
/*
        EXTRACT(YEAR FROM HIRE_DATE), 
        EXTRACT(MONTH FROM HIRE_DATE), 
        EXTRACT(DAY FROM HIRE_DATE);
*/
--==============================================================================
/*
    * ����ȯ �Լ� : ������ Ÿ���� �����ϴ� �Լ�
    -> ���� / ���� / ��¥
*/

/*
    * TO_CHAR : ���� �Ǵ� ��¥ Ÿ���� ���� ���� Ÿ������ �����ϴ� �Լ�
    [ǥ����] 
    TO_CHAR(���� �Ǵ� ��¥[, ����]) 
*/
-- * ���� Ÿ�� -> ���� Ÿ��
SELECT 1234 "���� Ÿ���� ������", TO_CHAR(1234) "���� Ÿ������ ����� ����" FROM DUAL;

-- => 9 : �������� 9�� ������ŭ �ڸ� ���� Ȯ���Ͽ� ���ڸ��� �������� ä���. ������ ����
SELECT 
    TO_CHAR(1234) "Ÿ�� ���游 �� ������", 
    TO_CHAR(1234, '999999') "��������������" 
FROM DUAL;

-- => 0 : �������� 0�� ������ŭ �ڸ� ���� Ȯ���Ͽ� ���ڸ��� 0���� ä���. ������ ����
SELECT 
    TO_CHAR(1234) "Ÿ�� ���游 �� ������", 
    TO_CHAR(1234, '000000') "��������������" 
FROM DUAL;

-- => L : ���� ������ �� ���� ȭ�� ���� ǥ��
SELECT 
    TO_CHAR(1234) "Ÿ�� ���游 �� ������", 
    TO_CHAR(1234, 'L999999') "��������������" 
FROM DUAL;

-- => $ : ������ �տ� �߰�
SELECT 
    TO_CHAR(1234) "Ÿ�� ���游 �� ������", 
    TO_CHAR(1234, '$999999') "��������������" 
FROM DUAL;

-- => ���ڿ� �ڸ� �� ǥ��
SELECT 1000000, TO_CHAR(1000000, 'L9,999,999') FROM DUAL;

-- ����� �����, ����, ���� ��ȸ (����, ������ ȭ�� ����, �ڸ� �� ���� ǥ��)
SELECT 
    EMP_NAME �����,
    TO_CHAR(SALARY, 'L9,999,999') ����, 
    TO_CHAR(SALARY * 12, 'L999,999,999') ����
FROM EMPLOYEE;
--------------------------------------------------------------------------------

-- ��¥ Ÿ�� -> ���� Ÿ��
SELECT SYSDATE, TO_CHAR(SYSDATE) "���ڷ� ����ȯ" FROM DUAL;

/*
    * �ð� ���� ����
    - HH : �� ���� (hour), 12�ð���
    - HH24 : �� ���� (hour), 24�ð���
    
    - MI : �� ���� (minute)
    - SS : �� ���� (seconds)
    
    - AM : ���� �ؽ�Ʈ ǥ��
    - PM : ���� �ؽ�Ʈ ǥ��
*/
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;

/*
    * ���� ���� ����
    - DAY : X����, ������, ȭ����, ... 
    - DY : X, ��, ȭ, ��, ...
    - D : ���� Ÿ������ ���� ���� ǥ�� (1 ~ 7), 1 = �Ͽ���
*/
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY D') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'DAY') FROM DUAL;

/*
    * �� ���� ����
    - MON, MONTH : X��, 1��, 2��, 3��, ...
    - MM : �� ������ 2�ڸ��� ǥ��
*/
SELECT TO_CHAR(SYSDATE, 'MON MONTH') FROM DUAL;

/*
    * �� ���� ����
    - DD : �� ������ 2�ڸ��� ǥ��
    - DDD : �ش� ��¥�� �ش� ���� ���� �� ��° �ϼ����� ǥ��
*/
SELECT TO_CHAR(SYSDATE, 'DD') "2�ڸ�ǥ��", TO_CHAR(SYSDATE, 'DDD') "�� ��° ��" FROM DUAL;

/*
    * ���� ���� ����
    - YYYY : ���� �� �ڸ� ǥ��
    - YY : ���� �� �ڸ� ǥ��
    
    - RRRR : ���� �� �ڸ� ǥ��
    - RR : ���� �� �ڸ� ǥ��
    => 
    00 ~ 49 ������ ������ �Է��� �� 
    ���� ������ �� ���ڸ��� 00 ~ 49 ������ ���� ������ ���� ������ ������ �� ���ڸ� ���� ǥ��
    
    ���� ������ �� ���ڸ��� 50 ~ 99 ������ ���̸� ���� ������ �� ���ڸ� + 1
    
    50 ~ 99 ������ ������ �Է��� �� 
    ���� ������ �� ���ڸ��� 00 ~ 49 ������ ���̸� ���� ������ �� ���ڸ� - 1
    
    ���� ������ �� ���ڸ��� 50 ~ 99 ������ ���� ������ ���� ������ ������ �� ���ڸ� ���� ǥ��
*/
SELECT 
    TO_CHAR(TO_DATE('250304', 'RRMMDD'), 'YYYY') "RR���(50�̸�)", -- 2025
    TO_CHAR(TO_DATE('550304', 'RRMMDD'), 'YYYY') "RR���(50�̻�)", -- 1955
    TO_CHAR(TO_DATE('250304', 'YYMMDD'), 'YYYY') "YY���(50�̸�)", -- 2025
    TO_CHAR(TO_DATE('550304', 'YYMMDD'), 'YYYY') "YY���(50�̻�)" -- 2055
FROM DUAL;

-- ��� ���� �� �����, �Ի� ��¥ ��ȸ 
-- (��, �Ի� ��¥ ������ "XXXX�� XX�� XX��" �������� ��ȸ)
-- Ư�� ���ڿ� ���� ������ ""�� ǥ���ؾ� �Ѵ�. 
SELECT EMP_NAME �����, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"') "�Ի� ��¥" FROM EMPLOYEE;

/*
    * TO_DATE : ���� Ÿ�� �Ǵ� ���� Ÿ���� ��¥ Ÿ������ �������ִ� �Լ�
    [ǥ����]
    TO_DATE(���� �Ǵ� ����[, ����])
*/
SELECT TO_DATE(20250304) FROM DUAL;
SELECT TO_DATE(250304) FROM DUAL;
SELECT TO_DATE(550304) FROM DUAL; -- 50�� �̻��� 19XX������ ����ȴ�. 

SELECT TO_DATE(020222) FROM DUAL; -- ERROR, ���ڴ� 0���� ������ �� ����.
SELECT TO_DATE('020222') FROM DUAL; -- 0���� ������ ��� ���ڷ� �����ϸ� �ȴ�.

SELECT TO_DATE('20250304 104230') FROM DUAL; -- ERROR, �ð��� �����ϴ� ���, ������ �����ؾ� �Ѵ�. 
SELECT TO_DATE('20250304 104230', 'YYYYMMDD HH24MISS') FROM DUAL;

/*
    * TO_NUMBER : ���� Ÿ���� �����͸� ���� Ÿ������ ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
    [ǥ����]
    
    TO_NUMBER(����[, ����])
    -> ��ȣ�� ���Եǰų� ȭ�� ������ �����ϴ� ��� ���� ����
*/
SELECT TO_NUMBER('0123456789') FROM DUAL;
SELECT '10000' + '500' FROM DUAL;
SELECT '10,000' + '500' FROM DUAL; -- ERROR ','�� ���� ��ȣ�� ���ԵǴ� ��� ���� �߻�

SELECT TO_NUMBER('10,000', '99,999') + TO_NUMBER('500', '999') FROM DUAL;
--==============================================================================

/*
    * NULL ó�� �Լ�
*/

/*
    * NVL : �ش� �÷��� ���� NULL�� ��� �ٸ� ������ ����� �� �ֵ��� ��ȯ�ϴ� �Լ�
    
    [ǥ����]
    NVL(�÷���, �ش� �÷��� ���� NULL�� ��� ����� ��)
*/
-- ��� ���� �� �����, ���ʽ� ��ȸ
-- (��, ���ʽ� ���� NULL�� ��� 0���� ǥ��)
SELECT EMP_NAME �����, BONUS, NVL(BONUS, '0') ���ʽ� FROM EMPLOYEE;

-- ��� ���� �� �����, ���ʽ�, ����, ���ʽ� ���� ���� ���� ��ȸ 
SELECT EMP_NAME �����, NVL(BONUS, 0), SALARY * 12 ����, (SALARY + (SALARY * NVL(BONUS, 0))) * 12 "������ ���� ����" FROM EMPLOYEE;

/*
    * NVL2 : �ش� �÷��� ���� NULL�� ��� ������ ǥ���� ��, NULL�� �ƴ� ��� ������ ǥ���� ������ ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
    
    [ǥ����]
    NVL2(�÷���, �����Ͱ� �����ϴ� ��� ����� ��, NULL�� ��� ����� ��)
*/
-- ��� ���� �� �����, ���ʽ� ���� ��ȸ (���ʽ��� ���� ��� 'O', ���� ��� 'X')
SELECT EMP_NAME �����, NVL2(BONUS, 'O', 'X') "���ʽ� ����" FROM EMPLOYEE;

-- ��� ���� �� �����, �μ��ڵ�, �μ� ��ġ ���� ��ȸ (��ġ�� �� ��� '�����Ϸ�', �ƴ� ��� '�̹���' ǥ��)
SELECT EMP_NAME �����, DEPT_CODE "�μ� �ڵ�", NVL2(DEPT_CODE, '�����Ϸ�', '�̹���') "��ġ ����" FROM EMPLOYEE;

/*
    NULLIF : ������ �� ���� ��ġ�ϸ� NULL, ��ġ���� �ʴ� ��� ù ��° ���� ���� ��ȯ�ϴ� �Լ�
    [ǥ����]
    NULLIF(��1, ��2) 
*/
SELECT NULLIF('999', '999') FROM DUAL;
SELECT NULLIF('999', '555') FROM DUAL;

/*
    * ���� �Լ�
    DECODE(�� ���, �� ��1, ��� ��1, �� ��2, ��� ��2, ...)
    �ڹ��� switch���ϰ� ����
*/
-- ��� ���� �� ���, �����, �ֹι�ȣ, ���� ��ȸ 
-- (��, ������ '1' : ��, '2' : ��, �� �� �� �� ����)
SELECT EMP_ID ���, EMP_NAME �����, EMP_NO �ֹι�ȣ, DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��', '�� �� ����') ���� FROM EMPLOYEE;

-- ��� ���� �� �����, ���� �޿�, �λ� �޿� ��ȸ
/*
    �λ� ����
    ������ 'J7'�� ����� 0.1 �λ�
    ������ 'J6'�� ����� 0.15 �λ�
    ������ 'J5'�� ����� 0.2 �λ� 
    �� �� 0.05 �λ�
*/
SELECT EMP_NAME �����, SALARY "���� �޿�", DECODE(JOB_CODE, 'J7', SALARY * 1.1, 'J6', SALARY * 1.15, 'J5', SALARY * 1.2, SALARY * 1.05) "�λ�� �޿�" FROM EMPLOYEE;

/*
    * CASE WHEN THEN : ���ǿ� ���� ��� ���� ��ȯ�ϴ� �Լ�
    [ǥ����]
    CASE 
        WHEN ���ǽ�1 THEN �����1
        WHEN ���ǽ�2 THEN �����2
        ...
        ELSE �����
    END
    �ڹ��� if ~ else ���� ����
*/
-- ��� ���� �� �����, �޿�, �޿��� ���� ��� ��ȸ 
/*
    �޿��� ���� ��� ����
    500���� �̻� '���'
    350���� �̻� '�߱�'
    �� �� '�ʱ�'
*/
SELECT 
    EMP_NAME �����, 
    SALARY �޿�, 
    CASE 
        WHEN SALARY >= '5000000' THEN '���'
        WHEN SALARY >= '3500000' THEN '�߱�'
        ELSE '�ʱ�'
    END "�޿��� ���� ���"
FROM EMPLOYEE;
--==============================================================================
-- �׷� �Լ�
/*
    * SUM : �÷� ������ �� ���� ��ȯ���ִ� �Լ�
    [ǥ����]
    SUM(����Ÿ���÷�)
*/
-- ��ü ������� �� �޿� ��ȸ
SELECT SUM(SALARY) FROM EMPLOYEE;

-- 'XXX,XXX,XXX' �������� ��ȸ
SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') FROM EMPLOYEE;

-- �� ������� �� �޿� 
SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') FROM EMPLOYEE 
-- WHERE SUBSTR(EMP_NO, 8, 1) IN('1', '3');
WHERE SUBSTR(EMP_NO, 8) LIKE '1%';

-- �μ� �ڵ尡 'D5'�� ����� �� ���� ��ȸ 
SELECT TO_CHAR(SUM(SALARY * 12), 'L999,999,999') "D5 �μ��� �� ����" FROM EMPLOYEE WHERE DEPT_CODE = 'D5';
--------------------------------------------------------------------------------
/*
    * AVG : ������ ������ ��� ���� ����Ͽ� ��ȯ�ϴ� �Լ�
    [ǥ����]
    AVG(���� Ÿ�� �÷�)
*/
-- ��ü ����� ��� �޿� ��ȸ (* �ݿø� ����)
SELECT TO_CHAR(ROUND(AVG(SALARY)), 'L999,999,999') FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    * MIN : �ش� �÷��� �ּ� ���� ��ȯ�ϴ� �Լ�
    
    [ǥ����]
    MIN(��� Ÿ�� �÷�)
*/
SELECT MIN(EMP_NAME) "���� Ÿ���� �ּ� ��", MIN(SALARY) "���� Ÿ���� �ּ� ��", MIN(HIRE_DATE) "��¥ Ÿ���� �ּ� ��" FROM EMPLOYEE;

/*
    * MAX : �ش� �÷��� �ִ� ���� ��ȯ�ϴ� �Լ�
    [ǥ����]
    MAX(��� Ÿ�� �÷�)
*/
SELECT MAX(EMP_NAME) "���� Ÿ���� �ִ� ��", MAX(SALARY) "���� Ÿ���� �ִ� ��", MAX(HIRE_DATE) "��¥ Ÿ���� �ִ� ��" FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    * COUNT : ���� ������ ��ȯ�ϴ� �Լ� (��, ������ ���� ��� �ش� ���ǿ� �´� ���� ���� ��ȯ)
    [ǥ����]
    COUNT(*) : ��ȸ�� ����� ��� ���� ���� ��ȯ
    COUNT(COLUMN) : �ش� �÷��� ���� NULL�� �ƴ� ���� ������ ����ؼ� ��ȯ
    COUNT(DISTINCT COLUMN) : �ش� �÷� �� �� �ߺ� ���� ������ ���� ������ ����ؼ� ��ȯ
    => �ߺ� ���� �� NULL�� �������� �ʰ� ����Ѵ�. 
*/
-- ��ü ��� �� ��ȸ
SELECT COUNT(*) FROM EMPLOYEE;

-- �� ���� �� ��ȸ
SELECT COUNT(*) "������ ��" FROM EMPLOYEE WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');

-- �� ���� �� ��ȸ
SELECT COUNT(*) "������ ��" FROM EMPLOYEE WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

-- ���ʽ��� �޴� ��� ��
SELECT COUNT(*) "���ʽ��� �޴� ��� ��" FROM EMPLOYEE WHERE BONUS IS NOT NULL;
SELECT COUNT(BONUS) "���ʽ��� �޴� ��� ��" FROM EMPLOYEE;

-- �μ� ��ġ�� ���� ��� �� ��ȸ
SELECT COUNT(*) "�μ� ��ġ�� ���� ��� ��" FROM EMPLOYEE WHERE DEPT_CODE IS NOT NULL;
SELECT COUNT(DEPT_CODE) "�μ� ��ġ�� ���� ��� ��" FROM EMPLOYEE;

SELECT COUNT(DISTINCT DEPT_CODE) "�Ҽ� ����� �ִ� �μ� ��" FROM EMPLOYEE;









