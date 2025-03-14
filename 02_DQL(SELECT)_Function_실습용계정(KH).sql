/*
    * 함수 (Function)
    전달된 컬럼 값을 읽어 함수 실행 결과 반환
    
    - 단일행 함수
    여러 값을 읽어 여러 결과 값 반환 => 행마다 함수 실행 결과 반환
    
    - 그룹 함수
    여러 값을 읽어 하나의 결과 값 반환 => 그룹 별 함수 실행 결과 반환
    
    * SELECT 절에 단일행 함수와 그룹 함수는 동시 사용은 불가능하다. 
    => 반환 결과 행의 개수가 다르다.
    
    * 함수식을 사용하는 위치 : SELECT, WHERE, ORDER BY, GROUP BY, HAVING
*/
--==============================================================================
-- 단일행 함수 
/*
    문자 타입 데이터 처리 함수
    -> Varachar2(n), Char(n)
    
    * LENGTH (컬럼명 또는 '문자열') : 해당 문자열의 글자 수 반환
    * LENGTHB (컬럼명 또는 '문자열') : 해당 문자열의 바이트 수를 반환
    
    => 영문, 숫자, 특수문자 : 글자 당 1byte로 처리
    => 한글 : 글자 당 3byte씩 처리
*/
-- '오라클' 단어의 글자수, 바이트수 확인
SELECT LENGTH('오라클') AS "글자수", LENGTHB('오라클') AS "바이트수" FROM DUAL;

-- 'oracle' 단어의 글자수, 바이트수 확인
SELECT LENGTH('ORACLE') AS 글자수, LENGTHB('ORACLE') AS 바이트수 FROM DUAL;

-- 사원 정보 중 사원명, 사원명의 글자 수, 사원명의 바이트 수 확인, 이메일, 이메일의 글자 수, 이메일의 바이트 수 조회
SELECT EMP_NAME AS 사원명, LENGTH(EMP_NAME) AS 글자수, EMAIL AS 이메일, LENGTHB(EMP_NAME) AS 바이트수, 
       LENGTH(EMAIL) AS "이메일 글자 수", LENGTHB(EMAIL) AS "이메일 바이트 수" 
FROM EMPLOYEE;

/*
    * INSTR : 문자열 내 특정 문자의 시작 위치 반환
    
    [표현법]
    INSTR(컬럼 또는 '문자열', '특정문자'[, 시작 위치, 순번])
    => 실행 결과 값은 숫자 타입(Number) 반환
*/
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- 문자열의 시작 위치부터 첫번째 'B'의 위치 반환
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- 시작 위치 기본 값 : 1
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- 시작 위치에 음수 값을 전달하면 문자열의 마지막부터 찾는다.
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- 문자열의 사직 위치에서 2번째 위치한 'B'의 위치 반환

-- 사원 정보 중 이메일, 이메일 내 '_'의 첫번째 위치, 이메일 내 '@'의 첫번째 위치 조회 
SELECT EMAIL 이메일, INSTR(EMAIL, '_'), INSTR(EMAIL, '@') FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    * SUBSTR : 문자열에서 특정 문자열 추출해서 반환
    
    [표현법]
    SUBSTR('문자열' 또는 컬럼, 시작위치[, 길이(개수)]) 
    => 길이를 생략하면 시작위치부터 문자열 끝까지 추출
*/

SELECT SUBSTR('ORACLE SQL DEVELOPER', 10) FROM DUAL; -- 10번째 위치 ~ 끝 추출
SELECT SUBSTR('ORACLE SQL DEVELOPER', 12) FROM DUAL;

-- 위 문자열에서 'SQL' 추출
SELECT SUBSTR('ORACLE SQL DEVELOPER', 8, 3) FROM DUAL; -- 8번째 위치부터 세 글자 추출

SELECT SUBSTR('ORACLE SQL DEVELOPER', -3) FROM DUAL; -- 뒤에서 3번째 위치 ~ 끝 추출

SELECT SUBSTR('ORACLE SQL DEVELOPER', -9) FROM DUAL; 

SELECT SUBSTR('ORACLE SQL DEVELOPER', -9, 3) FROM DUAL; 

