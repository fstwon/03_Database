-- "���ö" ����� ���� �μ��� ���� ��� ���� ��ȸ 

-- 1) "���ö" ��� �μ� �ڵ� ��ȸ
SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '���ö';

-- 2) �μ� �ڵ尡 'D9' ��� ���� ��ȸ
SELECT * FROM EMPLOYEE WHERE DEPT_CODE = 'D9';

-- 3) 1, 2 ������ ��ġ��
SELECT * FROM EMPLOYEE 
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '���ö');

-- ��ü ����� ��� �޿����� �� ���� �޿��� �޴� ����� ���� ��ȸ
-- 1) ��� �޿� ��ȸ 
SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE;

-- 2) ��� �޿����� �� ���� �޿��� �޴� ��� ���� ��ȸ 
SELECT * FROM EMPLOYEE WHERE SALARY > 3047663;

-- 3) SUBQUERY ����
SELECT * FROM EMPLOYEE WHERE SALARY > (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE);
--------------------------------------------------------------------------------
-- * ������ SUBQUERY
-- �� ����� ��� �޿����� �� ���� �޿��� �޴� ����� �����, ���� �ڵ�, �޿� ��ȸ 
SELECT EMP_NAME �����, JOB_CODE �����ڵ�, SALARY �޿� FROM EMPLOYEE
WHERE SALARY < (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE);

-- ���� �޿��� ���� ����� �����, �����ڵ�, �޿� ��ȸ 
SELECT EMP_NAME �����, JOB_CODE �����ڵ�, SALARY �޿� FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

-- "���ö" ����� �޿� ���� ���� �޴� ����� �����, �μ��ڵ�, �޿� ��ȸ 
SELECT EMP_NAME �����, DEPT_CODE �μ��ڵ�, SALARY �޿� FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '���ö');

-- �μ� �ڵ带 �μ������� ��ȸ
-- * ����Ŭ ����
SELECT EMP_NAME �����, DEPT_TITLE �μ��ڵ�, SALARY �޿� FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '���ö');

-- * ANSI ����
SELECT EMP_NAME �����, DEPT_TITLE �μ��ڵ�, SALARY �޿� 
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '���ö');

-- �μ� �� �޿� ���� ���� ū �μ��� �μ� �ڵ�, �޿� �� ��ȸ
SELECT DEPT_CODE �μ��ڵ�, SUM(SALARY) 
FROM EMPLOYEE
GROUP BY DEPT_CODE 
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY)) FROM EMPLOYEE GROUP BY DEPT_CODE);

-- "������" ����� ���� �μ� ����� ���, �����, ����ó, �Ի���, �μ��� ��ȸ 
-- ��, "������" ����� ����
-- * ����Ŭ ����
SELECT EMP_ID ���, EMP_NAME �����, PHONE ����ó, HIRE_DATE �Ի���, DEPT_TITLE �μ���
FROM EMPLOYEE, DEPARTMENT 
WHERE 
    DEPT_CODE = DEPT_ID 
    AND DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '������')
    AND EMP_NAME <> '������';
    
-- * ANSI ����
SELECT EMP_ID ���, EMP_NAME �����, PHONE ����ó, HIRE_DATE �Ի���, DEPT_TITLE �μ���
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE 
    DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '������')
    AND EMP_NAME <> '������';
--------------------------------------------------------------------------------
-- * ������ SUBQUERY
-- "�����" ��� �Ǵ� "������" ����� ���� ������ ����� ���� ��ȸ 
-- (���/�����/�����ڵ�/�޿�)

-- 1)
SELECT JOB_CODE �����ڵ� FROM EMPLOYEE
WHERE EMP_NAME IN ('�����', '������');
-- WHERE EMP_NAME = '�����' OR EMP_NAME = '������';
-- 2)
SELECT EMP_ID ���, EMP_NAME �����, JOB_CODE �����ڵ�, SALARY �޿� FROM EMPLOYEE
WHERE JOB_CODE IN ('J3', 'J7');

