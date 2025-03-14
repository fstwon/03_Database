-- KH_��������
-- 1. 2025�� 12�� 25���� ���� ��ȸ
SELECT TO_CHAR(TO_DATE('251225', 'YYMMDD'), 'DAY') FROM DUAL;

-- 2. 70��� ��(1970~1979) �� �����̸鼭 ������ ����� �̸���, �ֹι�ȣ, �μ���, ���� ��ȸ
-- ���� : 70 ~ 79, ����, ����
-- �÷� : �̸���, �ֹι�ȣ, �μ���, ���� ��ȸ
SELECT EMP_NAME �̸�, EMP_NO �ֹι�ȣ, DEPT_TITLE �μ���, JOB_NAME ����
FROM EMPLOYEE E, DEPARTMENT, JOB J 
WHERE 
    DEPT_CODE = DEPT_ID 
    AND E.JOB_CODE = J.JOB_CODE
    AND SUBSTR(EMP_NO, 1, 2) BETWEEN 70 AND 79
    AND SUBSTR(EMP_NO, 8, 1) IN ('2', '4')
    AND EMP_NAME LIKE '��%';
      
-- 3. ���� ������ ��� �ڵ�, ��� ��, ����, �μ� ��, ���� �� ��ȸ
-- ���� : ���� ����, 
-- 1. �ֹι�ȣ ������� ���� �� ��¥ Ÿ������ ���� 
-- SYSDATE ����Ͽ� ���� ��� �� �ּ� �� �� 
-- ��� : ��� �ڵ�, ��� ��, ����, �μ� ��, ���� �� 
SELECT 
    EMP_ID "��� �ڵ�", EMP_NAME "��� ��", 
    SUBSTR(EXTRACT(YEAR FROM SYSDATE) - SUBSTR(EMP_NO, 1, 2), 3, 2) ����,
    DEPT_TITLE "�μ� ��", JOB_NAME "���� ��"
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB USING (JOB_CODE)
WHERE 
    SUBSTR(EXTRACT(YEAR FROM SYSDATE) - SUBSTR(EMP_NO, 1, 2), 3, 2) 
        = (SELECT MIN(SUBSTR(EXTRACT(YEAR FROM SYSDATE) - SUBSTR(EMP_NO, 1, 2), 3, 2)) FROM EMPLOYEE);
        
-- 4. �̸��� �������� ���� ����� ��� �ڵ�, ��� ��, ���� ��ȸ
-- ���� : �̸��� '��'
-- ��� : ��� �ڵ�, ��� ��, ����
SELECT EMP_ID "��� �ڵ�", EMP_NAME "��� ��", DEPT_TITLE "����" 
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID AND EMP_NAME LIKE '%��%'; 
 
-- 5. �μ� �ڵ尡 D5�̰ų� D6�� ����� ��� ��, ����, �μ� �ڵ�, �μ� �� ��ȸ
-- ���� : 'D5' 'D6' �μ� ���
-- ��� : ��� ��, ����, �μ� �ڵ�, �μ���
SELECT EMP_NAME "��� ��", JOB_NAME ����, DEPT_CODE "�μ� �ڵ�", DEPT_TITLE "�μ� ��" 
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB USING (JOB_CODE)
WHERE DEPT_CODE IN ('D5', 'D6');
 
-- 6. ���ʽ��� �޴� ����� ��� ��, ���ʽ�, �μ� ��, ���� �� ��ȸ
-- ���� : ���ʽ��� NULL�� �ƴ� ���
-- ��� : ��� ��, ���ʽ�, �μ� ��, ���� ��
SELECT EMP_NAME "��� ��", BONUS ���ʽ�, DEPT_TITLE "�μ� ��", LOCAL_NAME "���� ��"
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE BONUS IS NOT NULL;

-- 7. ��� ��, ����, �μ� ��, ���� �� ��ȸ
SELECT EMP_NAME "��� ��", JOB_NAME "����", DEPT_TITLE "�μ� ��", LOCAL_NAME "���� ��"
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB USING (JOB_CODE)
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;
 
