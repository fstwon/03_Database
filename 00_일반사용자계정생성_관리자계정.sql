-- ���� �ּ�
/*
    ���� �� �ּ�
*/

-- ���� ��� �����鿡 ���Ͽ� ��ȸ�ϴ� ��ɹ�
SELECT * FROM DBA_USERS;
-- ��ɹ�(SQL) ���� : ctrl + enter �Ǵ� ��� ���� ��ư Ŭ��

-- �Ϲ� ����� ���� ���� ���� -> ������ �������θ� ���� ����
-- [ǥ����] CREATE USER ������ IDENTIFIED BY ��й�ȣ;
-- * 12c �������ʹ� ������ �տ� C## �� �ٿ���� �Ѵ�.

-- (1) ����ڸ� : KH, ��й�ȣ : KH �� ���� �߰� 
CREATE USER C##KH IDENTIFIED BY KH;

-- ���� ���� �� C## �� �����ϰ� ���� ������� �۾��ϰ� ���� ���
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- * �� ��ɹ��� SQL Developer�� ������ ������ ��ɹ��� �����ؾ� �Ѵ�.
-- CREATE USER KHTEST IDENTIFIED BY KHTEST; -- C##�� ������ �ʰ� ���� ����

-- (2) ���� �ο�
-- ������ ����ڿ��� �ּ����� ������ �ο� (����, ��ü ���� ����)
-- [ǥ����] GRANT ����1, ����2, ... TO ������;
GRANT CONNECT, RESOURCE TO C##KH;
-- * CONNECT : ���� ����
-- * RESOURCE : ������ ����. DB������ ��ü(���̺�, ������, ���ν���, Ʈ���� ��)

-- ���̺� �����̽� ���� ����
ALTER USER C##KH DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;


