/*
    * DCL
*/
/*
    계정 생성
*/
-- SAMPLE/SAMPLE 계정 생성 - 관리자 계정으로 생성해야 한다.
CREATE USER C##SAMPLE IDENTIFIED BY SAMPLE;
-- 접속 권한 (CREATE SESSION) 부여
GRANT CREATE SESSION TO C##SAMPLE;

-- 테이블 생성 권한 (CREATE TABLE) 부여
GRANT CREATE TABLE TO C##SAMPLE;

-- 테이블 스페이스 할당
ALTER USER C##SAMPLE QUOTA 2M ON USERS; -- 2M 크기의 테이블 스페이스 공간 할당


/*
    * TCL
*/
-- * KH 계정으로 접속 변경 *

-- EMP01 테이블 삭제
DROP TABLE EMP01;

-- EMP01 테이블 생성 (AS EMPLOYEE (EMP_ID, EMP_NAME, DEPT_TITLE)) 
CREATE TABLE EMP01 AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID);

SELECT * FROM EMP01;

-- 217, 214 사번의 데이터 삭제
DELETE FROM EMP01 WHERE EMP_ID IN (217, 214);

ROLLBACK;

--------------------------------------------------------------------------------
DELETE FROM EMP01 WHERE EMP_ID = 217;
DELETE FROM EMP01 WHERE EMP_ID = 214;

COMMIT; -- 실제 DB에 변경사항 적용
ROLLBACK; -- 마지막 커밋 시점으로 복원

--------------------------------------------------------------------------------
-- 208, 209, 210 사번의 사원 정보 삭제 
DELETE FROM EMP01 WHERE EMP_ID IN (208, 209, 210);

SELECT * FROM EMP01;

SAVEPOINT SP;

-- 500번 사번의 사원 정보 추가 
INSERT INTO EMP01 VALUES (500, '오백번', '인사관리부');

-- 211번 사번의 사원 정보 삭제
DELETE FROM EMP01 WHERE EMP_ID = 211;

-- SP 시점으로 롤백 
ROLLBACK TO SP;
COMMIT; -- SP 시점으로 돌아간 뒤 COMMIT 적용 SP 이전 변경 사항만 DB에 적용
--------------------------------------------------------------------------------
SELECT * FROM EMP01 ORDER BY EMP_ID;

-- 221번 사번의 사원 정보 삭제 
DELETE FROM EMP01 WHERE EMP_ID = 221;

CREATE TABLE TEST (
    TID NUMBER
);

ROLLBACK;

























