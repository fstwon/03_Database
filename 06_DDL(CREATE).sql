-- DDL, CREATE 
-- 회원 정보를 저장할 테이블 생성
-- 테이블명 : MEMBER
/*
    COLOUMN 
    - 회원 번호 : 숫자 (NUMBER)
    - 회원 아이디 : 문자 (VARCHAR2(20))
    - 회원 비밀번호 : 문자 (VARCHAR2(20))
    - 회원 이름 : 문자 (VARCHAR2(20))
    - 성별 : 문자 (CHAR(3)) 
    - 연락처 : 문자 (CHAR(13))
    - 이메일 : 문자 (VARCHAR2(50))
    - 가입일 : 날짜 (DATE)
*/
CREATE TABLE MEMBER (
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
);

SELECT * FROM MEMBER;
--------------------------------------------------------------------------------
/*
    * 컬럼 설명 추가
*/
COMMENT ON COLUMN MEMBER.MEM_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.MEM_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEM_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.GENDER IS '성별';
COMMENT ON COLUMN MEMBER.PHONE IS '연락처';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.ENROLLDATE IS '가입일';

-- 테이블 삭제 : DROP TABLE 테이블명;
-- DROP TABLE MEMBER;

-- 테이블 데이터 추가
INSERT INTO MEMBER VALUES (
    1, 'mrpark', 'mrpark0000', '박영철', '남', '000-0000-0000', 'mrpark@email.com', SYSDATE
);
SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES (
    2, 'mrshee', 'mrshee0000', '김영희', '여', '000-0000-0000', NULL, SYSDATE
);

COMMIT; -- 변경 사항 적용
--------------------------------------------------------------------------------
/*
    * 제약 조건
*/
-- NULL 데이터 제약
-- * NOT NULL 제약 조건을 추가한 회원 테이블
-- 테이블명 : MEMBER_NOTNULL
-- 단, 회원번호, 아이디, 비밀번호, 이름에 대한 데이터는 NULL 값을 허용하지 않는다. 
CREATE TABLE MEMBER_NOTNULL (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
);

SELECT * FROM MEMBER_NOTNULL;

INSERT INTO MEMBER_NOTNULL VALUES (
  1, 'mrpark', 'mrpark0000', '박영철', '남', '000-0000-0000', 'mrpark@email.com', SYSDATE
);

INSERT INTO MEMBER_NOTNULL VALUES (
  2, 'mrshee', 'mrshee0000', '김영희', NULL, NULL, NULL, NULL
);

INSERT INTO MEMBER_NOTNULL VALUES (
  3, NULL, 'mrshee0000', '김옥순', NULL, NULL, NULL, NULL
); -- 제약 조건으로 인해 회원 아이디에 NULL 값을 입력할 수 없어서 오류 발생 (제약조건위배)
--------------------------------------------------------------------------------
/*
    * 중복 데이터 제약
*/
-- * UNIQUE 제약 조건을 추가하여 테이블 생성
-- 테이블명 : MEMBER_UNIQUE
-- 회원 아이디가 중복되지 않도록 제한
CREATE TABLE MEMBER_UNIQUE (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- 컬럼 레벨 방식. NOT NULL과 UNIQUE 제약 조건 설정
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
    
    -- , UNIQUE (컬럼명, ...) - 테이블 레벨 방식
);

SELECT * FROM MEMBER_UNIQUE;

INSERT INTO MEMBER_UNIQUE VALUES (
    1, 'mrpark', 'mrpark0000', '박영철', '남', '000-0000-0000', 'mrpark@email.com', SYSDATE
);

INSERT INTO MEMBER_UNIQUE VALUES (
    2, 'mrpark', 'mrshee0000', '김영희', '여', '000-0000-0000', 'mrshee@email.com', SYSDATE
); -- UNIQUE 제약 조건에 위배되어 오류 발생
--------------------------------------------------------------------------------
/*
    * 제약 조건명 설정
*/
-- MEMBER_UNIQUE 테이블 삭제
DROP TABLE MEMBER_UNIQUE;

-- 제약 조건명을 설정하여 재생성
CREATE TABLE MEMBER_UNIQUE (
    MEM_NO NUMBER CONSTRAINT MEMNO_NT NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NT NOT NULL,
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NT NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNM_NT NOT NULL,
    GENDER CHAR(3),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
    
    , CONSTRAINT MEMID_UQ UNIQUE (MEM_ID)
);

INSERT INTO MEMBER_UNIQUE 
    VALUES (1, 'mrpark', 'mrpark0000', '박영철', '남', '000-0000-0000', 'mrpark@email.com', SYSDATE);

