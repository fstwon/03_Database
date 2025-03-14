CREATE USER C##INDEXTEST IDENTIFIED BY INDEXTEST;
GRANT CONNECT, RESOURCE TO C##INDEXTEST;
ALTER USER C##INDEXTEST QUOTA 100M ON USERS;

SELECT COUNT(*) FROM USER_MOCK_DATA;

-- USER_INDEX_DATA ���̺� ���� (USER_MOCK_DATA ���̺� ����)
CREATE TABLE USER_INDEX_DATA AS SELECT * FROM USER_MOCK_DATA;

SELECT COUNT(*) FROM USER_INDEX_DATA;

-- * USER_INDEX_DATA ���̺� �⺻ Ű �߰�
ALTER TABLE USER_INDEX_DATA ADD CONSTRAINT PK_IDX_ID PRIMARY KEY (ID);

-- * USER_INDEX_DATA ���̺� EMAIL �÷��� UNIQUE �߰� 
ALTER TABLE USER_INDEX_DATA ADD CONSTRAINT UQ_IDX_EMAIL UNIQUE (EMAIL);

-- * �ε��� ���� ��ȸ 
SELECT * FROM USER_IND_COLUMNS;
--------------------------------------------------------------------------------
-- * �ε����� �������� ���� ���̺� (USER_MOCK_DATA) ���� ��ȹ ��ȸ 
EXPLAIN PLAN FOR SELECT * FROM USER_MOCK_DATA WHERE ID = 30000;
/*
    ------------------------------------------------------------------------------------
    | Id  | Operation         | Name           | Rows  | Bytes | Cost (%CPU)| Time     |
    ------------------------------------------------------------------------------------
    |   0 | SELECT STATEMENT  |                |    10 |  1330 |   239   (1)| 00:00:01 |
    |*  1 |  TABLE ACCESS FULL| USER_MOCK_DATA |    10 |  1330 |   239   (1)| 00:00:01 |
    ------------------------------------------------------------------------------------
    - Cos : ���� ���� ��� (�ڿ� �Һ�), ���� ���� ���� ���� ������� �˻� ���� 
    - Rows : ���� ��ȹ �� Access�� row�� �� 
    - Bytes : ���� ��ȹ �� Access�� Bytes�� ��

- TABLE ACCESS FULL (FULL ��ĵ) : ��ü ���̺� Ž�� �� ��� ������ �ǹ�
*/
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- * �ε����� ������ ���̺�
EXPLAIN PLAN FOR SELECT * FROM USER_INDEX_DATA WHERE ID = 30000;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

/*
    -----------------------------------------------------------------------------------------------
    | Id  | Operation                   | Name            | Rows  | Bytes | Cost (%CPU)| Time     |
    -----------------------------------------------------------------------------------------------
    |   0 | SELECT STATEMENT            |                 |     1 |    63 |     2   (0)| 00:00:01 |
    |   1 |  TABLE ACCESS BY INDEX ROWID| USER_INDEX_DATA |     1 |    63 |     2   (0)| 00:00:01 |
    |*  2 |   INDEX UNIQUE SCAN         | PK_IDX_ID       |     1 |       |     1   (0)| 00:00:01 |
    -----------------------------------------------------------------------------------------------
    
    - TABLE ACCESS BY INDEX ROWID : �ε��� ��ü�� ������ INDEX ROWID�� Ž���� ��� ������ �ǹ�
    - INDEX UNIQUE SCAN : �ε��� ��ü�� �����Ͽ� Ž�� �� ��� ������ �ǹ�
*/

-- * �ε��� �߰�
-- * USER_INDEX_DATA ���̺� FIRST_NAME �÷��� �ε��� ���� 
CREATE INDEX INDEX_FIRST_NAME ON USER_INDEX_DATA (FIRST_NAME);

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- * ID, FIRST_NAME ���� ��ȸ
SELECT * FROM USER_INDEX_DATA WHERE ID = 40000 AND FIRST_NAME = 'Whitney';

-- ���� ��ȹ ��ȸ
EXPLAIN PLAN FOR
SELECT * FROM USER_INDEX_DATA WHERE ID = 40000 AND FIRST_NAME = 'Whitney';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
/*
    -----------------------------------------------------------------------------------------------
    | Id  | Operation                   | Name            | Rows  | Bytes | Cost (%CPU)| Time     |
    -----------------------------------------------------------------------------------------------
    |   0 | SELECT STATEMENT            |                 |     1 |    63 |     2   (0)| 00:00:01 |
    |*  1 |  TABLE ACCESS BY INDEX ROWID| USER_INDEX_DATA |     1 |    63 |     2   (0)| 00:00:01 |
    |*  2 |   INDEX UNIQUE SCAN         | PK_IDX_ID       |     1 |       |     1   (0)| 00:00:01 |
    -----------------------------------------------------------------------------------------------
*/

-- * ��ȸ ������ �ΰ��� �÷����� ���� ����ϴ� ��� **���� �ε��� ����**
CREATE INDEX INDEX_FIRSTNAME_ID ON USER_INDEX_DATA (ID, FIRST_NAME);

EXPLAIN PLAN FOR
    SELECT * FROM USER_INDEX_DATA WHERE ID = 40000 AND FIRST_NAME = 'Whitney';
    
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

COMMIT;