-- 사원 중 여사원의 이름, 주민번호 조회 
SELECT EMP_NAME 이름, EMP_NO 주민번호 FROM EMPLOYEE WHERE SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4';
SELECT EMP_NAME 이름, EMP_NO 주민번호 FROM EMPLOYEE WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

-- 사원 중 남사원의 이름, 주민번호 조회 (사원 이름 기준 오름차순 정렬)
SELECT EMP_NAME 이름, EMP_NO 주민번호 FROM EMPLOYEE WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3') ORDER BY EMP_NAME;

-- 사원 정보 중 사원명, 이메일, 아이디 조회 (아이디 = 이메일 값의 '@' 전까지)
SELECT EMP_NAME 사원명, EMAIL 이메일, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')  - 1) 아이디 FROM EMPLOYEE;

--------------------------------------------------------------------------------
/*
    * LPAD / RPAD : 문자열 조회 시 정렬 포멧을 지정하기 위해 사용
    
    [표현법]
    LPAD('문자열' 또는 컬럼, 총 길이[, '덧붙일문자']) -- Left pad로 왼쪽으로 '덧붙일문자'를 추가하여 포멧 지정 정렬
    RPAD('문자열' 또는 컬럼, 총 길이[, '덧붙일문자']) -- Right pad로 오른쪽으로 '덧붙일문자'를 추가하여 포멧 지정 정렬
    => '덧붙일문자'를 생략하면 공백으로 채워진다.
    => 총 길이는 문자열에 포함된 문자와 '덧붙일문자' 포함한 최종 길이
*/
-- 사원 정보 중 사원명에 왼쪽으로 공백을 채워 길이 20으로 조회
SELECT EMP_NAME, LPAD(EMP_NAME, 20) "사원명" FROM EMPLOYEE;

-- 사원 정보 중 사원명에 오른쪽으로 공백을 채워 길이 20으로 조회 
SELECT EMP_NAME, RPAD(EMP_NAME, 20) "사원명" FROM EMPLOYEE;

-- 사원 정보 중 사원명, 이메일 조회 시 이메일 길이 20으로 오른쪽 정렬
SELECT EMP_NAME 사원명, LPAD(EMAIL, 20) 이메일 FROM EMPLOYEE;

-- 사원 정보 중 사원명, 이메일 조회 시 이메일 길이 20으로 왼쪽 정렬
SELECT EMP_NAME 사원명, RPAD(EMAIL, 20) 이메일 FROM EMPLOYEE;

-- 사원 정보 중 사원명, 이메일 조회 시 이메일 '#'으로 왼쪽 정렬
SELECT EMP_NAME 사원명, RPAD(EMAIL, 20, '#') 이메일 FROM EMPLOYEE;

-- 주민번호 가리기
SELECT '000000-0' 주민번호, RPAD('000000-0', 14, '#') 가린번호 FROM EMPLOYEE;

-- 사원 정보 중 사원명, 주민번호 조회
-- 주민번호는 -1****** 의 형식으로 조회
-- (데이터, 길이, 문자)

SELECT EMP_NO 주민번호, RPAD(SUBSTR(EMP_NO, 1, 8), LENGTH(EMP_NO), '*') FROM EMPLOYEE;

--------------------------------------------------------------------------------

/*
    * LTRIM / RTRIM : 문자열에서 특정 문자를 제거 후 나머지 반환
    [표현법]
    LTRIM(문자열 또는 컬럼[, '제거할문자'])
    RTRIM(문자열 또는 컬럼[, '제거할문자'])
    => 제거 문자를 제시하지 않는 경우 공백을 제거한다.
*/
SELECT LTRIM('     H I') FROM DUAL; -- 왼쪽부터 공백이 아닌 문자가 나올때까지 공백 제거
SELECT RTRIM('H I     ') FROM DUAL;

SELECT LTRIM('123123H123', '123') FROM DUAL; -- H123
SELECT LTRIM('123123H123', '321') FROM DUAL; -- H123
SELECT RTRIM('123123H123', '123') FROM DUAL; -- 123123H

SELECT LTRIM('KKHHII', '123') FROM DUAL;

/*
    * TRIM : 문자열 앞/뒤/양쪽에 있는 '지정한문자'들을 제거 후 나머지 값 반환
    
    [표현법]
    TRIM([LEADING | TRAILING | BOTH] ['제거할문자' FROM] 문자열 또는 컬럼)
    
    * 첫번째 옵션 생략 시 기본 값 : BOTH
    * 제거할 문자 생략 시 공백 제거
*/
SELECT TRIM('      B    I       ') FROM DUAL; -- 양쪽 공백 제거

