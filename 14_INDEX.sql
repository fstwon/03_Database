CREATE USER C##INDEXTEST IDENTIFIED BY INDEXTEST;
GRANT CONNECT, RESOURCE TO C##INDEXTEST;
ALTER USER C##INDEXTEST QUOTA 100M ON USERS;

SELECT COUNT(*) FROM USER_MOCK_DATA;

-- USER_INDEX_DATA 테이블 생성 (USER_MOCK_DATA 테이블 복제)
CREATE TABLE USER_INDEX_DATA AS SELECT * FROM USER_MOCK_DATA;

SELECT COUNT(*) FROM USER_INDEX_DATA;

-- * USER_INDEX_DATA 테이블에 기본 키 추가
ALTER TABLE USER_INDEX_DATA ADD CONSTRAINT PK_IDX_ID PRIMARY KEY (ID);

-- * USER_INDEX_DATA 테이블에 EMAIL 컬럼에 UNIQUE 추가 
ALTER TABLE USER_INDEX_DATA ADD CONSTRAINT UQ_IDX_EMAIL UNIQUE (EMAIL);

-- * 인덱스 정보 조회 
SELECT * FROM USER_IND_COLUMNS;
--------------------------------------------------------------------------------
-- * 인덱스가 설정되지 않은 테이블 (USER_MOCK_DATA) 수행 계획 조회 
EXPLAIN PLAN FOR SELECT * FROM USER_MOCK_DATA WHERE ID = 30000;
/*
    ------------------------------------------------------------------------------------
    | Id  | Operation         | Name           | Rows  | Bytes | Cost (%CPU)| Time     |
    ------------------------------------------------------------------------------------
    |   0 | SELECT STATEMENT  |                |    10 |  1330 |   239   (1)| 00:00:01 |
    |*  1 |  TABLE ACCESS FULL| USER_MOCK_DATA |    10 |  1330 |   239   (1)| 00:00:01 |
    ------------------------------------------------------------------------------------
    - Cos : 실행 예상 비용 (자원 소비량), 값이 낮을 수록 적은 비용으로 검색 수행 
    - Rows : 실행 계획 중 Access된 row의 수 
    - Bytes : 실행 계획 중 Access된 Bytes의 수

- TABLE ACCESS FULL (FULL 스캔) : 전체 테이블 탐색 후 결과 도출을 의미
*/
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- * 인덱스가 설정된 테이블
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
    
    - TABLE ACCESS BY INDEX ROWID : 인덱스 객체로 참조한 INDEX ROWID로 탐색한 결과 도출을 의미
    - INDEX UNIQUE SCAN : 인덱스 객체를 참조하여 탐색 후 결과 도출을 의미
*/

-- * 인덱스 추가
-- * USER_INDEX_DATA 테이블에 FIRST_NAME 컬럼에 인덱스 생성 
CREATE INDEX INDEX_FIRST_NAME ON USER_INDEX_DATA (FIRST_NAME);

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

-- * ID, FIRST_NAME 으로 조회
SELECT * FROM USER_INDEX_DATA WHERE ID = 40000 AND FIRST_NAME = 'Whitney';

-- 실행 계획 조회
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

-- * 조회 조건을 두가지 컬럼으로 자주 사용하는 경우 **결합 인덱스 생성**
CREATE INDEX INDEX_FIRSTNAME_ID ON USER_INDEX_DATA (ID, FIRST_NAME);

EXPLAIN PLAN FOR
    SELECT * FROM USER_INDEX_DATA WHERE ID = 40000 AND FIRST_NAME = 'Whitney';
    
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

COMMIT;









