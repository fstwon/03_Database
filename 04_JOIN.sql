/*
    * JOIN
    : �� �� �̻��� ���̺��� ������ ��ȸ�� �ʿ��� ��� ����ϴ� ����
    ��ȸ ����� �ϳ��� Result set���� Ȯ�� ����
    
    => ������ �����ͺ��̽������� �ߺ� ������ �ּ�ȭ�ϱ� ���� �ִ��� ����� �����ϰ� 
    �ּ����� �����͸� �� ���̺� �����Ѵ�. 
    
    => ������ �����ͺ��̽����� �������� ����Ͽ� ���̺� �� "����"�� �����ϴ� ���
    �� ���̺� �� �����(�ܷ�Ű)�� ���� �����͸� ��Ī�Ͽ� ��ȸ�Ѵ�.
    
    JOIN�� ũ�� "����Ŭ ���� ����"�� "ANSI ����"
    
    - ����Ŭ ���� ����
    � ���� (EQUAL JOIN)
    ���� ���� (LEFT JOIN/RIGHT JOIN)
    ��ü ���� (SELF JOIN)
    �� ���� (NON EQUAL JOIN)
    
    - ANSI ����
    ���� ���� (INNER JOIN) -> JOIN ON/USING
    ���� �ܺ� ���� (LEFT OUTER JOIN)
    ������ �ܺ� ���� (RIGHT OUTER JOIN)
    ��ü �ܺ� ���� (FULL OUTER JOIN)
    JOIN ON
*/
-- ��ü ����� ���, �����, �μ� �ڵ� ��ȸ
SELECT EMP_ID ���, EMP_NAME "��� ��", DEPT_CODE "�μ� �ڵ�" FROM EMPLOYEE;
-- �μ� �������� �μ� �ڵ�, �μ� �� ��ȸ
SELECT DEPT_ID "�μ� �ڵ�", DEPT_TITLE "�μ� ��" FROM DEPARTMENT;
-- ��ü ����� ���, �����, ���� �ڵ� ��ȸ
SELECT EMP_ID ���, EMP_NAME "��� ��", JOB_CODE "���� �ڵ�" FROM EMPLOYEE;
-- ���� �������� ���� �ڵ�, ���� �� ��ȸ
SELECT JOB_CODE "���� �ڵ�", JOB_NAME "���� ��" FROM JOB;
--------------------------------------------------------------------------------
/*
    * � ���� (EQUAL JOIN) /  ���� ���� (INNER JOIN)
    �����ϴ� �÷��� ���� ��ġ�ϴ� �ุ ��ȸ(����ġ ���� ������� ����)
*/
-- * ����Ŭ ���� ���� 
/*
    - FROM ���� ��ȸ�ϰ��� �ϴ� ���̺� ����(','�� ����)
    - WHERE ���� ��Ī �÷��� ���� ���� �ۼ�
*/
-- ����� ���, �̸�, �μ� �� ��ȸ
-- => �μ� �ڵ� �÷����� ���� (DEPT_CODE, DEPT_ID)
SELECT EMP_ID ���, EMP_NAME �̸�, DEPT_TITLE "�μ� ��"
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
-- DEPT_CODE ���� NULL�� ��� 
-- �� ���̺��� �����ϴ� �����ʹ� ����

-- ����� ���, �̸�, ���� �� ��ȸ
SELECT EMP_ID ���, EMP_NAME �̸�, JOB_TITLE "���� ��"
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;
-- FROM EMPLOYEE, JOB
-- WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- * ANSI ���� (ǥ��)
/*
    - FROM ���� ������ �Ǵ� ���̺� �ϳ� �ۼ�
    - JOIN ���� ������ �ʿ��� ���̺� ��� + �ʿ��� ��Ī ���� �ۼ�
    
    * JOIN ON : �÷����� ���ų� �ٸ� ��� 
    FROM ���̺�1 JOIN ���̺�2 ON ����
    
    * JOIN USING : �÷����� ���� ���
    FROM ���̺�1 JOIN ���̺�2 USING (����)
*/
-- ���, ��� ��, �μ� �� ��ȸ
SELECT EMP_ID ���, EMP_NAME "��� ��", DEPT_TITLE "�μ� ��" 
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- ���, ��� ��, ���� �� ��ȸ
SELECT EMP_ID ���, EMP_NAME "��� ��", JOB_NAME "���� ��"
FROM EMPLOYEE E JOIN JOB J USING (JOB_CODE);

SELECT EMP_ID ���, EMP_NAME "��� ��", JOB_NAME "���� ��"
FROM EMPLOYEE E JOIN JOB J ON E.JOB_CODE = J.JOB_CODE;

-- �븮 ���� ����� ���, ��� ��, ���� ��, �޿� ��ȸ 
-- * ����Ŭ ����
SELECT EMP_ID ���, EMP_NAME "��� ��", JOB_NAME "���� ��", SALARY �޿�
FROM EMPLOYEE E, JOB J 
WHERE E.JOB_CODE = J.JOB_CODE AND JOB_NAME = '�븮'; -- JOB_CODE = 'J6';