-- 'LLLLLHLILLLLL' 문자열에서 양쪽 'L' 제거
SELECT TRIM('L' FROM 'LLLLLHLILLLLL') FROM DUAL;
SELECT TRIM(BOTH 'L' FROM 'LLLLLHLILLLLL') FROM DUAL; -- 기본 값 확인
SELECT TRIM(LEADING 'L' FROM 'LLLLLHLILLLLL') FROM DUAL; -- 왼쪽 값 제거 (LTRIM 과 유사)
SELECT TRIM(TRAILING 'L' FROM 'LLLLLHLILLLLL') FROM DUAL; -- 오른쪽 값 제거 (RTRIM 과 유사)

--------------------------------------------------------------------------------

/*
    * LOWER / UPPER / INICAP
    - LOWER : 문자열을 모두 소문자로 변환하여 반환
    - UPPER : 문자열을 모두 대문자로 변환하여 반환
    - INITCAP : 띄어쓰기 기준 첫 글자마다 대문자로 변환하여 반환
*/
-- * 'Oh my god'
SELECT LOWER('Oh my god') FROM DUAL; -- 모든 영문자 소문자로 변환
SELECT UPPER('Oh my god') FROM DUAL; -- 모든 영문자 대문자로 변환
SELECT INITCAP('Oh my god') FROM DUAL; -- 띄어쓰기 기준 모든 첫 글자를 대문자로 변환

--------------------------------------------------------------------------------

/*
    * Concat : 문자열 두 개를 하나의 문자열로 합친 후 반환
    
    [표현법]
    CONCAT(문자열1, 문자열2)
*/
SELECT 'KH', 'A강의장' FROM DUAL;
SELECT 'KH' || ' ' || 'A강의장' FROM DUAL;
SELECT CONCAT('KH ', 'A강의장') FROM DUAL;

-- 사원 정보 중 사원명 조회 (* [사원명]님 형식으로 조회)
SELECT EMP_NAME || ' ' || '님' FROM EMPLOYEE;
SELECT CONCAT(EMP_NAME, '님') 사원명 FROM EMPLOYEE;

-- 200선동일님 형식으로 조회 *CONCAT 함수 사용
SELECT CONCAT(EMP_ID, CONCAT(EMP_NAME, '님')) 사원정보 FROM EMPLOYEE;

--------------------------------------------------------------------------------
/*
    * REPLACE : 문자열에서 특정 문자/문자열을 제시한 문자/문자열로 변경하여 반환
    
    [표현법] 
    REPLACE(문자열, '특정문자열', '변경할문자/문자열')    
*/
SELECT REPLACE('서울시 강남구', '강남구', '종로구') FROM DUAL;

-- 사원 정보 중 이메일 데이터의 '@kh.or.kr' 부분을 '@gmail.com'으로 변경하여 조회
SELECT EMAIL, REPLACE(EMAIL, '@kh.or.kr', '@gmail.com') 변경이메일 FROM EMPLOYEE;

--==============================================================================

/*
    [ 숫자 타입 함수 ]
*/

/*
    ABS : 숫자의 절대 값을 구하는 함수
*/
SELECT ABS(-100) FROM DUAL;
SELECT ABS(-12.34) FROM DUAL;

--------------------------------------------------------------------------------

/*
    * MOD : 두 수를 나눈 나머지 값을 구하는 함수
    MOD(숫자1, 숫자2) => 숫자1 % 숫자2
*/
-- 10을 3으로 나눈 나머지
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;

--------------------------------------------------------------------------------

/*
    * ROUND : 지정한 위치에서 반올림 값을 구하는 함수
    ROUND(숫자[, 반올림지정위치]) : 생략 시 첫째자리가 기본 값
*/
SELECT ROUND(123.456) FROM DUAL; -- 첫째자리 수 .4 위치에서 반올림
SELECT ROUND(123.456, 1) FROM DUAL; -- 첫째자리 수까지 표시, 다음 수에서 반올림
SELECT ROUND(123.456, 2) FROM DUAL; -- 둘째자리 수까지 표시, 다음 수에서 반올림