-- 3) 1, 2 SUBQUERY ���� 
SELECT EMP_ID ���, EMP_NAME �����, JOB_CODE �����ڵ�, SALARY �޿� FROM EMPLOYEE
WHERE JOB_CODE IN (
    SELECT JOB_CODE �����ڵ� FROM EMPLOYEE
        WHERE EMP_NAME IN ('�����', '������')
);

-- �븮 ���� ��� �� ���� ������ �ּ� �޿����� ���� �޴� ��� ���� ��ȸ 
-- (���, �̸�, ���޸�, �޿�)
-- 1) ���� ������ �޿� ��ȸ 
SELECT SALARY FROM EMPLOYEE JOIN JOB USING (JOB_CODE) WHERE JOB_NAME = '����';

-- 2) > ANY ������ ����Ͽ� �� 
SELECT EMP_ID ���, EMP_NAME �̸�, JOB_NAME ���޸�, SALARY �޿� 
FROM EMPLOYEE JOIN JOB USING (JOB_CODE)
WHERE SALARY > ANY (
        SELECT SALARY FROM EMPLOYEE JOIN JOB USING (JOB_CODE) 
        WHERE JOB_NAME = '����'
    )
    AND JOB_NAME = '�븮';
--------------------------------------------------------------------------------
-- * ���߿� SUBQUERY

-- "������" ����� ���� �μ�, ���� ������ ��� ���� ��ȸ 
-- 1) "������" ����� �μ� �ڵ�, ���� �ڵ� ��ȸ 
SELECT DEPT_CODE �μ��ڵ�, JOB_CODE �����ڵ� FROM EMPLOYEE
WHERE EMP_NAME = '������';

-- ������ SUBQUERY ���
SELECT EMP_NAME �̸�, DEPT_CODE �μ��ڵ�, JOB_CODE �����ڵ�, SALARY �޿�
FROM EMPLOYEE 
WHERE 
    DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '������')
    AND JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '������');

-- 2) �μ��ڵ尡 'D5', �����ڵ尡 'J5' �� ��� ���� ��ȸ 
SELECT EMP_NAME �̸�, DEPT_CODE �μ��ڵ�, JOB_CODE �����ڵ�, SALARY �޿�
FROM EMPLOYEE 
WHERE 
    (DEPT_CODE, JOB_CODE) = 
        (SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '������');

-- "�ڳ���" ����� ������ ����, ����� ������ ����� �����, �����ڵ�, �����ȣ ��ȸ 
-- 1) "�ڳ���" �����ڵ� ��ȸ 
SELECT JOB_CODE, MANAGER_ID FROM EMPLOYEE WHERE EMP_NAME = '�ڳ���';

-- 2) JOB_CODE�� ���� ����� ������ ��� ��ȸ 
SELECT EMP_NAME �����, JOB_CODE �����ڵ�, MANAGER_ID �����ȣ FROM EMPLOYEE
WHERE 
    (JOB_CODE, MANAGER_ID) = 
        (SELECT JOB_CODE, MANAGER_ID FROM EMPLOYEE WHERE EMP_NAME = '�ڳ���')
    AND EMP_NAME <> '�ڳ���';

-- * ������ ���߿� SUBQUERY 
-- �� ���� �� �ּ� �޿��� �޴� ��� ������ ��ȸ (���, �̸�, �����ڵ�, �޿�)
-- 1) ���� �� �ּ� �޿� ��ȸ 
SELECT JOB_CODE, MIN(SALARY) FROM EMPLOYEE GROUP BY JOB_CODE;

