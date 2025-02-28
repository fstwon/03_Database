/*
    1. SELECT : ������ ��ȸ(����) 
    
    [ǥ����]
    SELECT ��ȸ ���� FROM ���̺��;
    
    SELECT �÷���1, �÷���2, ... �Ǵ� * FROM ���̺��;
*/

-- ��� ��� ���� ��ȸ
SELECT * FROM EMPLOYEE;

-- ��� ����� �̸�, �ֹι�ȣ, ����ó ��ȸ
SELECT EMP_NAME, EMP_NO, PHONE FROM EMPLOYEE;

-- ��� ���� ���� ��ȸ 
SELECT * FROM JOB;

-- ���� ���� �� ���޸� ��ȸ 
SELECT JOB_NAME FROM JOB;

-- ��� ���̺��� �����, �̸���, ����ó, �Ի���, �޿� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY FROM EMPLOYEE;

/*
    �÷��� ��� ���� �߰�
    SELECT ���� �÷��� �κп� ��� ���� ����
*/
-- �����, ���� ���� ��ȸ
-- ���� = �޿� * 12 (SALARY �÷� �����Ϳ� 12 ���� �����Ͽ� ��� ǥ��)
SELECT EMP_NAME, SALARY * 12 FROM EMPLOYEE;

-- �����, �޿�, ���ʽ�, ����, ���ʽ� ���� ���� ���� ��ȸ
SELECT EMP_NAME, SALARY, BONUS, SALARY * 12, (SALARY + (SALARY * BONUS)) * 12 FROM EMPLOYEE;


/*
    �÷� ��Ī �ο�
    ������� ����� ��� �ǹ̸� �ľ��ϱ� ��Ʊ� ������ ��Ī�� �ο��Ͽ� ���������� ��ȸ ����
    
    [ǥ����]
    (1) �÷��� ��Ī
    (2) �÷��� AS ��Ī
    (3) �÷��� "��Ī"
    (4) �÷��� AS "��Ī"
*/
-- ��� ����� �����, �޿�, ���ʽ�, ����, ���ʽ� ���� ���� ���� ��ȸ (* ��Ī �ο�)
SELECT EMP_NAME �����, SALARY AS �޿�, BONUS "���ʽ�", SALARY * 12 AS "����", (SALARY + SALARY * BONUS) * 12 AS "���ʽ� ���� ���� ����" FROM EMPLOYEE;

/*
    - ���� ��¥�ð� ���� : SYSDATE
    - ���� ���̺� (�ӽ� ���̺�) : DUAL
*/
-- ���� ��¥/�ð� ���� ��ȸ
SELECT SYSDATE FROM DUAL; -- YY/MM/DD �������� ��� ǥ��

-- ��� ����� �����, �Ի���, �ٹ��ϼ� ��ȸ 
-- �ٹ��ϼ� = ���� ��¥ - �Ի��� + 1
SELECT EMP_NAME, HIRE_DATE, SYSDATE - HIRE_DATE + 1 "�ٹ��ϼ�" FROM EMPLOYEE;
-- DATE Ÿ�� - DATE Ÿ�� => �� ������ ǥ��

/*
    * ���ͷ� (�� ��ü) : ���Ƿ� ������ ���� ���ڿ�('') ǥ�� �Ǵ� ����
    -> SELECT ���� ����ϴ� ��� ��ȸ�� ���(Result Set)�� �ݺ������� ǥ��
*/
-- �����, �޿�, '��' ��ȸ 
SELECT EMP_NAME "�����", SALARY AS �޿�, '��' ���� FROM EMPLOYEE;

/*
    ���� ������ : || 
    �� ���� �÷��� �����ϰų� ���� �÷��� �����ϴ� ������
*/
-- xxx�� �������� �޿� ���� ��ȸ
SELECT EMP_NAME "�����", SALARY || '��' AS �޿� FROM EMPLOYEE;