SELECT ROUND(123.456, -1) FROM DUAL; -- 120
SELECT ROUND(546.456, -1) FROM DUAL; -- 550
-- > 위치 값이 양수면 소수 부분, 음수면 정수 부분 반올림

--------------------------------------------------------------------------------
/*
    * CEIL : 소수의 올림 값을 구하는 함수 
*/
SELECT CEIL(123.456) FROM DUAL; -- 124

/*
    * FLOOR : 소수의 버림 값을 구하는 함수
*/
SELECT FLOOR(123.456) FROM DUAL; -- 123

/*
    * TRUNC : 버림처리 한 결과를 반환하는 함수 (위치 지정 가능)
    지정된 위치까지 표시, 이 후 수는 버림
*/

SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;

--==============================================================================
/*
    [ 날짜 타입 관련 함수 ]
*/
-- SYSDATE : 시스템의 현재 날짜 및 시간 반환
SELECT SYSDATE FROM DUAL;

-- MONTHS_BETWEEN : 두 날짜 사이의 개월 수 반환
-- [표현법] MONTHS_BETWEEN(날짜A, 날짜B) : 날짜A - 날짜B => 개월 수 반환

-- 개강 이후 지난 개월 수 (개강일: 24/12/31)
SELECT MONTHS_BETWEEN(SYSDATE, '24/12/31') || '개월' FROM DUAL;

-- 수료까지 남은 개월 수 (수료일: 25/06/18)
SELECT MONTHS_BETWEEN(SYSDATE, '25/06/18') FROM DUAL; -- -3.XXXXXXXXXXXXXXXXX
SELECT FLOOR(MONTHS_BETWEEN('25/06/18', SYSDATE)) || '개월' FROM DUAL;
SELECT CEIL(ABS(MONTHS_BETWEEN(SYSDATE, '25/06/18'))) || '개월' FROM DUAL;

-- 사원 정보 중 사원명, 입사일, 근속개월수 조회
SELECT EMP_NAME 사원명, HIRE_DATE 입사일, CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '개월차' 근속개월수 FROM EMPLOYEE WHERE ENT_DATE IS NULL;

/*
    * ADD_MONTHS : 특정 날짜에 N개월 수를 더한 값을 반환
    [표현법]
    ADD_MONTHS(날짜, 더할개월수)
*/
-- 현재 날짜 기준 3개월 후 조회
SELECT SYSDATE 현재날짜, ADD_MONTHS(SYSDATE, 3) "3개월 후" FROM DUAL;

-- 사원 정보 중 사원명, 입사일, 수습 종료일 조회
-- * 수습기간 : 입사일 + 3개월
SELECT EMP_NAME 사원명, HIRE_DATE 입사일, ADD_MONTHS(HIRE_DATE, 3) "수습 종료일" FROM EMPLOYEE;

/*
    * NEXT_DAY : 특정 날짜 이후 지정 요일의 가장 가까운 날짜 반환
    
    [표현법]
    NEXT_DAY(날짜, 요일)
    * 요일 : 숫자 또는 문자
    숫자 : 1(일) ~ 7(토)
    
    - 문자 타입으로 전달 시 언어 설정에 따라 사용해야 한다. 
    - 숫자 타입은 언어와 관계 없이 동작
*/
-- 현재 날짜 기준 가장 가까운 일요일의 날짜 조회
ALTER SESSION SET NLS_LANGUAGE = KOREAN; -- 언어 설정 변경 명령어
SELECT NEXT_DAY(SYSDATE, 1) FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '일요일') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '일') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT NEXT_DAY(SYSDATE, 'SUN') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, 'SUNDAY') FROM DUAL;
SELECT NEXT_DAY(SYSDATE, '일') FROM DUAL;

--------------------------------------------------------------------------------
/*
    * LAST_DAY : 해당 월 마지막 날짜 반환 
*/
SELECT LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY(ADD_MONTHS(SYSDATE, 3)) FROM DUAL;

-- 사원 정보 중 사원명, 입사일, 입사한 달의 마지막 날짜, 입사한 달의 근무 일수 조회
SELECT EMP_NAME 사원명, HIRE_DATE 입사일, LAST_DAY(HIRE_DATE) "입사한 달 마지막 날짜", 
        LAST_DAY(HIRE_DATE) - HIRE_DATE + 1 "입사월 근무일 수"