-- 8. �ѱ��̳� �Ϻ����� �ٹ� ���� ����� ��� ��, �μ� ��, ���� ��, ���� �� ��ȸ 
-- ���� : �ѱ� �Ǵ� �Ϻ� ���� �ٹ�
-- ��� : ��� ��, �μ� ��, ���� ��, ���� ��
-- EMPLOYEE, DEPARTMENT, LOCATION, NATIONAL
SELECT *
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
    JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_CODE IN ('KO', 'JP')
ORDER BY NATIONAL_CODE DESC;

-- 9. �� ����� ���� �μ����� ���ϴ� ����� �̸� ��ȸ
-- ���� : ���� �μ�
-- ��� : ��� �̸�
SELECT EMP_NAME �̸�, DEPT_CODE "�μ� �ڵ�"
FROM EMPLOYEE A, EMPLOYEE B WHERE A.DEPT_CODE = B.DEPT_CODE;
 
-- 10. ���ʽ��� ���� ���� �ڵ尡 J4�̰ų� J7�� ����� �̸�, ����, �޿� ��ȸ (NVL �̿�)
-- ���� : ���ʽ��� NULL�̰� ���� �ڵ� 'J4', 'J7'
-- ��� : �̸� ���� �޿� 
SELECT EMP_NAME �̸�, JOB_NAME ����, NVL(BONUS, SALARY) �޿�
FROM EMPLOYEE JOIN JOB USING (JOB_CODE) WHERE JOB_CODE IN ('J4', 'J7');
 
-- 11. ��� ���� ���� ����� ����� ����� �� ��ȸ
-- ���� : ENT_DATE NULL ����
-- ��� : ������� ���� ���, ����� ��� COUNT 
SELECT COUNT(ENT_DATE), COUNT(DECODE(ENT_DATE, NULL, 1, 'N', NULL)) FROM EMPLOYEE;
 
-- 12. ���ʽ� ������ ������ ���� 5���� ���, �̸�, �μ� ��, ����, �Ի���, ���� ��ȸ
-- ���� : ���ʽ� ���� ���� TOP 5
-- ��� : ���, �̸�, �μ� ��, ����, �Ի���, ���� 
SELECT *
FROM (
    SELECT 
        EMP_ID ���, EMP_NAME �̸�, DEPT_TITLE "�μ� ��", JOB_NAME ����, HIRE_DATE �Ի���,
        RANK() OVER(ORDER BY (SALARY + (SALARY * NVL(BONUS, 0))) * 12 DESC) ����
    FROM EMPLOYEE 
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN JOB USING (JOB_CODE)
)
WHERE ���� <= 5;

-- 13. �μ� �� �޿� �հ谡 ��ü �޿� �� ���� 20%���� ���� �μ��� �μ� ��, �μ� �� �޿� �հ� ��ȸ
-- ���� : �μ� �� �޿� �հ� > �޿� �� �� * 0.2 �� �μ�
-- ��� : �μ� ��, �μ� �� �޿� �� 

--	13-1. JOIN�� HAVING ���
SELECT DEPT_TITLE "�μ� ��", SUM(SALARY) "�μ� �� �޿� ��"
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
GROUP BY DEPT_TITLE HAVING SUM(SALARY) > (SELECT SUM(SALARY) * 0.2 FROM EMPLOYEE);
                      
--	13-2. �ζ��� �� ���
-- BOTTOM-UP ������� �����ؼ� �ٽ� ���
-- HAVING ������ ������ ���������� �ζ��� �並 ����ϴ� ���






--FROM (
--    SELECT DEPT_TITLE, SUM(SALARY) "�μ� �� �޿� ��"
--    FROM DEPARTMENT
--    JOIN EMPLOYEE ON DEPT_CODE = DEPT_ID
--    GROUP BY DEPT_TITLE HAVING SUM(SALARY) > (SELECT SUM(SALARY)  FROM EMPLOYEE) * 0.2
--);

--	13-3. WITH ���


-- 14. �μ� ��� �μ� �� �޿� �հ� ��ȸ
-- ���� : �μ� �� �޿� �հ�
-- ��� : �μ� ��, �޿� �հ�

SELECT DEPT_TITLE "�μ� ��", SUM(SALARY) "�μ� �� �޿� �հ�"
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
GROUP BY DEPT_TITLE;







