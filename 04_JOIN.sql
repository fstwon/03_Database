/*
    * JOIN
    : 두 개 이상의 테이블에서 데이터 조회가 필요한 경우 사용하는 구문
    조회 결과는 하나의 Result set으로 확인 가능
    
    => 관계형 데이터베이스에서는 중복 저장을 최소화하기 위해 최대한 나누어서 관리하고 
    최소한의 데이터를 각 테이블에 저장한다. 
    
    => 관계형 데이터베이스에서 쿼리문을 사용하여 테이블 간 "관계"를 연결하는 방법
    각 테이블 간 연결고리(외래키)를 통해 데이터를 매칭하여 조회한다.
    
    JOIN은 크게 "오라클 전용 구문"과 "ANSI 구문"
    
    - 오라클 전용 구문
    등가 조인 (EQUAL JOIN)
    포괄 조인 (LEFT JOIN/RIGHT JOIN)
    자체 조인 (SELF JOIN)
    비등가 조인 (NON EQUAL JOIN)
    
    - ANSI 구문
    내부 조인 (INNER JOIN) -> JOIN ON/USING
    왼쪽 외부 조인 (LEFT OUTER JOIN)
    오른쪽 외부 조인 (RIGHT OUTER JOIN)
    전체 외부 조인 (FULL OUTER JOIN)
    JOIN ON
*/
-- 전체 사원의 사번, 사원명, 부서 코드 조회
SELECT EMP_ID 사번, EMP_NAME "사원 명", DEPT_CODE "부서 코드" FROM EMPLOYEE;
-- 부서 정보에서 부서 코드, 부서 명 조회
SELECT DEPT_ID "부서 코드", DEPT_TITLE "부서 명" FROM DEPARTMENT;
-- 전체 사원의 사번, 사원명, 직급 코드 조회
SELECT EMP_ID 사번, EMP_NAME "사원 명", JOB_CODE "직급 코드" FROM EMPLOYEE;
-- 직급 정보에서 직급 코드, 직급 명 조회
SELECT JOB_CODE "직급 코드", JOB_NAME "직급 명" FROM JOB;
--------------------------------------------------------------------------------
/*
    * 등가 조인 (EQUAL JOIN) /  내부 조인 (INNER JOIN)
    연결하는 컬럼의 값이 일치하는 행만 조회(불일치 값은 결과에서 제외)
*/
-- * 오라클 전용 구문 
/*
    - FROM 절에 조회하고자 하는 테이블 나열(','로 구분)
    - WHERE 절에 매칭 컬럼에 대한 조건 작성
*/
-- 사원의 사번, 이름, 부서 명 조회
-- => 부서 코드 컬럼으로 연결 (DEPT_CODE, DEPT_ID)
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_TITLE "부서 명"
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
-- DEPT_CODE 값이 NULL인 경우 
-- 각 테이블에만 존재하는 데이터는 제외

-- 사원의 사번, 이름, 직급 명 조회
SELECT EMP_ID 사번, EMP_NAME 이름, JOB_TITLE "직급 명"
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;
-- FROM EMPLOYEE, JOB
-- WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- * ANSI 구문 (표준)
/*
    - FROM 절에 기준이 되는 테이블 하나 작성
    - JOIN 절에 조인이 필요한 테이블 기술 + 필요한 매칭 조건 작성
    
    * JOIN ON : 컬럼명이 같거나 다른 경우 
    FROM 테이블1 JOIN 테이블2 ON 조건
    
    * JOIN USING : 컬럼명이 같은 경우
    FROM 테이블1 JOIN 테이블2 USING (조건)
*/
-- 사번, 사원 명, 부서 명 조회
SELECT EMP_ID 사번, EMP_NAME "사원 명", DEPT_TITLE "부서 명" 
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- 사번, 사원 명, 직급 명 조회
SELECT EMP_ID 사번, EMP_NAME "사원 명", JOB_NAME "직급 명"
FROM EMPLOYEE E JOIN JOB J USING (JOB_CODE);

SELECT EMP_ID 사번, EMP_NAME "사원 명", JOB_NAME "직급 명"
FROM EMPLOYEE E JOIN JOB J ON E.JOB_CODE = J.JOB_CODE;

-- 대리 직급 사원의 사번, 사원 명, 직급 명, 급여 조회 
-- * 오라클 구문
SELECT EMP_ID 사번, EMP_NAME "사원 명", JOB_NAME "직급 명", SALARY 급여
FROM EMPLOYEE E, JOB J 
WHERE E.JOB_CODE = J.JOB_CODE AND JOB_NAME = '대리'; -- JOB_CODE = 'J6';

-- * ANSI 구문
SELECT EMP_ID 사번, EMP_NAME "사원 명", JOB_NAME "직급 명", SALARY 급여
FROM EMPLOYEE E JOIN JOB J USING (JOB_CODE) WHERE JOB_NAME = '대리';
-- ON E.JOB_CODE = J.JOB.CODE;