-- 2) �� ���� �� �ּ� �޿��� �޴� ��� ���� ��ȸ 
SELECT EMP_ID ���, EMP_NAME �̸�, JOB_CODE �����ڵ�, SALARY �޿� FROM EMPLOYEE
WHERE 
    JOB_CODE = 'J1' AND SALARY = 8000000
    OR JOB_CODE = 'J2' AND SALARY = 3700000
    OR JOB_CODE = 'J3' AND SALARY = 3400000
    OR JOB_CODE = 'J4' AND SALARY = 1550000
    OR JOB_CODE = 'J5' AND SALARY = 2200000
    OR JOB_CODE = 'J6' AND SALARY = 2000000
    OR JOB_CODE = 'J7' AND SALARY = 1380000;

-- SUBQUERY ����
SELECT EMP_ID ���, EMP_NAME �̸�, JOB_CODE �����ڵ�, SALARY �޿� FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY) FROM EMPLOYEE GROUP BY JOB_CODE);
--------------------------------------------------------------------------------
-- ���, �̸�, ���ʽ� ���� ����, �μ��ڵ� ��ȸ 
-- ��, ���ʽ� ���� ���� ����� NULL�� �ƴϰ�
-- ���ʽ� ���� ������ 3000���� �̻��� ��� ��ȸ
SELECT EMP_ID ���, EMP_NAME �̸�, (SALARY + (SALARY * NVL(BONUS, 0))) * 12 "���ʽ� ���� ����"
FROM EMPLOYEE
WHERE (SALARY * NVL(BONUS, 0)) * 12 >= 3000000;

SELECT ���, �̸�, "���ʽ� ���� ����", DEPT_CODE
FROM (
    SELECT EMP_ID, EMP_NAME, (SALARY + (SALARY * NVL(BONUS, 0))) * 12, DEPT_CODE
    FROM EMPLOYEE
    WHERE (SALARY * NVL(BONUS, 0)) * 12 >= 3000000
    ORDER BY 3 DESC
);

-- ���� N���� ��ȸ : "TOP-N�м�"
-- => ROWNUM : ��ȸ�� �࿡ ���Ͽ� ������� 1���� ������ �ο����ִ� ���� �÷�

SELECT ROWNUM, EMP_ID, EMP_NAME, "���ʽ� ���� ����", DEPT_CODE
FROM (
    SELECT EMP_ID, EMP_NAME, (SALARY + (SALARY * NVL(BONUS, 0))) * 12 "���ʽ� ���� ����", DEPT_CODE
    FROM EMPLOYEE
    WHERE (SALARY * NVL(BONUS, 0)) * 12 >= 3000000
    ORDER BY 3 DESC
)
WHERE ROWNUM <= 5;

-- ���� �ֱٿ� �Ի��� ��� 5�� ��ȸ
SELECT ROWNUM, ���, �̸�, �Ի���
FROM (
    SELECT EMP_ID ���, EMP_NAME �̸�, HIRE_DATE �Ի���
    FROM EMPLOYEE
    ORDER BY HIRE_DATE DESC
)
WHERE ROWNUM <= 5;

SELECT ���, �̸�, �Ի���
FROM (
    SELECT EMP_ID ���, EMP_NAME �̸�, HIRE_DATE �Ի���
    FROM EMPLOYEE
    ORDER BY HIRE_DATE DESC
)
WHERE ROWNUM <= 5;

SELECT ���, �̸�, �Ի���
FROM (
    SELECT ROWNUM R, EMP_ID ���, EMP_NAME �̸�, HIRE_DATE �Ի���
    FROM EMPLOYEE
    ORDER BY HIRE_DATE DESC
)
WHERE R BETWEEN 1 AND 5;
--------------------------------------------------------------------------------
/* 
    * ������ �ű�� �Լ�
*/
-- �޿��� ���� ������� ������ �Űܼ� ��ȸ 
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) ���� FROM EMPLOYEE;
-- ���� 19���� 2���� �� �� ������ 21���� ǥ�� 

SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) ���� FROM EMPLOYEE;
-- ���� 19���� 2�� �� �� ������ 20���� ǥ��

-- ���� 5�� ��ȸ
SELECT *
FROM (
    SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) ���� FROM EMPLOYEE
)
WHERE ���� <= 5;