-- ���, �̸�, �޿��� �� �÷��� ��ȸ 
SELECT EMP_ID || EMP_NAME || SALARY FROM EMPLOYEE;

-- "XXX�� �޿��� XXXX���Դϴ�" �������� ��ȸ
SELECT EMP_NAME || '�� �޿��� ' || SALARY || '���Դϴ�.' �޿����� FROM EMPLOYEE;

/*
    * �ߺ� ���� : DISTINCT
    �ߺ��� ������� ���� ��� ��ȸ ����� �ϳ��� ǥ��
    SELECT ������ DISTINCT�� �ѹ��� ��� ����
*/
-- ������̺��� �����ڵ� ��ȸ
SELECT JOB_CODE FROM EMPLOYEE;

-- ��� ���̺��� �ߺ� ���� �� ���� �ڵ� ��ȸ 
SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

-- ��� ���̺��� �ߺ� ���� �� �μ� �ڵ� ��ȸ 
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE;
SELECT DISTINCT DEPT_CODE, JOB_CODE FROM EMPLOYEE;

-- ===============================================

/*
    * WHERE �� : ��ȸ�ϰ��� �ϴ� �����͸� Ư�� ���ǿ� ���� �����ϰ��� �� �� ���
    [ǥ����]
    SELECT �÷�, �÷� �Ǵ� ������ ���� ����� FROM ���̺�� WHERE ����
    - �� ������
    * ��� �� : >, <, >=, <=
    * ���� ��
        - ���� �� �� : =
        - �ٸ� �� �� : !=, <>, ^=
*/

-- ��� ���̺��� �μ��ڵ尡 'D9'�� ������� ���� ��ȸ
SELECT * FROM EMPLOYEE WHERE DEPT_CODE = 'D9';

-- ��� ���� �� �μ��ڵ尡 'D1`�� ������� �����, �޿�, �μ��ڵ� ��ȸ 
SELECT EMP_NAME �����, SALARY �޿�, DEPT_CODE �μ��ڵ� FROM EMPLOYEE WHERE DEPT_CODE = 'D1';

-- ��� ���� �� �μ��ڵ尡 'D1'�� �ƴ� ������� �����, �޿�, �μ��ڵ� ��ȸ 
SELECT EMP_NAME �����, SALARY �޿�, DEPT_CODE �μ��ڵ� FROM EMPLOYEE WHERE DEPT_CODE <> 'D1';

-- �޿��� 400���� �̻��� ������� �����, �μ��ڵ�, �޿� ���� ��ȸ 
SELECT EMP_NAME �����, DEPT_CODE �μ��ڵ�, SALARY �޿� FROM EMPLOYEE WHERE SALARY >= 4000000;

-- �޿��� 400���� �̸��� ������� �����, �μ��ڵ�, �޿� ���� ��ȸ
SELECT EMP_NAME �����, DEPT_CODE "�μ��ڵ�", SALARY AS �޿� FROM EMPLOYEE WHERE SALARY < 4000000;

-- =============================================================================================
-- �ǽ� ����
-- * ��, ���� ��� �� ���ʽ� ���� 

-- [1] �޿��� 300���� �̻��� ������� �����, �޿�, �Ի���, ���� ��ȸ (��Ī ����)
SELECT EMP_NAME �����, SALARY �޿�, HIRE_DATE �Ի���, SALARY * 12 ���� FROM EMPLOYEE;

-- [2] ������ 5000���� �̻��� ������� �����, �޿�, ����, �μ��ڵ� ��ȸ (��Ī ����)
SELECT EMP_NAME �����, SALARY �޿�, SALARY * 12 ����, DEPT_CODE �μ� FROM EMPLOYEE WHERE (SALARY * 12) >= 50000000;

-- [3] ���� �ڵ尡 'J5'�� �ƴ� ������� ���, �����, �����ڵ�, ��翩�� ��ȸ (��Ī ����)
SELECT EMP_ID ���, EMP_NAME �����, JOB_CODE �����ڵ�, ENT_YN ��翩�� FROM EMPLOYEE WHERE JOB_CODE <> 'J5';

