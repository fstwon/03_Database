-- [Basic SELECT]

-- 1. ���б� �а� �̸�, �迭 ǥ��. ��, ��� ����� "�а� ��", "�迭"���� ǥ��
SELECT DEPARTMENT_NAME "�а� ��", CATEGORY "�迭" FROM TB_DEPARTMENT;

-- 2. �а� ���� ���, CAPACITY
SELECT DEPARTMENT_NAME || '�� ������ ' || CAPACITY || '��' || ' �Դϴ�.' "�а��� ����" FROM TB_DEPARTMENT;

-- 3. "������а�" ���л� �� ���л� ��ȸ. �а� ���̺� '�а� �ڵ�' ��ȸ 
-- DEPARTMENT_NO = 001
-- ABSENCE_YN 
SELECT STUDENT_NAME FROM TB_STUDENT WHERE ABSENCE_YN = 'Y' AND DEPARTMENT_NO = '001';

-- 4. ���� ���� ��� ��ü�� �̸� �Խ�. �й� ��ȸ
-- A513079, A513090, A513091, A513110, A513119
SELECT STUDENT_NAME FROM TB_STUDENT WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119');

-- 5. ���� ������ 20 ~ 30�� �а� �а� �̸��� �迭 ���
SELECT DEPARTMENT_NAME, CATEGORY FROM TB_DEPARTMENT WHERE CAPACITY BETWEEN 20 AND 30;

-- 6. ���� �̸� ���. ������ �Ҽ� �а��� ����. 
SELECT PROFESSOR_NAME FROM TB_PROFESSOR WHERE DEPARTMENT_NO IS NULL;

-- 7. �а��� �����Ǿ� ���� ���� �л� ��ȸ 
SELECT STUDENT_NAME FROM TB_STUDENT WHERE DEPARTMENT_NO IS NULL;

-- 8. ���� ���� ���� ������ ���� ��ȣ ��ȸ. ���� ���� ���� Ȯ��
SELECT CLASS_NO FROM TB_CLASS WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 9. ���� �迭 ��ȸ
SELECT DISTINCT CATEGORY FROM TB_DEPARTMENT;

-- 10. 02 �й� ���� ������ �� ���л� ���� �л� �й�, �̸�, �ֹι�ȣ ��� 
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT 
WHERE 
ABSENCE_YN = 'N' 
AND INSTR(STUDENT_ADDRESS, '���ֽ�') > 0
AND TO_CHAR(ENTRANCE_DATE, 'YY') = '02';