-- ���� 3 ~ 5 ��ȸ 
SELECT *
FROM (
    SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) ���� FROM EMPLOYEE
)
WHERE ���� BETWEEN 3 AND 5;

--------------------------------------------------------------------------------
-- QUIZ
-- 1) ROWNUM�� Ȱ���Ͽ� �޿��� ���� ���� 5���� ��ȸ�Ϸ� ������, ����� ��ȸ���� �ʾҴ�.
SELECT EMP_NAME, SALARY
FROM (
    SELECT EMP_NAME, SALARY
    FROM EMPLOYEE
    ORDER BY SALARY DESC
)
WHERE ROWNUM <= 5;

-- ������(����) 
-- ROWNUM�� ���� �����ϱ� ���� �࿡ �ӽ÷� �ٴ� ��ȣ�̰� ���ĵǱ� ������ �ο��ȴ�. 
-- ���� ORDER BY���� ������ ������� �ο����� �ʴ´�.

-- �ذ� ���
-- SUBQUERY�� INLINE VIEW�� ����Ͽ� �޿� ������ ���� ������ �� ROWNUM���� �����Ѵ�. 

-- 2) �μ� �� ��� �޿��� 270������ �ʰ��ϴ� �μ��� �ش��ϴ� 
-- �μ��ڵ�, �μ� �� �� �޿� ��, ��� �޿�, ��� ���� ��ȸ�Ϸ� ������, ����� ��ȸ���� �ʾҴ�.

-- ����
-- �μ� �� ��� �޿� ��ȸ
SELECT DEPT_CODE, FLOOR(AVG(SALARY)), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- ��� �޿��� 270������ �ʰ��ϴ� �μ� ��ȸ
SELECT DEPT_CODE, FLOOR(AVG(SALARY)) 
FROM EMPLOYEE
GROUP BY DEPT_CODE HAVING FLOOR(AVG(SALARY)) > 2700000;

-- �μ��ڵ�, �μ� �� �� �޿� ��, ��� �޿�, ��� �� ��ȸ 
SELECT DEPT_CODE, SUM(SALARY), FLOOR(AVG(SALARY)), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE HAVING FLOOR(AVG(SALARY)) > 2700000;

-- ���� ����
SELECT DEPT_CODE, SUM(SALARY) ����, FLOOR(AVG(SALARY)) ���, COUNT(*) "��� ��" 
FROM EMPLOYEE
WHERE SALARY > 2700000 -- ���� �߸� ���
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- ������(����) 
-- ���� ������ FROM, WHERE, GROUP BY, SELECT ������ ����Ǳ� ������ 
-- �޿��� 270������ �ʰ��ϴ� ����� ��ȸ�ϰ� �ش� ������� �����͸� ��ȸ�Ѵ�. 
-- WHERE ���� �׷쿡 ���� ������ �ƴ϶� �÷��� ��ȸ�ϱ� ���� �����̴�. 
-- WHERE ���� ���ǽĵ� SALARY�� �ƴ� FLOOR(AVG(SALARY)) > 2700000 ���� �����ؾ� �Ѵ�.

-- �ذ� ��� 
-- ��� �޿��� �켱 ����� �� ���ǹ��� ����Ǿ�� �Ѵ�. 
-- WHERE���� ������ �׷쿡 ���� �������� �����Ͽ��� �Ѵ�. 
SELECT DEPT_CODE �μ��ڵ�, SUM(SALARY) ����, FLOOR(AVG(SALARY)) ���, COUNT(*) "��� ��" 
FROM EMPLOYEE
GROUP BY DEPT_CODE HAVING FLOOR(AVG(SALARY)) > 2700000
ORDER BY DEPT_CODE;

SELECT *
FROM (
    SELECT DEPT_CODE �μ��ڵ�, SUM(SALARY) ����, FLOOR(AVG(SALARY)) ���, COUNT(*) "��� ��" 
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
    ORDER BY DEPT_CODE
)
WHERE ��� > 2700000;

