-- 한줄 주석
/*
    여러 줄 주석
*/

-- 현재 모든 계정들에 대하여 조회하는 명령문
SELECT * FROM DBA_USERS;
-- 명령문(SQL) 실행 : ctrl + enter 또는 상단 실행 버튼 클릭

-- 일반 사용자 계정 생성 구문 -> 관리자 계정으로만 생성 가능
-- [표현법] CREATE USER 계정명 IDENTIFIED BY 비밀번호;
-- * 12c 버전부터는 계정명 앞에 C## 을 붙여줘야 한다.

-- (1) 사용자명 : KH, 비밀번호 : KH 인 계정 추가 
CREATE USER C##KH IDENTIFIED BY KH;

-- 계정 생성 시 C## 을 제외하고 이전 방식으로 작업하고 싶은 경우
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- * 위 명령문을 SQL Developer를 실행할 때마다 명령문을 실행해야 한다.
-- CREATE USER KHTEST IDENTIFIED BY KHTEST; -- C##을 붙이지 않고 생성 가능

-- (2) 권한 부여
-- 생성한 사용자에게 최소한의 권한을 부여 (접속, 객체 생성 권한)
-- [표현법] GRANT 권한1, 권한2, ... TO 계정명;
GRANT CONNECT, RESOURCE TO C##KH;
-- * CONNECT : 연결 권한
-- * RESOURCE : 데이터 관리. DB에서의 객체(테이블, 시퀀스, 프로시저, 트리거 등)

-- 테이블 스페이스 관련 설정
ALTER USER C##KH DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;


