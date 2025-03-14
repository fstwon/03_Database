/*
    * PROCEDURE
    
*/
-- * 화면에 표시하기 위한 설정
SET SERVEROUTPUT ON;

-- "HELLO ORACLE" 출력
-- 화면 출력 명령어 : DBMS_OUTPUT.PUT_LINE(출력할내용)

BEGIN 
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
    
END;
/
--------------------------------------------------------------------------------
/*
    * 선언부
    DECLARE
        변수, 상수 선언 및 초기화
*/
/*
    * 일반 타입 변수
    변수명 [CONSTANT] 자료형
*/
DECLARE
    -- EID 이름의 NUMBER 타입 변수 선언
    EID NUMBER;
    -- ENAME 이름의 VARCHAR2(20) 타입 변수 선언
    ENAME VARCHAR(20);
    -- PI 이름의 NUMBER 타입 상수 선언 및 3.14 값 초기화
    PI CONSTANT NUMBER := 3.14;
BEGIN
    -- * 변수에 값 대입
    -- EID = 100
    EID := 100;
    -- ENAME = '박영철'
    ENAME := '박영철';
    -- 변수, 상수 출력
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
-- * 값을 입력 받아 변수 대입
DECLARE 
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN 
    ENAME := '박영철';
    EID := &사원번호;
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
--------------------------------------------------------------------------------

/*
    * 레퍼런스 타입 변수 
*/

DECLARE    
    -- EID 변수 EMPLOYEE 테이블의 EMP_ID 타입 참조
    EID EMPLOYEE.EMP_ID%TYPE;
    -- ENAME 변수 EMPLOYEE 테이블의 EMP_NAME 타입 참조
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    -- SAL 변수 EMPLOYEE 테이블 SALARY 타입 참조
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN 
    -- EMPLOYEE 테이블에서 입력 받은 사번의 사원 정보 조회
    
    SELECT EMP_ID, EMP_NAME, SALARY 
    INTO EID, ENAME, SAL
    FROM EMPLOYEE WHERE EMP_ID = &사원번호;
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/
--------------------------------------------------------------------------------
/*
    * 레퍼런스 타입 변수 선언
    EID, ENAME, JCODE, SAL, DTITLE 
    
    * 참조 자료형
    EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    
    * 입력 받은 사번의 사원 정보 조회 변수 대입
    
    * 출력
    사번, 이름, 직급코드, 급여, 부서명
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE 
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    WHERE EMP_ID = &사원번호;
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('JCODE : ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
    DBMS_OUTPUT.PUT_LINE('DTITLE : ' || DTITLE);
END;
/
--------------------------------------------------------------------------------
/*
    * ROW 타입 변수
*/
-- E 변수에 EMPLOYEE 테이블 ROW 타입 변수 선언
DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN 
    SELECT * INTO E FROM EMPLOYEE WHERE EMP_ID = &사번;
    
    -- 사원명, 급여, 보너스 정보 출력
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || E.SALARY);
    -- DBMS_OUTPUT.PUT_LINE('보너스 : ' || E.BONUS);
    -- NULL 값 출력
    DBMS_OUTPUT.PUT_LINE('보너스 : ' || NVL(E.BONUS, 0));
END;
/
--------------------------------------------------------------------------------
/*
    * 실행부 (BEGIN)
    
    * 조건문
*/
/*
    입력 받은 사번의 사번, 이름, 급여, 보너스 정보 출력
    * 변수 
    EID, ENAME, SAL, BONUS
    * 보너스 값이 0(NULL)인 사원은 '보너스를 받지 않는 사원입니다.' 출력
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN 
    SELECT 
        EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0) 
    INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SAL);
    
    IF BONUS = 0 THEN DBMS_OUTPUT.PUT_LINE('보너스를 받지 않는 사원입니다.');
    ELSE     
        DBMS_OUTPUT.PUT_LINE('보너스 : ' || BONUS);
    END IF;
END;
/
--------------------------------------------------------------------------------
/*
    입력 받은 사원의 자원 정보 조회 (사번, 이름, 부서명, 국가정보)
    
    * 국가명 : 'KO', '국내팀', '해외팀'
    * 레퍼런스 타입 변수 
    사번, 이름, 부서명, 국가코드
    * 일반 타입 변수
    팀 정보 저장, 문자타입
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.LOCAL_CODE%TYPE;
    TEAM VARCHAR(10);
BEGIN
    SELECT 
        EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE 
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
    WHERE EMP_ID = &사번;
    
    IF NCODE = 'KO' THEN TEAM := '국내팀';
    ELSE TEAM := '해외팀';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('국가정보 : ' || TEAM);
END;
/
--------------------------------------------------------------------------------
/*
    점수(SCORE) : 입력 받은 점수 저장 변수
    등급(GRADE) : 등급 정보 저장 변수
    
    90 >= SCORE 'A'
    80 >= 'B'
    70 >= 'C'
    60 >= 'D'
    'F'
    
    '점수는 SCORE이고, 등급은 GRADE입니다.'
    F, '재평가 대상입니다.'
*/
DECLARE
    SCORE NUMBER;
    GRADE CHAR(1);
