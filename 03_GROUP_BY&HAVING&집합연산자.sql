 /*
    * GROUP BY ��
    : �׷� ������ ������ �� �ִ� ����
    �ټ��� �����͸� �ϳ��� �׷����� ���� ó���ϴ� �������� ���
 */
 -- ��ü ����� �� �޿� ��ȸ
 SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') "�� �޿�" FROM EMPLOYEE;
 
 -- �μ� �� �� �޿�
 SELECT DEPT_CODE, TO_CHAR(SUM(SALARY), 'L999,999,999') "�μ� �� �� �޿�" FROM EMPLOYEE GROUP BY DEPT_CODE;
 
 -- �μ� �� ��� ��
 SELECT DEPT_CODE, COUNT(*) FROM EMPLOYEE GROUP BY DEPT_CODE;
 
 -- �μ� �ڵ尡 D1, D6, D9�� �� �μ� �� �޿� ����, ��� �� ��ȸ
 SELECT DEPT_CODE �μ�, COUNT(*) "��� ��", SUM(SALARY) "�޿� ����" FROM EMPLOYEE WHERE DEPT_CODE IN ('D1', 'D6', 'D9') GROUP BY DEPT_CODE ORDER BY DEPT_CODE ASC;
 
 -- �� ���� �� �� ��� ��, ���ʽ��� �޴� ��� ��, �޿� ��, ��� �޿�, ���� �޿�, �ְ� �޿� ��ȸ
 -- (��, ���� �ڵ� ������������ ����)
 SELECT 
    JOB_CODE ����, 
    COUNT(*) "���� �� ��� ��", 
    COUNT(BONUS) "���ʽ��� �޴� ��� ��", 
    SUM(SALARY) "�޿� ��", 
    MIN(SALARY) "���� �޿�", 
    MAX(SALARY) "�ְ� �޿�"
FROM EMPLOYEE
GROUP BY JOB_CODE ORDER BY JOB_CODE;

-- ���� ��� ��, ���� ��� �� ��ȸ
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') ����, COUNT(*) "��� ��" FROM EMPLOYEE GROUP BY SUBSTR(EMP_NO, 8, 1);

-- �μ� �� ���� �� ��� ��, �޿� �� �� ��ȸ 
SELECT DEPT_CODE �μ��ڵ�, JOB_CODE �����ڵ�, COUNT(*) "��� ��", SUM(SALARY) "�޿� �� ��" FROM EMPLOYEE GROUP BY DEPT_CODE, JOB_CODE ORDER BY DEPT_CODE;

--------------------------------------------------------------------------------

/*
    * HAVING ��
    : �׷쿡 ���� ������ ������ �� ����ϴ� ����
    �׷� �Լ����� ����Ͽ� ���� �ۼ�
*/
-- �μ� �� ��� �޿� ��ȸ
SELECT DEPT_CODE �μ��ڵ�, ROUND(AVG(SALARY)) "��� �޿�" FROM EMPLOYEE GROUP BY DEPT_CODE;

-- �� �μ� �� ��� �޿��� 300���� �̻��� �μ��� ��ȸ
SELECT DEPT_CODE �μ��ڵ�, ROUND(AVG(SALARY)) "��� �޿�" 
FROM EMPLOYEE 
GROUP BY DEPT_CODE HAVING ROUND(AVG(SALARY)) >= 3000000;