INSERT INTO MEMBER_UNIQUE 
    VALUES (2, 'mrspark', 'mrshee0000', '김영희', '여', '000-0000-0000', 'mrshee@email.com', SYSDATE);

INSERT INTO MEMBER_UNIQUE 
    VALUES (3, 'mrpark', 'mrsok0000', '박옥순', '여', '000-0000-0000', 'mrsok@email.com', SYSDATE);
    
INSERT INTO MEMBER_UNIQUE 
    VALUES (3, NULL, NULL, '박옥순', '여', '000-0000-0000', 'mrsok@email.com', SYSDATE);
--------------------------------------------------------------------------------
/*
    * CHECK 제약 조건 
*/
-- CHECK 제약 조건 테이블 생성
-- 테이블명 : MEMBER_CHECK
-- 성별 컬럼에 '남' 또는 '여' 데이터만 저장하도록 제한
CREATE TABLE MEMBER_CHECK (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
    
    , UNIQUE (MEM_ID)
    -- CHECK(GENDER IN ('남', '여'))
);
SELECT * FROM MEMBER_CHECK;

INSERT INTO MEMBER_CHECK
    VALUES (1, 'mrpark', 'mrpark0000', '박영철', '남', '000-0000-0000', 'mrpark@email.com', SYSDATE);

INSERT INTO MEMBER_CHECK
    VALUES (2, 'mrspark', 'mrshee0000', '김영희', '어', '000-0000-0000', 'mrshee@email.com', SYSDATE);
--------------------------------------------------------------------------------
/*
    * PRIMARY KEY
*/

-- 기본 키 제약 조건 추가 테이블 생성
-- 테이블명 : MEMBER_PRI
-- 회원 번호에 기본키 설정
CREATE TABLE MEMBER_PRI (
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
    
    , UNIQUE (MEM_ID)
    -- CHECK(GENDER IN ('남', '여'))
);

SELECT * FROM MEMBER_PRI;

INSERT INTO MEMBER_PRI
    VALUES(1, 'ID', 'PWD', 'NAME', NULL, NULL, NULL, SYSDATE);
    
INSERT INTO MEMBER_PRI
    VALUES(1, 'ID2', 'PWD', 'NAME2', NULL, NULL, NULL, SYSDATE); -- 중복된 PK (MEM_ID) 값으로 저장을 시도하여 오류 발생 (MEMNO_PK)
INSERT INTO MEMBER_PRI
    VALUES(NULL, 'ID2', 'PWD', 'NAME2', NULL, NULL, NULL, SYSDATE); -- PK (MEM_ID) 값으로 NULL 값 저장을 시도하여 오류 발생 (MEMNO_PK)    
INSERT INTO MEMBER_PRI
    VALUES(2, 'ID2', 'PWD', 'NAME2', NULL, NULL, NULL, SYSDATE); -- PK (MEM_ID) 값으로 NULL 값 저장을 시도하여 오류 발생 (MEMNO_PK)    
SELECT * FROM MEMBER_PRI;

--------------------------------------------------------------------------------

-- * 두 개 컬럼을 기본키로 설정하여 테이블 생성
-- 테이블명 : MEMBER_PRI2
-- 회원번호, 회원아이디를 기본키로 설정 (복합키)
CREATE TABLE MEMBER_PRI2 (
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE CHAR(13),
    EMAIL VARCHAR2(50),
    ENROLLDATE DATE
    
    , UNIQUE (MEM_ID)
    , CONSTRAINT MEMPRI2_PK PRIMARY KEY (MEM_NO, MEM_ID)
);

SELECT * FROM MEMBER_PRI2;

INSERT INTO MEMBER_PRI2 
    VALUES (1, 'ID', 'PWD', 'NAME', NULL, NULL, NULL, NULL);
    
INSERT INTO MEMBER_PRI2 
    VALUES (1, 'ID2', 'PWD', 'NAME2', NULL, NULL, NULL, NULL);
--------------------------------------------------------------------------------
/*
    * FOREIGN KEY
*/
-- * 회원 등급 정보 저장 테이블 생성
-- 테이블명 : MEMBER_GRADE
-- 등급번호(PK), 등급명 (NOT NULL)
CREATE TABLE MEMBER_GRADE (
    GRADE_NO NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);

SELECT * FROM MEMBER_GRADE;

INSERT INTO MEMBER_GRADE VALUES (100, '일반회원');
INSERT INTO MEMBER_GRADE VALUES (200, 'VIP');
INSERT INTO MEMBER_GRADE VALUES (300, 'VVIP');