BEGIN
    SCORE := &점수;
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    DBMS_OUTPUT.PUT_LINE('점수는 ' || SCORE || '이고, 등급은 ' || GRADE || '입니다.');
    
    IF GRADE <> 'F'
    THEN DBMS_OUTPUT.PUT_LINE('재평가 대상입니다.');
    END IF;
END;
/
--------------------------------------------------------------------------------
-- * 입력 받은 사원의 부서 코드 기준 부서명 출력 (JOIN 사용 X)
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DTITLE VARCHAR2(20);
BEGIN 
    SELECT * INTO EMP FROM EMPLOYEE WHERE EMP_ID = &사번;
    
    DTITLE := CASE EMP.DEPT_CODE 
                    WHEN 'D1' THEN '인사관리부'
                    WHEN 'D2' THEN '회계관리부'
                    WHEN 'D3' THEN '마케팅부'
                    WHEN 'D4' THEN '국내영업부'
                    WHEN 'D5' THEN '해외영업1부'
                    WHEN 'D6' THEN '해외영업2부'
                    WHEN 'D7' THEN '해외영업3부'
                    WHEN 'D8' THEN '기술지원부'
                    WHEN 'D9' THEN '총무부'
                END;
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME || ' 사원의 소속부서는 ' || DTITLE || '입니다.');
END;
/
--------------------------------------------------------------------------------
/*
    * 반복문
*/
-- 일반 구문 
DECLARE
    N NUMBER := 1;
BEGIN 
    LOOP 
        DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
        N := N + 1;
        IF N > 5 THEN EXIT;
        END IF;
    END LOOP;
END;
/
-- FOR LOOP 문 
BEGIN 
    FOR I IN 1..5
    LOOP 
        DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
    END LOOP;
END;
/
-- FOR LOOP REVERSE 
BEGIN 
    FOR I IN REVERSE 1..5
    LOOP 
        DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
    END LOOP;
END;
/
--------------------------------------------------------------------------------
-- TEST 테이블 삭제
DROP TABLE TEST;
-- TEST 테이블 생성, TNO(PK), TDATE
CREATE TABLE TEST (
    TNO NUMBER CONSTRAINT TNO_PK PRIMARY KEY,
    TDATE DATE
);
-- SEQUENCE 생성, SEQ_TNO, 증가값 2, 최대값 1000, 순환 X, CACHE X
CREATE SEQUENCE SEQ_TNO INCREMENT BY 2 MAXVALUE 1000 NOCYCLE NOCACHE;

-- TEST 테이블 데이터 100개 추가. TDATE 값 현재 날짜 정보 추가
BEGIN 
    FOR I IN 1..100
    LOOP
        INSERT INTO TEST VALUES(SEQ_TNO.NEXTVAL, SYSDATE);
    END LOOP;
END;
/

SELECT * FROM TEST;
--------------------------------------------------------------------------------
/*
    EXCEPTION
*/
-- 입력 받은 숫자로 10을 나눈 결과 출력
DECLARE
    NUM NUMBER;
BEGIN 
    NUM := &숫자;
    DBMS_OUTPUT.PUT_LINE(10/NUM);
    EXCEPTION
    -- WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('0으로 나눌 수 없습니다.);
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('0으로 나눌 수 없습니다.');
END;
/

-- EMPLOYEE 테이블에 EMP_ID 컬럼이 기본키로 설정
-- ALTER TABLE EMPLOYEE ADD PRIMARY KEY (EMP_ID);

-- 입력 받은 사원번호로 '노옹철'사원의 사번 변경
BEGIN
    UPDATE EMPLOYEE
        SET EMP_ID = '&변경할_사번'
    WHERE EMP_NAME = '노옹철';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('중복된 사원번호 입니다.');
END;
/

SELECT TO_DATE('220905', 'YYMMDD') - TO_DATE('221005', 'YYMMDD') FROM DUAL;




















