-- [1] 부서가 인사관리부인 사원의 사번, 사원 명, 보너스 조회 
-- * 오라클 구문
SELECT EMP_ID 사번, EMP_NAME "사원 명", NVL(BONUS, 0) 보너스 
FROM EMPLOYEE E, DEPARTMENT D WHERE DEPT_CODE = DEPT_ID AND DEPT_TITLE = '인사관리부';

-- * ANSI 구문
SELECT EMP_ID 사번, EMP_NAME "사원 명", NVL(BONUS, 0) 보너스 
FROM EMPLOYEE E JOIN DEPARTMENT D ON DEPT_CODE = DEPT_ID WHERE DEPT_TITLE = '인사관리부';

-- [2] 부서와 지역 정보를 참고하여, 전체 부서의 부서 코드, 부서명, 지역코드, 지역별 조회
-- * 오라클 구문
SELECT DEPT_ID "부서 코드", DEPT_TITLE "부서 명", LOCATION_ID "지역 코드", LOCAL_NAME "지역"
FROM DEPARTMENT D, LOCATION L WHERE LOCATION_ID = LOCAL_CODE;

-- * ANSI 구문
SELECT DEPT_ID "부서 코드", DEPT_TITLE "부서 명", LOCATION_ID "지역 코드", LOCAL_NAME "지역"
FROM DEPARTMENT D JOIN LOCATION L ON LOCATION_ID = LOCAL_CODE;

-- [3] 보너스를 받는 사원의 사번, 사원 명, 보너스, 부서 명 조회 
-- * 오라클 구문
SELECT EMP_ID 사번, EMP_NAME "사원 명", BONUS 보너스, DEPT_TITLE "부서 명" 
FROM EMPLOYEE E, DEPARTMENT D WHERE DEPT_CODE = DEPT_ID AND BONUS IS NOT NULL;

-- * ANSI 구문
SELECT EMP_ID 사번, EMP_NAME "사원 명", BONUS 보너스, DEPT_TITLE "부서 명" 
FROM EMPLOYEE E JOIN DEPARTMENT D ON DEPT_CODE = DEPT_ID WHERE BONUS IS NOT NULL;

-- [4] 부서가 총무부가 아닌 사원의 사원명, 급여 조회
-- * 오라클 구문
SELECT EMP_NAME "사원 명", SALARY 급여 
FROM EMPLOYEE E, DEPARTMENT D WHERE DEPT_CODE = DEPT_ID AND DEPT_TITLE != '총무부';

-- * ANSI 구문
SELECT EMP_NAME "사원 명", SALARY 급여 
FROM EMPLOYEE E JOIN DEPARTMENT D ON DEPT_CODE = DEPT_ID WHERE DEPT_TITLE <> '총무부';
--------------------------------------------------------------------------------
/*
    * 포괄 조인 / 외부 조인 (OUTER JOIN)
    두 테이블 간 JOIN 시 일치하지 않는 행도 포함하여 조회하는 구문 
    단, 반드시 LEFT/RIGHT(기준 테이블) 를 지정해 주어야 한다.
    
    * LEFT JOIN : 두 테이블 중 왼쪽 테이블을 기준으로 JOIN
    * RIGHT JOIN : 두 테이블 중 오른쪽 테이블을 기준으로 JOIN 
    
    * FULL JOIN : 두 테이블이 가진 모든 행을 조회하는 JOIN (* ANSI 구문 전용)
*/
-- 모든 사원의 사원 명, 부서 명, 급여, 연봉 조회
-- * LEFT JOIN 
-- * 오라클 구문
SELECT EMP_NAME "사원 명", DEPT_TITLE "부서 명", SALARY * 12 연봉 
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);

-- * ANSI 구문
SELECT EMP_NAME "사원 명", DEPT_TITLE "부서 명", SALARY * 12 연봉
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- * RIGHT JOIN 
-- * 오라클 구문
SELECT EMP_NAME "사원 명", DEPT_TITLE "부서 명", SALARY * 12 연봉 
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- * ANSI 구문
SELECT EMP_NAME "사원 명", DEPT_TITLE "부서 명", SALARY * 12 연봉
FROM EMPLOYEE RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

-- * FULL JOIN
SELECT EMP_NAME "사원 명", DEPT_TITLE "부서 명", SALARY * 12 연봉
FROM EMPLOYEE FULL JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
--------------------------------------------------------------------------------
/*
    * 비등가 조인 (NON EQUAL JOIN)
    매칭이 필요한 컬럼에 대해 조건 작성 시 '='를 사용하지 않는 조인. 보통 범위에 대한 조건
    
    * ANSI 구문에서는 JOIN ON 만 사용 가능
*/

