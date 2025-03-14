/*
	����Ŭ(DB)���� �پ��� ��ü���� �ִ�.
	������ � ��ü�� ���� �����ΰ�? �ش� ��ü�� ������ �ۼ��غ���.
	
	* VIEW : ���̺�� �ٸ��� ���������� �����͸� �������� ������,
						   ���� ���̺��� Ư�� �÷��̳� ������ �����Ͽ� �����͸� �� �� �ִ�.
    [������]
    CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW ��� AS (SUBQUERY) [WITH CHECK OPTION] [WITH READ ONLY];
						   
	* SEQUENCE : �ڵ� ���� ���� �����ϴ� ��ü. �ַ� �⺻ Ű ���� �� ���.
	[������] 
    CREATE SEQUENCE �������� 
    [START WITH ���۰�] [INCREMENT BY ������] [MAXVALUE �ִ밪] [MINVALUE �ּҰ�] [CYCLE | NOCYCLE] [CACHE | NOCACHE]
    
    ���� ������ �� Ȯ��(NEXTVAL�� ���������� ������ ��) : ��������.CURRVAL
    ���� ������ �� + ������ : ��������.NEXTVAL
    
	* TRIGGER : Ư�� �̺�Ʈ �߻� �� �ڵ����� ����ǵ��� ������ ��ü.
    [������]
    CREATE TRIGGER Ʈ���Ÿ� BEFORE|AFTER INSERT | UPDATE | DELETE ON ���̺�� 
    [FOR EACH ROW] [DECLARE] BEGIN [EXCEPTION] END;/
	
	* USER : ���̺�, ��, ������ ���� ��ü�� ������ �� �ִ� ��ü. Ư�� ������ �ο� �޾� �ٸ� ��ü�� ������ �� ����.
    [������]
    CREATE USER [C##]������ IDENTIFIED BY �н�����
    
    GRANT ���� TO [C##]������
    �ּ� ���� : CONNECT, RESOURCE;
*/
-- * ---------------------------------------------------------------------- * --
/*
    * ����� ����� �Է¹޾� �ش� ����� ���, �̸��� ���
      - ��� : XXX
      - �̸� : XXX
      
      ��, ��ȸ�� ����� ���� ��� '�Է��� ��� ����� ���� ����� �����ϴ�.' ���
      ��ȸ�� ����� ���� ��� '�ش� ����� ���� ����� �����ϴ�.' ���
      �� ���� ���� �߻� �� '������ �߻��߽��ϴ�. �����ڿ��� �����ϼ���.' ���
*/
SET SERVEROUTPUT ON;

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN 
    SELECT EMP_ID, EMP_NAME INTO EID, ENAME FROM EMPLOYEE WHERE MANAGER_ID = &������;
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('�Է��� ��� ����� ���� ����� �����ϴ�.');
        WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('�ش� ����� ���� ����� �����ϴ�.');
        WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('������ �߻��߽��ϴ�. �����ڿ��� �����ϼ���.');
END;
/