FROM EMPLOYEE;

--------------------------------------------------------------------------------
/*
    * EXTRACT : 특정 날짜로부터 연도/월/일 값을 추출하여 반환
    [표현법]
    EXTRACT(YEAR FROM '날짜') : 해당 날짜의 연도
    EXTRACT(MONTH FROM '날짜') : 해당 날짜의 월
    EXTRACT(DAY FROM '날짜') : 해당 날짜의 일
*/
-- 현재 날짜의 연도/월/일 추출하여 조회
SELECT SYSDATE "현재 날짜", 
        EXTRACT(YEAR FROM SYSDATE) 연도, 
        EXTRACT(MONTH FROM SYSDATE) 월,
        EXTRACT(DAY FROM SYSDATE) 일
FROM DUAL;

-- 사원 정보 중 사원명, 입사연도, 입사월, 입사일 조회 (* 정렬 : 입사연도 -> 입사월 -> 입사일 오름차순 정렬)
SELECT EMP_NAME 사원명, 
        EXTRACT(YEAR FROM HIRE_DATE) 입사연도, 
        EXTRACT(MONTH FROM HIRE_DATE) 입사월, 
        EXTRACT(DAY FROM HIRE_DATE) 입사일
FROM EMPLOYEE
ORDER BY 2, 3, 4;
        -- "입사연도", "입사월", "입사일"
/*
        EXTRACT(YEAR FROM HIRE_DATE), 
        EXTRACT(MONTH FROM HIRE_DATE), 
        EXTRACT(DAY FROM HIRE_DATE);
*/
--==============================================================================
/*
    * 형변환 함수 : 데이터 타입을 변경하는 함수
    -> 문자 / 숫자 / 날짜
*/

/*
    * TO_CHAR : 숫자 또는 날짜 타입의 값을 문자 타입으로 변경하는 함수
    [표현법] 
    TO_CHAR(숫자 또는 날짜[, 포멧]) 
*/
-- * 숫자 타입 -> 문자 타입
SELECT 1234 "숫자 타입의 데이터", TO_CHAR(1234) "문자 타입으로 변경된 숫자" FROM DUAL;

-- => 9 : 왼쪽으로 9의 개수만큼 자리 수를 확보하여 빈자리는 공백으로 채운다. 오른쪽 정렬
SELECT 
    TO_CHAR(1234) "타입 변경만 한 데이터", 
    TO_CHAR(1234, '999999') "포멧지정데이터" 
FROM DUAL;

-- => 0 : 왼쪽으로 0의 개수만큼 자리 수를 확보하여 빈자리를 0으로 채운다. 오른쪽 정렬
SELECT 
    TO_CHAR(1234) "타입 변경만 한 데이터", 
    TO_CHAR(1234, '000000') "포멧지정데이터" 
FROM DUAL;

-- => L : 현재 설정된 언어에 로컬 화폐 단위 표시
SELECT 
    TO_CHAR(1234) "타입 변경만 한 데이터", 
    TO_CHAR(1234, 'L999999') "포멧지정데이터" 
FROM DUAL;

-- => $ : 포멧을 앞에 추가
SELECT 
    TO_CHAR(1234) "타입 변경만 한 데이터", 
    TO_CHAR(1234, '$999999') "포멧지정데이터" 
FROM DUAL;

-- => 숫자에 자리 수 표시
SELECT 1000000, TO_CHAR(1000000, 'L9,999,999') FROM DUAL;

-- 사원의 사원명, 월급, 연봉 조회 (월급, 연봉은 화폐 단위, 자리 수 구분 표시)
SELECT 
    EMP_NAME 사원명,
    TO_CHAR(SALARY, 'L9,999,999') 월급, 
    TO_CHAR(SALARY * 12, 'L999,999,999') 연봉
FROM EMPLOYEE;
--------------------------------------------------------------------------------

-- 날짜 타입 -> 문자 타입
SELECT SYSDATE, TO_CHAR(SYSDATE) "문자로 형변환" FROM DUAL;