-- 사원의 사원 명, 급여, 급여 등급 조회 
-- * 오라클 구문
SELECT EMP_NAME "사원 명", SALARY 급여, SAL_LEVEL "급여 등급"
FROM EMPLOYEE, SAL_GRADE
-- WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- * ANSI 구문
SELECT EMP_NAME "사원 명", SALARY 급여, SAL_LEVEL "급여 등급"
FROM EMPLOYEE JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND MAX_SAL;
--------------------------------------------------------------------------------
/*
    * 자체 조인 (SELF JOIN)
    동일 테이블을 조인하는 구문
*/
-- 전체 사원의 사번, 사원 명, 부서 코드 
-- 사수 사번, 사수 사원 명, 사수 부서 코드 조회
-- * 오라클 구문
SELECT 
    E.EMP_ID 사번, E.EMP_NAME "사원 명", E.DEPT_CODE "부서 코드",
    M.EMP_ID "사수 사번", M.EMP_NAME "사수 사원 명", M.DEPT_CODE "사수 부서 코드"
FROM EMPLOYEE E, EMPLOYEE M WHERE E.MANAGER_ID = M.EMP_ID;

-- * ANSI 구문 
SELECT 
    E.EMP_ID 사번, E.EMP_NAME "사원 명", E.DEPT_CODE "부서 코드",
    M.EMP_ID "사수 사번", M.EMP_NAME "사수 사원 명", M.DEPT_CODE "사수 부서 코드"
FROM EMPLOYEE E 
JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID;
-- LEFT JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID; 
--------------------------------------------------------------------------------
/*
    * 다중 조인 
    2개 이상의 테이블 연결
*/
-- 사번, 사원 명, 부서 명, 직급 명 조회
-- * 오라클 구문
SELECT EMP_ID 사번, EMP_NAME "사원 명", DEPT_TITLE "부서 명", JOB_NAME "직급 명"
FROM EMPLOYEE E, DEPARTMENT D, JOB J WHERE DEPT_CODE = DEPT_ID AND E.JOB_CODE = J.JOB_CODE;

-- * ANSI 구문
SELECT EMP_ID 사번, EMP_NAME "사원 명", DEPT_TITLE "부서 명", JOB_NAME "직급 명"
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID JOIN JOB USING (JOB_CODE);

-- 사번, 사원 명, 부서 명, 지역 명 조회 
-- * 오라클 구문
SELECT EMP_ID 사번, EMP_NAME "사원 명", DEPT_TITLE "부서 명", LOCAL_NAME "지역 명"
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L WHERE DEPT_CODE = DEPT_ID AND LOCATION_ID = LOCAL_CODE;

-- * ANSI 구문
SELECT EMP_ID 사번, EMP_NAME "사원 명", DEPT_TITLE "부서 명", LOCAL_NAME "지역 명"
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;
--------------------------------------------------------------------------------
--==============================================================================

-- QUIZ

-- [1] 사번, 사원 명, 부서 명, 지역 명, 국가 명 조회
-- * 오라클 구문
SELECT EMP_ID 사번, EMP_NAME "사원 명", DEPT_TITLE "부서 명", LOCAL_NAME "지역 명", NATIONAL_NAME "국가 명"
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N 
WHERE 
DEPT_CODE = DEPT_ID AND
LOCATION_ID = LOCAL_CODE AND
L.NATIONAL_CODE = N.NATIONAL_CODE;

-- * ANSI 구문
SELECT EMP_ID 사번, EMP_NAME "사원 명", DEPT_TITLE "부서 명", LOCAL_NAME "지역 명", NATIONAL_NAME "국가 명"
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
JOIN NATIONAL USING (NATIONAL_CODE);

-- [2] 사번, 사원 명, 부서 명, 직급 명, 지역 명, 국가 명, 급여 등급 조회 
-- * 오라클 구문
SELECT EMP_ID 사번, EMP_NAME "사원 명", DEPT_TITLE "부서 명", JOB_NAME "직급 명", LOCAL_NAME "지역 명", NATIONAL_NAME "국가 명", SAL_LEVEL "급여 등급"
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L, NATIONAL N, SAL_GRADE S
WHERE 
DEPT_CODE = DEPT_ID AND 
E.JOB_CODE = J.JOB_CODE AND
LOCATION_ID = LOCAL_CODE AND
L.NATIONAL_CODE = N.NATIONAL_CODE AND
SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- * ANSI 구문
SELECT EMP_ID 사번, EMP_NAME "사원 명", DEPT_TITLE "부서 명", JOB_NAME "직급 명", LOCAL_NAME "지역 명", NATIONAL_NAME "국가 명", SAL_LEVEL "급여 등급"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID 
JOIN JOB USING (JOB_CODE)
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
JOIN NATIONAL USING (NATIONAL_CODE)
JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND MAX_SAL;




