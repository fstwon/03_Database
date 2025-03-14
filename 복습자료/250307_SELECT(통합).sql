-- =================== ������ ���� ���� �� �Ʒ� ���� ��ȸ =================== --
-- ���þƿ��� �ٹ����� ����� ���, �����, �μ���, ������, �������� ��ȸ
/*
        211	������	���������	EU	���þ�
        212	������	���������	EU	���þ�
        222	���¸�	���������	EU	���þ�
*/
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE, NATIONAL_NAME
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
    JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '���þ�';

-- �μ� �� ���ʽ����� ���� ���� ����� �μ���, ���޸�, �̸�, ���ʽ� ��ȸ 
/*
        �λ������	�븮	������	0.3
        �ؿܿ���1��	����	�ɺ���	0.15
        �ؿܿ���2��	����	�����	0.2
        ���������	�븮	���¸�	0.35
        �ѹ���	��ǥ	������	0.3
*/
-- ���� ���� ���ʽ� ��ȸ
SELECT DEPT_TITLE, JOB_NAME, EMP_NAME, BONUS
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB USING (JOB_CODE)
WHERE (DEPT_CODE, BONUS) IN
        (
            SELECT DEPT_CODE, MAX(BONUS)
            FROM EMPLOYEE
            GROUP BY DEPT_CODE
        );



-- ���̰� 5�� ���̳��� ������� ���� ��ȸ 
-- ( ���A�� ���, ���A�� �̸�, ���A�� �������, ���B�� ���, ���B�� �̸�, ���B�� ������� )
/*
        209	�ɺ���	750206	221	������	800808
        212	������	780923	211	������	830807
        221	������	800808	214	����	856795
        211	������	830807	215	���ȥ	881130
*/
SELECT 
    A.EMP_ID, A.EMP_NAME, SUBSTR(A.EMP_NO, 1, 6), 
    B.EMP_ID, B.EMP_NAME, SUBSTR(B.EMP_NO, 1, 6)
FROM EMPLOYEE A, EMPLOYEE B
WHERE 
    ABS(TO_NUMBER('19' || SUBSTR(A.EMP_NO, 1, 2)) 
    - TO_NUMBER('19' || SUBSTR(B.EMP_NO, 1, 2))) = 5
    AND TO_NUMBER('19' || SUBSTR(A.EMP_NO, 1, 2)) < TO_NUMBER('19' || SUBSTR(B.EMP_NO, 1, 2));