-- �μ� �� ���ʽ��� �޴� ����� ���� �μ��� �μ� �ڵ� ��ȸ 
SELECT DEPT_CODE �μ��ڵ� FROM EMPLOYEE GROUP BY DEPT_CODE HAVING COUNT(BONUS) = 0;
--------------------------------------------------------------------------------
/*
    * ROLLUP, CUBE : �׷� �� ���� ��� ���� ���踦 ����ϴ� �Լ�
    
    - ROLLUP : ���� ���� �׷� �� ���� ���� ������ �׷� ���� �߰��� ���� ��� ��ȯ
    - CUBE : ���� ���� �׷��� ������ ��� ���� �� ���� ��� ��ȯ
*/
-- �� �μ� �� �μ� �� ���� �� �޿� ��, �μ� �� �޿� ��, ��ü ���� �޿� �� �� ��ȸ 
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
-- GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
-- GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1;
--------------------------------------------------------------------------------
/*
    * ���� ����
    
    SELECT ��ȸ�÷� AS "��Ī" �Ǵ� * �Ǵ� �Լ���, �����
    FROM ��ȸ���̺� �Ǵ� DUAL(�ӽ� ���̺�)
    WHERE ���ǽ�(�����ڸ� Ȱ���Ͽ� �ۼ�)
    GROUP BY �׷�ȭ ���� �÷� �Ǵ� �Լ���
    HAVING ���ǽ� (�׷�ȭ �Լ��� Ȱ���Ͽ� �ۼ�)
    ORDER BY �÷� �Ǵ� ��Ī �Ǵ� �÷� ���� [ASC | DESC] [NULLS LAST | NULLS FIRST]
*/
--------------------------------------------------------------------------------
/*
    * ���� ������ : ���� ���� ��ɹ�(SQL/QUERY)�� �ϳ��� ��ɹ����� ����� ������
    - UNION : ������ (�� ��ɹ��� ������ ��� ���� ���Ѵ�) -> OR �����ڿ� ����
    - INTERSECT : ������ (�� ��ɹ��� ������ ��� ���� �ߺ� �κ� ����) -> AND �����ڿ� ����
    - UNION ALL : ������ + ������ (�ߺ��Ǵ� �κ��� �ι� ��ȸ�� �� �ִ�)
    - MINUS : ������ (���� ������� ���� ����� �� ������)
*/

-- UNION
-- �μ� �ڵ尡 'D5'�� ��� �Ǵ� �޿��� 300������ �ʰ��ϴ� ����� ���, �̸�, �μ� �ڵ�, �޿� ��ȸ
SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_CODE �μ��ڵ�, SALARY �޿� FROM EMPLOYEE WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

-- �μ� �ڵ尡 'D5'�� ����� ���, �̸�, �μ��ڵ�, �޿� ��ȸ 
SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_CODE �μ��ڵ�, SALARY �޿� FROM EMPLOYEE WHERE DEPT_CODE = 'D5';
SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_CODE �μ��ڵ�, SALARY �޿� FROM EMPLOYEE WHERE SALARY > 3000000;

-- UNION �����ڷ� 2���� ������ ��ġ��
SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_CODE �μ��ڵ�, SALARY �޿� FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_CODE �μ��ڵ�, SALARY �޿� FROM EMPLOYEE WHERE SALARY > 3000000;
--------------------------------------------------------------------------------
-- INTERSECT
-- �μ� �ڵ尡 'D5'�̰� �޿��� 300���� �ʰ��� ���, �̸�, �μ��ڵ�, �޿� ��ȸ 
SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_CODE �μ��ڵ�, SALARY �޿� FROM EMPLOYEE WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;

SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_CODE �μ��ڵ�, SALARY �޿� FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_CODE �μ��ڵ�, SALARY �޿� FROM EMPLOYEE WHERE SALARY > 3000000;
--------------------------------------------------------------------------------
-- UNION ALL
SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_CODE �μ��ڵ�, SALARY �޿� FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_CODE �μ��ڵ�, SALARY �޿� FROM EMPLOYEE WHERE SALARY > 3000000;
--------------------------------------------------------------------------------
-- MINUS
SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_CODE �μ��ڵ�, SALARY �޿� FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_CODE �μ��ڵ�, SALARY �޿� FROM EMPLOYEE WHERE SALARY > 3000000;
--------------------------------------------------------------------------------
/*
    * ���� ������ ��� �� ���� ���� 
    1. ��ɹ����� �÷� ������ �����ؾ� �Ѵ�. 
    2. �÷� �ڸ����� ������ ������ Ÿ������ �ۼ��ؾ� �Ѵ�. 
    3. ������ �ʿ��� ��� ORDER BY���� ��ġ�� �������� �ۼ��ؾ� �Ѵ�. 
*/
SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_CODE �μ��ڵ�, SALARY �޿� FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_CODE �μ��ڵ�, SALARY �޿� FROM EMPLOYEE WHERE SALARY > 3000000
ORDER BY EMP_ID;