/*
    * 시간 관련 패턴
    - HH : 시 정보 (hour), 12시간제
    - HH24 : 시 정보 (hour), 24시간제
    
    - MI : 분 정보 (minute)
    - SS : 초 정보 (seconds)
    
    - AM : 오전 텍스트 표시
    - PM : 오후 텍스트 표시
*/
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;

/*
    * 요일 관련 패턴
    - DAY : X요일, 월요일, 화요일, ... 
    - DY : X, 월, 화, 수, ...
    - D : 숫자 타입으로 요일 정보 표시 (1 ~ 7), 1 = 일요일
*/
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY D') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'DAY') FROM DUAL;

/*
    * 월 관련 패턴
    - MON, MONTH : X월, 1월, 2월, 3월, ...
    - MM : 월 정보를 2자리로 표현
*/
SELECT TO_CHAR(SYSDATE, 'MON MONTH') FROM DUAL;

/*
    * 일 관련 패턴
    - DD : 일 정보를 2자리로 표현
    - DDD : 해당 날짜의 해당 연도 기준 몇 번째 일수인지 표시
*/
SELECT TO_CHAR(SYSDATE, 'DD') "2자리표현", TO_CHAR(SYSDATE, 'DDD') "몇 번째 일" FROM DUAL;

/*
    * 연도 관련 패턴
    - YYYY : 연도 네 자리 표현
    - YY : 연도 두 자리 표현
    
    - RRRR : 연도 네 자리 표현
    - RR : 연도 두 자리 표현
    => 
    00 ~ 49 사이의 연도를 입력할 시 
    현재 연도의 끝 두자리가 00 ~ 49 사이의 값과 같으면 현재 연도와 동일한 앞 두자리 연도 표시
    
    현재 연도의 끝 두자리가 50 ~ 99 사이의 값이면 현재 연도의 앞 두자리 + 1
    
    50 ~ 99 사이의 연도를 입력할 시 
    현재 연도의 끝 두자리가 00 ~ 49 사이의 값이면 현재 연도의 앞 두자리 - 1
    
    현재 연도의 끝 두자리가 50 ~ 99 사이의 값과 같으면 현재 연도와 동일한 앞 두자리 연도 표시
*/
SELECT 
    TO_CHAR(TO_DATE('250304', 'RRMMDD'), 'YYYY') "RR사용(50미만)", -- 2025
    TO_CHAR(TO_DATE('550304', 'RRMMDD'), 'YYYY') "RR사용(50이상)", -- 1955
    TO_CHAR(TO_DATE('250304', 'YYMMDD'), 'YYYY') "YY사용(50미만)", -- 2025
    TO_CHAR(TO_DATE('550304', 'YYMMDD'), 'YYYY') "YY사용(50이상)" -- 2055
FROM DUAL;

-- 사원 정보 중 사원명, 입사 날짜 조회 
-- (단, 입사 날짜 형식의 "XXXX년 XX월 XX일" 형식으로 조회)
-- 특정 문자에 대한 패턴은 ""에 표현해야 한다. 
SELECT EMP_NAME 사원명, TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') "입사 날짜" FROM EMPLOYEE;

/*
    * TO_DATE : 숫자 타입 또는 문자 타입을 날짜 타입으로 변경해주는 함수
    [표현법]
    TO_DATE(숫자 또는 문자[, 패턴])
*/
SELECT TO_DATE(20250304) FROM DUAL;
SELECT TO_DATE(250304) FROM DUAL;
SELECT TO_DATE(550304) FROM DUAL; -- 50년 이상은 19XX년으로 변경된다. 

SELECT TO_DATE(020222) FROM DUAL; -- ERROR, 숫자는 0으로 시작할 수 없다.
SELECT TO_DATE('020222') FROM DUAL; -- 0으로 시작할 경우 문자로 전달하면 된다.

SELECT TO_DATE('20250304 104230') FROM DUAL; -- ERROR, 시간을 포함하는 경우, 패턴을 전달해야 한다. 
SELECT TO_DATE('20250304 104230', 'YYYYMMDD HH24MISS') FROM DUAL;

/*
    * TO_NUMBER : 문자 타입의 데이터를 숫자 타입으로 변환하여 반환하는 함수
    [표현법]
    
    TO_NUMBER(문자[, 패턴])
    -> 기호가 포함되거나 화폐 단위를 포함하는 경우 패턴 전달
*/
SELECT TO_NUMBER('0123456789') FROM DUAL;
SELECT '10000' + '500' FROM DUAL;
SELECT '10,000' + '500' FROM DUAL; -- ERROR ','와 같은 기호가 포함되는 경우 오류 발생

