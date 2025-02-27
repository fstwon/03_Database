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