-- MEMBER TABLE 삭제 후 재생성
-- 회원번호, 회원아이디, 회원비밀번호, 회원이름, 성별, 가입일, 회원등급번호(GRADE_NO)
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    ENROLLDATE DATE,
    -- 컬럼 레벨 방식 외래키 저장
    GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO)
    
    -- 테이블 레벨 방식
    -- FOREIGN KEY (GRADE_NO) REFERENCES MEMBER_GRADE(GRADE_NO)
);

INSERT INTO MEMBER
    VALUES (1, 'ID', 'PWD', 'NAME', '남', SYSDATE, 100);

INSERT INTO MEMBER
    VALUES (2, 'ID2', 'PWD2', 'NAME2', '여', SYSDATE, 200);
    
INSERT INTO MEMBER
    VALUES (3, 'ID3', 'PWD3', 'NAME3', '남', SYSDATE, NULL);

INSERT INTO MEMBER
    VALUES (4, 'ID4', 'PWD4', 'NAME4', '여', SYSDATE, 400); -- 외래키로 저장되지 않은 데이터 사용하여 오류 발생

INSERT INTO MEMBER
    VALUES (4, 'ID4', 'PWD4', 'NAME4', '여', SYSDATE, 300);
    
SELECT * FROM MEMBER;

-- 부모테이블에서 자식테이블에 저장된 외래키 데이터를 삭제하는 경우
-- 무결성 제약 조건에 의해 삭제 불가
-- 회원 등급 테이블에서 등급번호가 100인 데이터 삭제
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    ENROLLDATE DATE,
    -- 컬럼 레벨 방식 외래키 저장
    GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE SET NULL
    
    -- 테이블 레벨 방식
    -- FOREIGN KEY (GRADE_NO) REFERENCES MEMBER_GRADE(GRADE_NO)
);

INSERT INTO MEMBER
    VALUES (1, 'ID', 'PWD', 'NAME', '남', SYSDATE, 100);

INSERT INTO MEMBER
    VALUES (2, 'ID2', 'PWD2', 'NAME2', '여', SYSDATE, 200);
    
INSERT INTO MEMBER
    VALUES (3, 'ID3', 'PWD3', 'NAME3', '남', SYSDATE, NULL);

-- 회원등급 정보 중 100번에 대한 등급 삭제
DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
SELECT * FROM MEMBER_GRADE;

ROLLBACK;

DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    ENROLLDATE DATE,
    -- 컬럼 레벨 방식 외래키 저장
    GRADE_ID NUMBER REFERENCES MEMBER_GRADE(GRADE_NO) ON DELETE CASCADE
    
    -- 테이블 레벨 방식
    -- FOREIGN KEY (GRADE_NO) REFERENCES MEMBER_GRADE(GRADE_NO)
);

INSERT INTO MEMBER
    VALUES (1, 'ID', 'PWD', 'NAME', '남', SYSDATE, 100);

INSERT INTO MEMBER
    VALUES (2, 'ID2', 'PWD2', 'NAME2', '여', SYSDATE, 200);
    
INSERT INTO MEMBER
    VALUES (3, 'ID3', 'PWD3', 'NAME3', '남', SYSDATE, NULL);

SELECT * FROM MEMBER;

DELETE FROM MEMBER_GRADE WHERE GRADE_NO = 100;
SELECT * FROM MEMBER_GRADE;
--------------------------------------------------------------------------------

/*
    * 기본값 (DEFAULT)
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    AGE NUMBER,
    HOBBY VARCHAR2(30) DEFAULT '없음',
    ENROLLDATE DATE
);

SELECT * FROM MEMBER;

INSERT INTO MEMBER
    VALUES (1, '박영철', 30, '음악감상', SYSDATE);
    
INSERT INTO MEMBER
    VALUES (2, '김옥순', 23, '게임', SYSDATE);

INSERT INTO MEMBER
    VALUES (3, '김영희', 20, NULL, NULL);

INSERT INTO MEMBER (MEM_NO, MEM_NAME)
    VALUES (4, '유');
--------------------------------------------------------------------------------
/*
    * 테이블 복제
*/
CREATE TABLE MEMBER_COPY AS SELECT * FROM MEMBER;

SELECT * FROM MEMBER_COPY;

-- MEMBER_COPY 테이블 회원 번호 컬럼에 기본키 설정
ALTER TABLE MEMBER_COPY ADD PRIMARY KEY (MEM_NO);

-- MEMBER_COPY 테이블 취미 컬럼에 기본값 설정 
ALTER TABLE MEMBER_COPY MODIFY HOBBY DEFAULT '-';


