-- [Additional SELECT - �Լ�]

-- 1. 002 �а� �ڵ� �л��� �й�, �̸�, ���� �⵵�� ���� ���� ������������ ��ȸ
SELECT STUDENT_NO �й�, STUDENT_NAME �̸�, TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') ���г⵵
FROM TB_STUDENT WHERE DEPARTMENT_NO = '002' ORDER BY ENTRANCE_DATE ASC;

-- 2. �̸��� �� ���ڰ� �ƴ� ������ �̸��� �ֹι�ȣ ��ȸ
SELECT PROFESSOR_NAME, PROFESSOR_SSN 
FROM TB_PROFESSOR WHERE LENGTH(PROFESSOR_NAME) != 3;

-- 3. ���� ���� �̸�, ���� ���. ���� �������� ����
-- 2000�� ���� ����� ���� "�����̸�", "����"�� ���
-- ���̴� '��' ���̷� ���
    
SELECT 
    PROFESSOR_NAME �����̸�, 
    PROFESSOR_SSN SSN,
    EXTRACT(YEAR FROM SYSDATE) - (EXTRACT(YEAR FROM TO_DATE(SUBSTR(PROFESSOR_SSN, 1, 6), 'YYMMDD')) - 100) ����
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = 1
ORDER BY PROFESSOR_SSN DESC;

-- 4. ���� ������ ���� �̸� ��� "�̸�"
SELECT SUBSTR(PROFESSOR_NAME, 2) �̸� FROM TB_PROFESSOR;

-- 5. 19�� �� �� ������(�����) ��ȸ
-- ���п��� ��� ���� ��� = ���п��� - ����
SELECT 
    STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN, 1, 6), 'RRMMDD')) > 19;

-- 6. 2020�� ũ���������� ���� ��ȸ
SELECT TO_CHAR(TO_DATE('201225', 'YYMMDD'), 'DAY') FROM DUAL;

-- 7. ��, ��, �� �ǹ� 
/*
    TO_DATE('99/10/11', 'YY/MM/DD') - 2099�� 10�� 11��
    TO_DATE('49/10/11', 'YY/MM/DD') - 2049�� 10�� 11��
    TO_DATE('99/10/11', 'RR/MM/DD') - 1999�� 10�� 11��
    TO_DATE('49/10/11', 'RR/MM/DD') - 2049�� 10�� 11��
*/

-- 8. 2000�⵵ �� �� �������� �й��� 'A'�� ����
-- 2000�⵵ ���� �й� �л��� �й�, �̸� 
SELECT STUDENT_NO, STUDENT_NAME 
FROM TB_STUDENT
WHERE STUDENT_NO NOT LIKE 'A%';

-- 9. A517178 �ѾƸ� �л��� �� ����
-- "����", �ݿø��Ͽ� �Ҽ� ���ڸ������� ǥ��
-- TB_GRADE STUDENT_NO
SELECT ROUND(AVG(POINT), 1) ���� FROM TB_GRADE WHERE STUDENT_NO = 'A517178';

-- 10. �а��� �л� �� ��ȸ, �а���ȣ, �л���(��)�� ���
SELECT DEPARTMENT_NO �а���ȣ, COUNT(*) 
FROM TB_STUDENT GROUP BY DEPARTMENT_NO ORDER BY 1;

-- 11. ���� ������ ���� ���� ���� �л��� �� ��ȸ 
-- COACH_PROFESSOR_NO
SELECT COUNT(*) FROM TB_STUDENT WHERE COACH_PROFESSOR_NO IS NULL;

-- 12. A112113 ���� �⵵ �� ���� ��ȸ 
-- "�⵵", "�⵵ �� ����"
-- ������ �ݿø� �Ҽ��� ���� ���ڸ����� ǥ�� 
SELECT SUBSTR(TERM_NO, 1, 4) �⵵, ROUND(AVG(POINT), 1) "�⵵ �� ����" 
FROM TB_GRADE WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO, 1, 4);

-- 13. �а� �� ���л� ��
SELECT DEPARTMENT_NO �а��ڵ��, COUNT(DECODE(ABSENCE_YN, 'Y', 1, 'N', NULL)) "���л� ��" 
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO ORDER BY DEPARTMENT_NO;

-- 14. �������� �̸� ��ȸ 
SELECT STUDENT_NAME �����̸�, COUNT(*) 
FROM TB_STUDENT 
GROUP BY STUDENT_NAME HAVING COUNT(*) > 1 ORDER BY STUDENT_NAME;

-- 15. A112113 ���� �л��� �⵵, �б� �� ����, �⵵ �� ���� ����, �� ���� ��ȸ
-- ������ �Ҽ��� ���ڸ����� �ݿø�
SELECT 
    NVL(SUBSTR(TERM_NO, 1, 4), ' ') �⵵,
    NVL(SUBSTR(TERM_NO, 5, 2), ' ') �б�,
    ROUND(AVG(POINT), 1) ���� 
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2))
ORDER BY SUBSTR(TERM_NO, 1, 4);