-- * ANSI ����
SELECT EMP_ID ���, EMP_NAME "��� ��", JOB_NAME "���� ��", SALARY �޿�
FROM EMPLOYEE E JOIN JOB J USING (JOB_CODE) WHERE JOB_NAME = '�븮';
-- ON E.JOB_CODE = J.JOB.CODE;

-- [1] �μ��� �λ�������� ����� ���, ��� ��, ���ʽ� ��ȸ 
-- * ����Ŭ ����
SELECT EMP_ID ���, EMP_NAME "��� ��", NVL(BONUS, 0) ���ʽ� 
FROM EMPLOYEE E, DEPARTMENT D WHERE DEPT_CODE = DEPT_ID AND DEPT_TITLE = '�λ������';

-- * ANSI ����
SELECT EMP_ID ���, EMP_NAME "��� ��", NVL(BONUS, 0) ���ʽ� 
FROM EMPLOYEE E JOIN DEPARTMENT D ON DEPT_CODE = DEPT_ID WHERE DEPT_TITLE = '�λ������';

-- [2] �μ��� ���� ������ �����Ͽ�, ��ü �μ��� �μ� �ڵ�, �μ���, �����ڵ�, ������ ��ȸ
-- * ����Ŭ ����
SELECT DEPT_ID "�μ� �ڵ�", DEPT_TITLE "�μ� ��", LOCATION_ID "���� �ڵ�", LOCAL_NAME "����"
FROM DEPARTMENT D, LOCATION L WHERE LOCATION_ID = LOCAL_CODE;

-- * ANSI ����
SELECT DEPT_ID "�μ� �ڵ�", DEPT_TITLE "�μ� ��", LOCATION_ID "���� �ڵ�", LOCAL_NAME "����"
FROM DEPARTMENT D JOIN LOCATION L ON LOCATION_ID = LOCAL_CODE;

-- [3] ���ʽ��� �޴� ����� ���, ��� ��, ���ʽ�, �μ� �� ��ȸ 
-- * ����Ŭ ����
SELECT EMP_ID ���, EMP_NAME "��� ��", BONUS ���ʽ�, DEPT_TITLE "�μ� ��" 
FROM EMPLOYEE E, DEPARTMENT D WHERE DEPT_CODE = DEPT_ID AND BONUS IS NOT NULL;

-- * ANSI ����
SELECT EMP_ID ���, EMP_NAME "��� ��", BONUS ���ʽ�, DEPT_TITLE "�μ� ��" 
FROM EMPLOYEE E JOIN DEPARTMENT D ON DEPT_CODE = DEPT_ID WHERE BONUS IS NOT NULL;

-- [4] �μ��� �ѹ��ΰ� �ƴ� ����� �����, �޿� ��ȸ
-- * ����Ŭ ����
SELECT EMP_NAME "��� ��", SALARY �޿� 
FROM EMPLOYEE E, DEPARTMENT D WHERE DEPT_CODE = DEPT_ID AND DEPT_TITLE != '�ѹ���';

-- * ANSI ����
SELECT EMP_NAME "��� ��", SALARY �޿� 
FROM EMPLOYEE E JOIN DEPARTMENT D ON DEPT_CODE = DEPT_ID WHERE DEPT_TITLE <> '�ѹ���';
--------------------------------------------------------------------------------
/*
    * ���� ���� / �ܺ� ���� (OUTER JOIN)
    �� ���̺� �� JOIN �� ��ġ���� �ʴ� �൵ �����Ͽ� ��ȸ�ϴ� ���� 
    ��, �ݵ�� LEFT/RIGHT(���� ���̺�) �� ������ �־�� �Ѵ�.
    
    * LEFT JOIN : �� ���̺� �� ���� ���̺��� �������� JOIN
    * RIGHT JOIN : �� ���̺� �� ������ ���̺��� �������� JOIN 
    
    * FULL JOIN : �� ���̺��� ���� ��� ���� ��ȸ�ϴ� JOIN (* ANSI ���� ����)
*/
-- ��� ����� ��� ��, �μ� ��, �޿�, ���� ��ȸ
-- * LEFT JOIN 
-- * ����Ŭ ����
SELECT EMP_NAME "��� ��", DEPT_TITLE "�μ� ��", SALARY * 12 ���� 
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);

-- * ANSI ����
SELECT EMP_NAME "��� ��", DEPT_TITLE "�μ� ��", SALARY * 12 ����
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- * RIGHT JOIN 
-- * ����Ŭ ����
SELECT EMP_NAME "��� ��", DEPT_TITLE "�μ� ��", SALARY * 12 ���� 
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- * ANSI ����
SELECT EMP_NAME "��� ��", DEPT_TITLE "�μ� ��", SALARY * 12 ����
FROM EMPLOYEE RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- * FULL JOIN
SELECT EMP_NAME "��� ��", DEPT_TITLE "�μ� ��", SALARY * 12 ����
FROM EMPLOYEE FULL JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
--------------------------------------------------------------------------------
/*
    * �� ���� (NON EQUAL JOIN)
    ��Ī�� �ʿ��� �÷��� ���� ���� �ۼ� �� '='�� ������� �ʴ� ����. ���� ������ ���� ����
    
    * ANSI ���������� JOIN ON �� ��� ����
*/

