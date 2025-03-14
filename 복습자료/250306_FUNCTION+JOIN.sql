/*
    �Ʒ� �������� ���� ������?
    
    SELECT �÷���                            -- 1
    FROM ���̺��                            -- 2
    WHERE ����                               -- 3
    GROUP BY �׷�ȭ����                       -- 4
    HAVING �׷� ����                          -- 5
    ORDER BY ���� ����                        -- 6
    
    2 -> 3 -> 1 -> 4 -> 5 -> 6
*/

--=========================================================================
--     ������ ���� �α��� �� �Ʒ� ������ ��ȸ�� �� �ִ� �������� �ۼ����ּ���
--=========================================================================
-- �̸����� ���̵� �κп�(@ �պκ�) k�� ���Ե� ��� ���� ��ȸ
SELECT * FROM EMPLOYEE WHERE EMAIL LIKE '%k%@%';

-- ����ó ���ڸ��� 010, 011�� �����ϴ� ��� �� ��ȸ
SELECT COUNT(*) FROM EMPLOYEE 
-- WHERE PHONE LIKE '011%' OR PHONE LIKE '010%';
WHERE SUBSTR(PHONE, 1, 3) IN ('010', '011');

-- ������ 7�������� ������� �Ի���� ��� �� ��ȸ (�Ʒ��� ���� ���)
/*
------------------------------------------------------------
    ����     |   �Ի��   |   �Ի� �����|
         7�� |       4�� |          2��|
         7�� |       9�� |          1��|
         ...
         9�� |       6�� |          1��|
------------------------------------------------------------
*/
SELECT 
    SUBSTR(EMP_NO, 3, 2) || '��' ����,
    EXTRACT(MONTH FROM HIRE_DATE) || '��' �Ի��,
    COUNT(*) || '��' "�Ի� �����"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 3, 2) >= 7
GROUP BY SUBSTR(EMP_NO, 3, 2), EXTRACT(MONTH FROM HIRE_DATE)
ORDER BY ����, 2;

-- �����μ� ����� ���, �����, �μ���, ���޸� ��ȸ
-- ** ����Ŭ ���� **
SELECT EMP_ID ���, EMP_NAME �����, DEPT_TITLE �μ���, JOB_NAME ���޸�
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE DEPT_CODE = DEPT_ID AND J.JOB_CODE = E.JOB_CODE AND INSTR(DEPT_TITLE, '����') > 0;

-- ** ANSI ���� **
SELECT EMP_ID ���, EMP_NAME �����, DEPT_TITLE �μ���, JOB_NAME ���޸�
FROM EMPLOYEE E
JOIN DEPARTMENT D ON DEPT_ID = DEPT_CODE
JOIN JOB J USING (JOB_CODE)
WHERE 
    -- INSTR(DEPT_TITLE, '����') > 0;
    DEPT_TITLE LIKE '%����%';

-- ����� ���� ��� ���� ��ȸ (�μ���, ���, ����� ��ȸ)
-- ** ����Ŭ ���� **
SELECT DEPT_TITLE �μ���, EMP_ID ���, EMP_NAME �����
FROM EMPLOYEE E, DEPARTMENT D
WHERE DEPT_CODE = DEPT_ID AND E.MANAGER_ID IS NULL;

-- ** ANSI ���� **
SELECT DEPT_TITLE �μ���, EMP_ID ���, EMP_NAME �����
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE MANAGER_ID IS NULL;

-- �μ��� ����� ���� ��� �� ��ȸ (�μ���, ����� ��ȸ)
-- ** ����Ŭ ���� **
SELECT DEPT_TITLE �μ���, COUNT(*) ����� 
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID AND MANAGER_ID IS NULL
GROUP BY DEPT_TITLE;

-- ** ANSI ���� **
SELECT DEPT_TITLE �μ���, COUNT(*) ����� 
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID WHERE MANAGER_ID IS NULL
GROUP BY DEPT_TITLE;