SELECT TO_NUMBER('10,000', '99,999') + TO_NUMBER('500', '999') FROM DUAL;
--==============================================================================

/*
    * NULL 처리 함수
*/

/*
    * NVL : 해당 컬럼의 값이 NULL일 경우 다른 값으로 사용할 수 있도록 변환하는 함수
    
    [표현법]
    NVL(컬럼명, 해당 컬럼의 값이 NULL일 경우 사용할 값)
*/
-- 사원 정보 중 사원명, 보너스 조회
-- (단, 보너스 값이 NULL인 경우 0으로 표시)
SELECT EMP_NAME 사원명, BONUS, NVL(BONUS, '0') 보너스 FROM EMPLOYEE;

-- 사원 정보 중 사원명, 보너스, 연봉, 보너스 포함 연봉 정보 조회 
SELECT EMP_NAME 사원명, NVL(BONUS, 0), SALARY * 12 연봉, (SALARY + (SALARY * NVL(BONUS, 0))) * 12 "보스너 포함 연봉" FROM EMPLOYEE;

/*
    * NVL2 : 해당 컬럼의 값이 NULL인 경우 지정된 표시할 값, NULL이 아닌 경우 지정된 표시할 값으로 변환하여 반환하는 함수
    
    [표현법]
    NVL2(컬럼명, 데이터가 존재하는 경우 사용할 값, NULL인 경우 사용할 값)
*/
-- 사원 정보 중 사원명, 보너스 유무 조회 (보너스가 있을 경우 'O', 없을 경우 'X')
SELECT EMP_NAME 사원명, NVL2(BONUS, 'O', 'X') "보너스 유무" FROM EMPLOYEE;

-- 사원 정보 중 사원명, 부서코드, 부서 배치 여부 조회 (배치가 된 경우 '배정완료', 아닌 경우 '미배정' 표시)
SELECT EMP_NAME 사원명, DEPT_CODE "부서 코드", NVL2(DEPT_CODE, '배정완료', '미배정') "배치 여부" FROM EMPLOYEE;

/*
    NULLIF : 전달한 두 값이 일치하면 NULL, 일치하지 않는 경우 첫 번째 전달 값을 반환하는 함수
    [표현법]
    NULLIF(값1, 값2) 
*/
SELECT NULLIF('999', '999') FROM DUAL;
SELECT NULLIF('999', '555') FROM DUAL;

/*
    * 선택 함수
    DECODE(비교 대상, 비교 값1, 결과 값1, 비교 값2, 결과 값2, ...)
    자바의 switch문하고 유사
*/
-- 사원 정보 중 사번, 사원명, 주민번호, 성별 조회 
-- (단, 성별은 '1' : 남, '2' : 여, 그 외 알 수 없음)
SELECT EMP_ID 사번, EMP_NAME 사원명, EMP_NO 주민번호, DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여', '알 수 없음') 성별 FROM EMPLOYEE;

-- 사원 정보 중 사원명, 기존 급여, 인상 급여 조회
/*
    인상 조건
    직급이 'J7'인 사원은 0.1 인상
    직급이 'J6'인 사원은 0.15 인상
    직급이 'J5'인 사원은 0.2 인상 
    그 외 0.05 인상
*/
SELECT EMP_NAME 사원명, SALARY "기존 급여", DECODE(JOB_CODE, 'J7', SALARY * 1.1, 'J6', SALARY * 1.15, 'J5', SALARY * 1.2, SALARY * 1.05) "인상된 급여" FROM EMPLOYEE;

/*
    * CASE WHEN THEN : 조건에 따른 결과 값을 반환하는 함수
    [표현법]
    CASE 
        WHEN 조건식1 THEN 결과값1
        WHEN 조건식2 THEN 결과값2
        ...
        ELSE 결과값
    END
    자바의 if ~ else 문과 유사
*/
-- 사원 정보 중 사원명, 급여, 급여에 따른 등급 조회 
/*
    급여에 따른 등급 조건
    500만원 이상 '고급'
    350만원 이상 '중급'
    그 외 '초급'
*/
SELECT 
    EMP_NAME 사원명, 
    SALARY 급여, 
    CASE 
        WHEN SALARY >= '5000000' THEN '고급'
        WHEN SALARY >= '3500000' THEN '중급'
        ELSE '초급'
    END "급여에 따른 등급"
