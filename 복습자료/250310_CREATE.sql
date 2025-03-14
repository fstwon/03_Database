/*
��ĭ�� ������ �ܾ �ۼ��Ͻÿ�.
(DDL) :CREATE, ALTER, DROP

(DML): INSERT,DELETE,UPDATE

(DQL): SELECT
*/

/*
-- ���� ����� ���� ���� �� �Ʒ� ������ �ۼ����ּ���.
-- ID/PW  :  TEST250305 / test0305

-- �Ʒ� ������ �߰��ϱ� ���� ���̺��� �������ּ���.

-- �� �÷��� ������ �߰����ּ���.

-- ���� �����͸� �߰��ϱ� ���� ���� �������� �ۼ����ּ���.

--  ex) ����: �ﱹ��, ����: ����, ������: 14/02/14, ISBN : 9780394502946
------------------------------------------------------------
*/
/*
	- ���� ���� ���̺� : BOOK
	- ���� ����
	  - ����� ���ڸ��� NULL���� ������� �ʴ´�.
	  - ISBN ��ȣ�� �ߺ��� ������� �ʴ´�.
	- ���� ������
	  + ���� ��ȣ ex) 1, 2, 3, ...
	  + ���� ex) '�ﱹ��', '�����', '�ڽ���', ...
	  + ���� ex) '����', '�������丮', 'Į ���̰�', ...
	  + ������ ex) '14/02/14', '22/09/19', ...
	  + ISBN��ȣ ex) '9780394502946', '9780152048044', ...
*/

------------------------------------------------------------
-- ���̺� ����
CREATE TABLE BOOK (
    BOOK_NO NUMBER,
    TITLE VARCHAR2(200) NOT NULL,
    AUTHOR VARCHAR2(10) NOT NULL,
    PUBLISH_DATE DATE,
    ISBN_NO VARCHAR2(13) UNIQUE
);

-- ���� �߰�
COMMENT ON COLUMN BOOK.BOOK_NO IS '���� ��ȣ';
COMMENT ON COLUMN BOOK.TITLE IS '����';
COMMENT ON COLUMN BOOK.AUTHOR IS '����';
COMMENT ON COLUMN BOOK.PUBLISH_DATE IS '������';
COMMENT ON COLUMN BOOK.ISBN_NO IS 'ISBN��ȣ';

-- ���� ������ �߰�
INSERT INTO BOOK VALUES (1, '�ﱹ��', '����', TO_DATE('140214', 'YYMMDD'), '9780394502946');

SELECT * FROM BOOK;