-- [4] �޿��� 350���� �̻� 600���� ������ ��� ����� �����, ���, �޿� ��ȸ (��Ī ����)
-- * �� ������ : AND, OR �� ���� ����
SELECT EMP_NAME �����, EMP_ID ���, SALARY �޿� FROM EMPLOYEE WHERE SALARY >= 3500000 AND SALARY <= 6000000;

--------------------------------------------------------------------------------
/*
    * BETWEEN AND : ���ǽĿ��� ���Ǵ� ���� 
    => ~ �̻� ~ ������ ������ ���� ������ �����ϴ� ���� 
    
    [ǥ����]
    �÷��� BETWEEN A AND B
    - �÷��� : �� ��� �÷�
    - A : �ּҰ�
    - B : �ִ밪
    => �ش� �÷��� ���� �ּҰ� �̻��̰� �ִ밪 ������ ���
*/
SELECT EMP_NAME �����, EMP_ID ���, SALARY �޿� FROM EMPLOYEE WHERE SALARY BETWEEN 3500000 AND 6000000;

-- �޿��� 350���� �̸� �Ǵ� 600���� �ʰ��� ����� �����, ���, �޿� ��ȸ
SELECT EMP_NAME �����, EMP_ID ���, SALARY �޿� FROM EMPLOYEE WHERE SALARY < 3500000 OR SALARY > 6000000;


/*
    * ���������� : NOT
*/

-- �޿��� 350���� �̸� �Ǵ� 600���� �ʰ��� ����� �����, ���, �޿� ��ȸ (BETWEEN AND, NOT)
SELECT EMP_NAME �����, EMP_ID ���, SALARY �޿� FROM EMPLOYEE WHERE NOT SALARY BETWEEN 3500000 AND 6000000;

/*
    * IN : �񱳴�� �÷��� ���� ������ ���� �߿� ��ġ�ϴ� ���� �ִ� ��츦 ��ȸ�ϴ� ����
    [ǥ����]
    �÷��� IN (��1, ��2, ��3, ...) 
    �Ʒ��� ������
    �÷��� = ��1 OR �÷��� = ��2 OR �÷��� = ��3 ...
*/
-- �μ��ڵ尡 'D6'�̰ų� 'D8'�̰ų� 'D5'�� ������� �����, �μ��ڵ�, �޿��� ��ȸ (* IN ������� ���� ���)
SELECT EMP_NAME �����, DEPT_CODE �μ��ڵ�, SALARY �޿� FROM EMPLOYEE WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5';
-- �μ��ڵ尡 'D6'�̰ų� 'D8'�̰ų� 'D5'�� ������� �����, �μ��ڵ�, �޿��� ��ȸ (* IN ��� )
SELECT EMP_NAME �����, DEPT_CODE �μ��ڵ�, SALARY �޿� FROM EMPLOYEE WHERE DEPT_CODE IN ('D6', 'D8', 'D5');
--==============================================================================
/*
    * LIKE : ���ϰ��� �ϴ� �÷��� ���� ������ "Ư�� ����"�� ������ ��� ��ȸ
    => Ư�� ����: `%`, `_` ���ϵ�ī�带 ����� ����
    
    * `%` : 0���� �̻�
    ex) �񱳴���÷� LIKE '����%' => '�񱳴���÷�'�� ���� '����'�� �����ϴ� �����͸� ��ȸ
        �񱳴���÷� LIKE '%����' => '�񱳴���÷�'�� ���� '����'�� ������ �����͸� ��ȸ
        �񱳴���÷� LIKE '%����%' => '�񱳴���÷�'�� �� �� '����'�� ������ �����͸� ��ȸ
    
    * `_` : 1����
    ex) �񱳴���÷� LIKE '_����' => '�񱳴���÷�'�� ������ '����'�տ� ������ �� ���ڰ� �����ϴ� ������ ��ȸ
        �񱳴���÷� LIKE '__����' => '�񱳴���÷�'�� ������ '����'�տ� ������ �� ���ڰ� �����ϴ� ������ ��ȸ
        �񱳴���÷� LIKE '_����_' => '�񱳴���÷�'�� ������ '����' �� �ڷ� ������ �� ���ھ� �����ϴ� ������ ��ȸ
*/
-- ��� �� "��"�� ���� ���� ����� �����, �޿�, �Ի��� ��ȸ 
SELECT EMP_NAME AS "�����", SALARY AS "�޿�", HIRE_DATE AS "�Ի���" FROM EMPLOYEE WHERE EMP_NAME LIKE '��%';