FROM EMPLOYEE;
--==============================================================================
-- 그룹 함수
/*
    * SUM : 컬럼 값들의 총 합을 반환해주는 함수
    [표현법]
    SUM(숫자타입컬럼)
*/
-- 전체 사원들의 총 급여 조회
SELECT SUM(SALARY) FROM EMPLOYEE;

-- 'XXX,XXX,XXX' 형식으로 조회
SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') FROM EMPLOYEE;

-- 남 사원들의 총 급여 
SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') FROM EMPLOYEE 
-- WHERE SUBSTR(EMP_NO, 8, 1) IN('1', '3');
WHERE SUBSTR(EMP_NO, 8) LIKE '1%';

-- 부서 코드가 'D5'인 사원의 총 연봉 조회 
SELECT TO_CHAR(SUM(SALARY * 12), 'L999,999,999') "D5 부서의 총 연봉" FROM EMPLOYEE WHERE DEPT_CODE = 'D5';
--------------------------------------------------------------------------------
/*
    * AVG : 데이터 값들의 평균 값을 계산하여 반환하는 함수
    [표현법]
    AVG(숫자 타입 컬럼)
*/
-- 전체 사원의 평균 급여 조회 (* 반올림 적용)
SELECT TO_CHAR(ROUND(AVG(SALARY)), 'L999,999,999') FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    * MIN : 해당 컬럼의 최소 값을 반환하는 함수
    
    [표현법]
    MIN(모든 타입 컬럼)
*/
SELECT MIN(EMP_NAME) "문자 타입의 최소 값", MIN(SALARY) "숫자 타입의 최소 값", MIN(HIRE_DATE) "날짜 타입의 최소 값" FROM EMPLOYEE;

/*
    * MAX : 해당 컬럼의 최대 값을 반환하는 함수
    [표현법]
    MAX(모든 타입 컬럼)
*/
SELECT MAX(EMP_NAME) "문자 타입의 최대 값", MAX(SALARY) "숫자 타입의 최대 값", MAX(HIRE_DATE) "날짜 타입의 최대 값" FROM EMPLOYEE;
--------------------------------------------------------------------------------
/*
    * COUNT : 행의 개수를 반환하는 함수 (단, 조건이 있을 경우 해당 조건에 맞는 행의 개수 반환)
    [표현법]
    COUNT(*) : 조회된 결과에 모든 행의 개수 반환
    COUNT(COLUMN) : 해당 컬럼의 값이 NULL이 아닌 행의 개수만 계산해서 반환
    COUNT(DISTINCT COLUMN) : 해당 컬럼 값 중 중복 값을 제거한 행의 개수를 계산해서 반환
    => 중복 제거 시 NULL은 포함하지 않고 계산한다. 
*/
-- 전체 사원 수 조회
SELECT COUNT(*) FROM EMPLOYEE;

-- 남 직원 수 조회
SELECT COUNT(*) "남직원 수" FROM EMPLOYEE WHERE SUBSTR(EMP_NO, 8, 1) IN ('1', '3');

-- 여 직원 수 조회
SELECT COUNT(*) "여직원 수" FROM EMPLOYEE WHERE SUBSTR(EMP_NO, 8, 1) IN ('2', '4');

-- 보너스를 받는 사원 수
SELECT COUNT(*) "보너스를 받는 사원 수" FROM EMPLOYEE WHERE BONUS IS NOT NULL;
SELECT COUNT(BONUS) "보너스를 받는 사원 수" FROM EMPLOYEE;

-- 부서 배치를 받은 사원 수 조회
SELECT COUNT(*) "부서 배치를 받은 사원 수" FROM EMPLOYEE WHERE DEPT_CODE IS NOT NULL;
SELECT COUNT(DEPT_CODE) "부서 배치를 받은 사원 수" FROM EMPLOYEE;

SELECT COUNT(DISTINCT DEPT_CODE) "소속 사원이 있는 부서 수" FROM EMPLOYEE;