-- ����� ��� ��, �޿�, �޿� ��� ��ȸ 
-- * ����Ŭ ����
SELECT EMP_NAME "��� ��", SALARY �޿�, SAL_LEVEL "�޿� ���"
FROM EMPLOYEE, SAL_GRADE
-- WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- * ANSI ����
SELECT EMP_NAME "��� ��", SALARY �޿�, SAL_LEVEL "�޿� ���"
FROM EMPLOYEE JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND MAX_SAL;
--------------------------------------------------------------------------------
/*
    * ��ü ���� (SELF JOIN)
    ���� ���̺��� �����ϴ� ����
*/
-- ��ü ����� ���, ��� ��, �μ� �ڵ� 
-- ��� ���, ��� ��� ��, ��� �μ� �ڵ� ��ȸ
-- * ����Ŭ ����
SELECT 
    E.EMP_ID ���, E.EMP_NAME "��� ��", E.DEPT_CODE "�μ� �ڵ�",
    M.EMP_ID "��� ���", M.EMP_NAME "��� ��� ��", M.DEPT_CODE "��� �μ� �ڵ�"
FROM EMPLOYEE E, EMPLOYEE M WHERE E.MANAGER_ID = M.EMP_ID;

-- * ANSI ���� 
SELECT 
    E.EMP_ID ���, E.EMP_NAME "��� ��", E.DEPT_CODE "�μ� �ڵ�",
    M.EMP_ID "��� ���", M.EMP_NAME "��� ��� ��", M.DEPT_CODE "��� �μ� �ڵ�"
FROM EMPLOYEE E 
JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID;
-- LEFT JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID; 
--------------------------------------------------------------------------------
/*
    * ���� ���� 
    2�� �̻��� ���̺� ����
*/
-- ���, ��� ��, �μ� ��, ���� �� ��ȸ
-- * ����Ŭ ����
SELECT EMP_ID ���, EMP_NAME "��� ��", DEPT_TITLE "�μ� ��", JOB_NAME "���� ��"
FROM EMPLOYEE E, DEPARTMENT D, JOB J WHERE DEPT_CODE = DEPT_ID AND E.JOB_CODE = J.JOB_CODE;

-- * ANSI ����
SELECT EMP_ID ���, EMP_NAME "��� ��", DEPT_TITLE "�μ� ��", JOB_NAME "���� ��"
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID JOIN JOB USING (JOB_CODE);

-- ���, ��� ��, �μ� ��, ���� �� ��ȸ 
-- * ����Ŭ ����
SELECT EMP_ID ���, EMP_NAME "��� ��", DEPT_TITLE "�μ� ��", LOCAL_NAME "���� ��"
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE;

-- * ANSI ����
SELECT EMP_ID ���, EMP_NAME "��� ��", DEPT_TITLE "�μ� ��", LOCAL_NAME "���� ��"
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;
--------------------------------------------------------------------------------
--==============================================================================

-- QUIZ

-- [1] ���, ��� ��, �μ� ��, ���� ��, ���� �� ��ȸ
-- * ����Ŭ ����
SELECT EMP_ID ���, EMP_NAME "��� ��", DEPT_TITLE "�μ� ��", LOCAL_NAME "���� ��", NATIONAL_NAME "���� ��"
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N 
WHERE 
DEPT_CODE = DEPT_ID AND
LOCATION_ID = LOCAL_CODE AND
L.NATIONAL_CODE = N.NATIONAL_CODE;

-- * ANSI ����
SELECT EMP_ID ���, EMP_NAME "��� ��", DEPT_TITLE "�μ� ��", LOCAL_NAME "���� ��", NATIONAL_NAME "���� ��"
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
JOIN NATIONAL USING (NATIONAL_CODE);

-- [2] ���, ��� ��, �μ� ��, ���� ��, ���� ��, ���� ��, �޿� ��� ��ȸ 
-- * ����Ŭ ����
SELECT EMP_ID ���, EMP_NAME "��� ��", DEPT_TITLE "�μ� ��", JOB_NAME "���� ��", LOCAL_NAME "���� ��", NATIONAL_NAME "���� ��", SAL_LEVEL "�޿� ���"
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L, NATIONAL N, SAL_GRADE S
WHERE 
DEPT_CODE = DEPT_ID AND 
E.JOB_CODE = J.JOB_CODE AND
LOCATION_ID = LOCAL_CODE AND
L.NATIONAL_CODE = N.NATIONAL_CODE AND
SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- * ANSI ����
SELECT EMP_ID ���, EMP_NAME "��� ��", DEPT_TITLE "�μ� ��", JOB_NAME "���� ��", LOCAL_NAME "���� ��", NATIONAL_NAME "���� ��", SAL_LEVEL "�޿� ���"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID 
JOIN JOB USING (JOB_CODE)
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
JOIN NATIONAL USING (NATIONAL_CODE)
JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND MAX_SAL;




