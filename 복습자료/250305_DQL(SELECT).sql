--====== 250305_DQL(SELECT)_���������(TEST250305).sql ���� �� �Ʒ� ��ȸ ======--
-- ����� ������ �������ּ���. (����ڸ�: C##TEST250305 / ��й�ȣ: test0305)
-- ���� ����
CREATE USER C##TEST250305 IDENTIFIED BY test0305;
-- ���� �ο� 
GRANT CONNECT, RESOURCE TO C##TEST250305;
-- ���̺� �����̽� ���� ����
ALTER USER C##TEST250305 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

-- ��� ����� ���� ��ȸ
SELECT * FROM CUSTOMER;

-- �̸�, �������, ���� ���� ��ȸ
SELECT NAME �̸�, BIRTHDATE �������, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM BIRTHDATE) ���� FROM CUSTOMER;

-- ���̰� 40���� ������� ���� ��ȸ
SELECT * FROM CUSTOMER WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM BIRTHDATE) BETWEEN 40 AND 49;

-- �����ÿ� ���� ���� ������� ���� ��ȸ
SELECT * FROM CUSTOMER WHERE INSTR(ADDRESS, '������') > 0;

-- �̸��� 2���� ������� ���� ��ȸ
SELECT * FROM CUSTOMER WHERE LENGTH(NAME) = 2;
--===========================================================================
-- '250305' ����Ÿ�� �����͸� '2025�� 03�� 05��'�� ǥ��
SELECT TO_CHAR(TO_DATE('250305'), 'YYYY"��" MM"��" DD"��"') FROM DUAL;

-- ������ �¾�� ��ĥ °���� Ȯ��
SELECT ROUND(SYSDATE - TO_DATE('250301', 'YYMMDD')) || '�� °' "�λ�" FROM DUAL;

--===========================================================================
-- ����� ������ �������ּ���. (����ڸ�: C##KH / ��й�ȣ: KH)
--  �ش� ������ ���� ��� �߰� �� kh.sql ��ũ��Ʈ �����Ͽ� �Ʒ� ������ �������ּ���.

-- ������� ���� ����� �޿� �� ��ȸ
SELECT SUM(SALARY) FROM EMPLOYEE 
-- WHERE ENT_YN = 'N';
WHERE ENT_DATE IS NULL;

-- �Ի���� ��� �� ��ȸ (* �Ի�� �������� ����)
SELECT EXTRACT(MONTH FROM HIRE_DATE) || '��' "�Ի� ��", COUNT(*) FROM EMPLOYEE  GROUP BY EXTRACT(MONTH FROM HIRE_DATE) ORDER BY EXTRACT(MONTH FROM HIRE_DATE);


