-- ����� "��"�� ���Ե� ����� �����, �ֹι�ȣ, ����ó ��ȸ 
SELECT EMP_NAME AS "�����", EMP_NO AS "�ֹι�ȣ", PHONE AS "����ó" FROM EMPLOYEE WHERE EMP_NAME LIKE '%��%';

-- ������� ��� ���ڰ� "��"�� ����� �����, ����ó ��ȸ (* ������� 3������ ���)
SELECT EMP_NAME AS "�����", PHONE AS "����ó" FROM EMPLOYEE WHERE EMP_NAME LIKE '_��_';

-- ��� �� ����ó�� 3��° �ڸ����� 1�� ����� ���, �����, ����ó, �̸��� ��ȸ 
SELECT EMP_ID AS "���", EMP_NAME AS "�����", PHONE AS "����ó", EMAIL AS "�̸���" FROM EMPLOYEE WHERE PHONE LIKE '__1%';

-- ��� �� �̸��� 4��° �ڸ��� _�� ����� ���, �̸�, �̸��� ��ȸ 
SELECT EMP_ID AS "���", EMP_NAME AS "�̸�", EMAIL AS "�̸���" FROM EMPLOYEE WHERE EMAIL LIKE '____%'; 
-- > ���ϴ� ����� Ȯ���� �� ����.
-- > ���ϵ�ī��� ����ϴ� ���ڿ� �÷��� ��� ���ڰ� ������ ��� ��� ���ϵ�ī��� �ν��Ѵ�.
-- > ���ϵ�ī��� ���� ������ ���ڸ� �����ؾ� �Ѵ�.
/*
    [ǥ����]
    �񱳴���÷� LIKE '����' ESCAPE '��ȣ';
*/
SELECT EMP_ID AS "���", EMP_NAME AS "�̸�", EMAIL AS "�̸���" FROM EMPLOYEE WHERE EMAIL LIKE '___#_%' ESCAPE '#';
-- ESCAPE '���ϵ�ī��' �� ����Ͽ� ���� ���ھȿ� '���ϵ�ī��' �� ���ڴ� ���ϵ�ī�嵵 ���ڷ� �ν��Ѵ�. 
-- ESCAPE '���ϵ�ī��'�� ����ڰ� �����Ѵ�. 

-- =============================================================================

/*
    * IS NULL / IS NOT NULL
    �÷� ���� null ���� �ִ� ��� null ���� ���� �� ����ϴ� ������
    
    - IS NULL : �÷� ���� null���� ��
    - IS NOT NULL : �÷� ���� null�� �ƴ� ��� ��
*/
-- ���ʽ��� ���� �ʴ� ����� ���, �����, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID AS "���", EMP_NAME AS "�����", SALARY AS "�޿�", BONUS AS "���ʽ�" FROM EMPLOYEE WHERE BONUS IS NULL;

-- ���ʽ��� �޴� ����� ���, �����, �޿�, ���ʽ� ��ȸ 
SELECT EMP_ID AS "���", EMP_NAME AS "�����", SALARY AS "�޿�", BONUS AS "���ʽ�" FROM EMPLOYEE WHERE BONUS IS NOT NULL;
-- SELECT EMP_ID AS "���", EMP_NAME AS "�����", SALARY AS "�޿�", BONUS AS "���ʽ�" FROM EMPLOYEE WHERE NOT BONUS IS NULL;

