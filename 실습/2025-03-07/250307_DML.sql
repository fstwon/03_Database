/*
    1. TB_CLASS_TYPE ���̺� ������ �Է�
*/
INSERT INTO TB_CLASS_TYPE VALUES ('01', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES ('02', '��������'); 
INSERT INTO TB_CLASS_TYPE VALUES ('03', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES ('04', '���缱��');
INSERT INTO TB_CLASS_TYPE VALUES ('05', '������');

/*
    2. �л��Ϲ����� ���̺� ����
*/
CREATE TABLE TB_�л��Ϲ����� 
    AS (SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS FROM TB_STUDENT);
    
/*
    3. ������а� ������ ���Ե� �а��������̺� ����
*/
CREATE TABLE TB_������а� 
    AS (
        SELECT 
            STUDENT_NO, STUDENT_NAME, 
            SUBSTR(STUDENT_SSN, 1, 4), PROFESSOR_NAME 
        FROM TB_STUDENT 
            JOIN TB_PROFESSOR ON COACH_PROFESSOR_NO = PROFESSOR_NO
            JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
        WHERE DEPARTMENT_NAME = '������а�'
    )