-- ����� ���� ����� �����, ������, �μ��ڵ� ��ȸ 
SELECT EMP_NAME AS "�����", MANAGER_ID AS "������", DEPT_CODE AS "�μ��ڵ�" FROM EMPLOYEE WHERE MANAGER_ID IS NULL;

-- �μ� ��ġ�� ���� �ʾ�����, ���ʽ��� �ް� �ִ� ����� �����, ���ʽ�, �μ��ڵ� ��ȸ 
SELECT EMP_NAME AS "�����", BONUS AS "���ʽ�", DEPT_CODE AS "�μ��ڵ�" FROM EMPLOYEE WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

--==============================================================================
-- ���� �ڵ尡 'J7'�̰ų� 'J2'�� ��� �� �޿��� 200���� �̻��� ����� ��� ���� ��ȸ 
-- SELECT * FROM EMPLOYEE WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;
SELECT * FROM EMPLOYEE WHERE JOB_CODE IN ('J7', 'J2') AND SALARY >= 2000000;
/*
    * ������ �켱����
    (0) ()
    (1) ��������� : *, %, +, -
    (2) ���Ῥ���� : ||
    (3) �񱳿����� : >, <, >=, <=, =, <>, !=, ^=
    (4) IS NULL / LIKE '����' / IN
    (5) BETWEEN AND
    (6) NOT 
    (7) AND
    (8) OR
*/
--==============================================================================
/*
    * ����
    ORDER BY 
    => SELECT ������ ���� ������ �ٿ� �ۼ�
    => ���� ���� ���� �������� ����
    
    [ǥ����]
    SELECT ��ȸ���÷�, ...
    FROM ���̺��
    WHERE ���ǽ�
    ORDER BY ���ı����̵Ǵ��÷�/��Ī/�÷����� [ASC/DESC] [NULLS FIRST/LAST]
    
    * ASC : �������� ���� (default)
    * DESC : �������� ����
    
    * NULLS FIRST : ���� �÷��� ���� null�� ��� �ֿ켱 ��ġ (DESC�� ��� �⺻��)
    * NULLS LAST : ���� �÷��� ���� null�� ��� ���ļ� ��ġ (ASC�� ��� �⺻��)
    -> null ���� ū ������ �з��Ͽ� ����
*/
-- ��� ����� �����, ���� ��ȸ (������ �������� ����)
SELECT EMP_NAME AS "�����", SALARY * 12 AS "����" FROM EMPLOYEE ORDER BY SALARY * 12 DESC;
SELECT EMP_NAME AS "�����", SALARY * 12 AS "����" FROM EMPLOYEE ORDER BY "����" DESC;
SELECT EMP_NAME AS "�����", SALARY * 12 AS "����" FROM EMPLOYEE ORDER BY 2 DESC;
-- > �÷� ���� ��� �� '����Ŭ'������ ������ 1���� �����Ѵ�.

-- ���ʽ� ���� ����
SELECT * FROM EMPLOYEE ORDER BY BONUS; -- �⺻�� : ASC, NULLS LAST;
SELECT * FROM EMPLOYEE ORDER BY BONUS ASC;
SELECT * FROM EMPLOYEE ORDER BY BONUS ASC NULLS LAST;
SELECT * FROM EMPLOYEE ORDER BY BONUS DESC;
SELECT * FROM EMPLOYEE ORDER BY BONUS DESC NULLS FIRST;
SELECT * FROM EMPLOYEE ORDER BY BONUS DESC, SALARY ASC;
SELECT * FROM EMPLOYEE ORDER BY SALARY ASC, BONUS DESC, EMP_NO ASC;
-- ���� ������ 2�� �̻� �ۼ��� �� ���� ���� ��� �ι�° ���� ���� ������� ����






























