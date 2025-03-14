-- "노옹철" 사원과 같은 부서에 속한 사원 정보 조회 

-- 1) "노옹철" 사원 부서 코드 조회
SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '노옹철';

-- 2) 부서 코드가 'D9' 사원 정보 조회
SELECT * FROM EMPLOYEE WHERE DEPT_CODE = 'D9';

-- 3) 1, 2 쿼리문 합치기
SELECT * FROM EMPLOYEE 
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '노옹철');

-- 전체 사원의 평균 급여보다 더 많은 급여를 받는 사원의 정보 조회
-- 1) 평균 급여 조회 
SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE;

-- 2) 평균 급여보다 더 많은 급여를 받는 사원 정보 조회 
SELECT * FROM EMPLOYEE WHERE SALARY > 3047663;

-- 3) SUBQUERY 적용
SELECT * FROM EMPLOYEE WHERE SALARY > (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE);
--------------------------------------------------------------------------------
-- * 단일행 SUBQUERY
-- 전 사원의 평균 급여보다 더 적게 급여를 받는 사원의 사원명, 직급 코드, 급여 조회 
SELECT EMP_NAME 사원명, JOB_CODE 직급코드, SALARY 급여 FROM EMPLOYEE
WHERE SALARY < (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE);

-- 가장 급여가 적은 사원의 사원명, 직급코드, 급여 조회 
SELECT EMP_NAME 사원명, JOB_CODE 직급코드, SALARY 급여 FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

-- "노옹철" 사원의 급여 보다 많이 받는 사원의 사원명, 부서코드, 급여 조회 
SELECT EMP_NAME 사원명, DEPT_CODE 부서코드, SALARY 급여 FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '노옹철');

-- 부서 코드를 부서명으로 조회
-- * 오라클 구문
SELECT EMP_NAME 사원명, DEPT_TITLE 부서코드, SALARY 급여 FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '노옹철');

-- * ANSI 구문
SELECT EMP_NAME 사원명, DEPT_TITLE 부서코드, SALARY 급여 
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE SALARY > (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '노옹철');

-- 부서 별 급여 합이 가장 큰 부서의 부서 코드, 급여 합 조회
SELECT DEPT_CODE 부서코드, SUM(SALARY) 
FROM EMPLOYEE
GROUP BY DEPT_CODE 
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY)) FROM EMPLOYEE GROUP BY DEPT_CODE);

-- "전지연" 사원과 같은 부서 사원의 사번, 사원명, 연락처, 입사일, 부서명 조회 
-- 단, "전지연" 사원은 제외
-- * 오라클 구문
SELECT EMP_ID 사번, EMP_NAME 사원명, PHONE 연락처, HIRE_DATE 입사일, DEPT_TITLE 부서명
FROM EMPLOYEE, DEPARTMENT 
WHERE 
    DEPT_CODE = DEPT_ID 
    AND DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '전지연')
    AND EMP_NAME <> '전지연';
    
-- * ANSI 구문
SELECT EMP_ID 사번, EMP_NAME 사원명, PHONE 연락처, HIRE_DATE 입사일, DEPT_TITLE 부서명
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE 
    DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '전지연')
    AND EMP_NAME <> '전지연';
--------------------------------------------------------------------------------
-- * 다중행 SUBQUERY
-- "유재식" 사원 또는 "윤은해" 사원과 같은 직급인 사원의 정보 조회 
-- (사번/사원명/직급코드/급여)

-- 1)
SELECT JOB_CODE 직급코드 FROM EMPLOYEE
WHERE EMP_NAME IN ('유재식', '윤은해');
-- WHERE EMP_NAME = '유재식' OR EMP_NAME = '윤은해';
-- 2)
SELECT EMP_ID 사번, EMP_NAME 사원명, JOB_CODE 직급코드, SALARY 급여 FROM EMPLOYEE
WHERE JOB_CODE IN ('J3', 'J7');

-- 3) 1, 2 SUBQUERY 적용 
SELECT EMP_ID 사번, EMP_NAME 사원명, JOB_CODE 직급코드, SALARY 급여 FROM EMPLOYEE
WHERE JOB_CODE IN (
    SELECT JOB_CODE 직급코드 FROM EMPLOYEE
        WHERE EMP_NAME IN ('유재식', '윤은해')
);

-- 대리 직급 사원 중 과장 직급의 최소 급여보다 많이 받는 사원 정보 조회 
-- (사번, 이름, 직급명, 급여)
-- 1) 과장 직급의 급여 조회 
SELECT SALARY FROM EMPLOYEE JOIN JOB USING (JOB_CODE) WHERE JOB_NAME = '과장';

-- 2) > ANY 연산자 사용하여 비교 
SELECT EMP_ID 사번, EMP_NAME 이름, JOB_NAME 직급명, SALARY 급여 
FROM EMPLOYEE JOIN JOB USING (JOB_CODE)
WHERE SALARY > ANY (
        SELECT SALARY FROM EMPLOYEE JOIN JOB USING (JOB_CODE) 
        WHERE JOB_NAME = '과장'
    )
    AND JOB_NAME = '대리';
--------------------------------------------------------------------------------
-- * 다중열 SUBQUERY

-- "하이유" 사원과 같은 부서, 같은 직급인 사원 정보 조회 
-- 1) "하이유" 사원의 부서 코드, 직급 코드 조회 
SELECT DEPT_CODE 부서코드, JOB_CODE 직급코드 FROM EMPLOYEE
WHERE EMP_NAME = '하이유';

-- 단일행 SUBQUERY 사용
SELECT EMP_NAME 이름, DEPT_CODE 부서코드, JOB_CODE 직급코드, SALARY 급여
FROM EMPLOYEE 
WHERE 
    DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '하이유')
    AND JOB_CODE = (SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '하이유');

-- 2) 부서코드가 'D5', 직급코드가 'J5' 인 사원 정보 조회 
SELECT EMP_NAME 이름, DEPT_CODE 부서코드, JOB_CODE 직급코드, SALARY 급여
FROM EMPLOYEE 
WHERE 
    (DEPT_CODE, JOB_CODE) = 
        (SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '하이유');

-- "박나라" 사원과 직급이 같고, 사수가 동일한 사원의 사원명, 직급코드, 사수번호 조회 
-- 1) "박나라" 직급코드 조회 
SELECT JOB_CODE, MANAGER_ID FROM EMPLOYEE WHERE EMP_NAME = '박나라';

-- 2) JOB_CODE가 같고 사수가 동일한 사원 조회 
SELECT EMP_NAME 사원명, JOB_CODE 직급코드, MANAGER_ID 사수번호 FROM EMPLOYEE
WHERE 
    (JOB_CODE, MANAGER_ID) = 
        (SELECT JOB_CODE, MANAGER_ID FROM EMPLOYEE WHERE EMP_NAME = '박나라')
    AND EMP_NAME <> '박나라';

-- * 다중행 다중열 SUBQUERY 
-- 각 직급 별 최소 급여를 받는 사원 정보를 조회 (사번, 이름, 직급코드, 급여)
-- 1) 직급 별 최소 급여 조회 
SELECT JOB_CODE, MIN(SALARY) FROM EMPLOYEE GROUP BY JOB_CODE;

-- 2) 각 직급 별 최소 급여를 받는 사원 정보 조회 
SELECT EMP_ID 사번, EMP_NAME 이름, JOB_CODE 직급코드, SALARY 급여 FROM EMPLOYEE
WHERE 
    JOB_CODE = 'J1' AND SALARY = 8000000
    OR JOB_CODE = 'J2' AND SALARY = 3700000
    OR JOB_CODE = 'J3' AND SALARY = 3400000
    OR JOB_CODE = 'J4' AND SALARY = 1550000
    OR JOB_CODE = 'J5' AND SALARY = 2200000
    OR JOB_CODE = 'J6' AND SALARY = 2000000
    OR JOB_CODE = 'J7' AND SALARY = 1380000;

-- SUBQUERY 적용
SELECT EMP_ID 사번, EMP_NAME 이름, JOB_CODE 직급코드, SALARY 급여 FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, MIN(SALARY) FROM EMPLOYEE GROUP BY JOB_CODE);
--------------------------------------------------------------------------------
-- 사번, 이름, 보너스 포함 연봉, 부서코드 조회 
-- 단, 보너스 포함 연봉 결과가 NULL이 아니고
-- 보너스 포함 연봉이 3000만원 이상인 사원 조회
SELECT EMP_ID 사번, EMP_NAME 이름, (SALARY + (SALARY * NVL(BONUS, 0))) * 12 "보너스 포함 연봉"
FROM EMPLOYEE
WHERE (SALARY * NVL(BONUS, 0)) * 12 >= 3000000;

SELECT 사번, 이름, "보너스 포함 연봉", DEPT_CODE
FROM (
    SELECT EMP_ID, EMP_NAME, (SALARY + (SALARY * NVL(BONUS, 0))) * 12, DEPT_CODE
    FROM EMPLOYEE
    WHERE (SALARY * NVL(BONUS, 0)) * 12 >= 3000000
    ORDER BY 3 DESC
);

-- 상위 N개를 조회 : "TOP-N분석"
-- => ROWNUM : 조회된 행에 대하여 순서대로 1부터 순번을 부여해주는 가상 컬럼

SELECT ROWNUM, EMP_ID, EMP_NAME, "보너스 포함 연봉", DEPT_CODE
FROM (
    SELECT EMP_ID, EMP_NAME, (SALARY + (SALARY * NVL(BONUS, 0))) * 12 "보너스 포함 연봉", DEPT_CODE
    FROM EMPLOYEE
    WHERE (SALARY * NVL(BONUS, 0)) * 12 >= 3000000
    ORDER BY 3 DESC
)
WHERE ROWNUM <= 5;

-- 가장 최근에 입사한 사원 5명 조회
SELECT ROWNUM, 사번, 이름, 입사일
FROM (
    SELECT EMP_ID 사번, EMP_NAME 이름, HIRE_DATE 입사일
    FROM EMPLOYEE
    ORDER BY HIRE_DATE DESC
)
WHERE ROWNUM <= 5;

SELECT 사번, 이름, 입사일
FROM (
    SELECT EMP_ID 사번, EMP_NAME 이름, HIRE_DATE 입사일
    FROM EMPLOYEE
    ORDER BY HIRE_DATE DESC
)
WHERE ROWNUM <= 5;

SELECT 사번, 이름, 입사일
FROM (
    SELECT ROWNUM R, EMP_ID 사번, EMP_NAME 이름, HIRE_DATE 입사일
    FROM EMPLOYEE
    ORDER BY HIRE_DATE DESC
)
WHERE R BETWEEN 1 AND 5;
--------------------------------------------------------------------------------
/* 
    * 순서를 매기는 함수
*/
-- 급여가 높은 순서대로 순위를 매겨서 조회 
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) 순위 FROM EMPLOYEE;
-- 공동 19위인 2명이 이 후 순위는 21위로 표시 

SELECT EMP_NAME, SALARY, DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위 FROM EMPLOYEE;
-- 공동 19위인 2명 이 후 순위는 20위로 표시

-- 상위 5명 조회
SELECT *
FROM (
    SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) 순위 FROM EMPLOYEE
)
WHERE 순위 <= 5;

-- 상위 3 ~ 5 조회 
SELECT *
FROM (
    SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) 순위 FROM EMPLOYEE
)
WHERE 순위 BETWEEN 3 AND 5;

--------------------------------------------------------------------------------
-- QUIZ
-- 1) ROWNUM을 활용하여 급여가 가장 높은 5명을 조회하려 했으나, 제대로 조회되지 않았다.
SELECT EMP_NAME, SALARY
FROM (
    SELECT EMP_NAME, SALARY
    FROM EMPLOYEE
    ORDER BY SALARY DESC
)
WHERE ROWNUM <= 5;

-- 문제점(원인) 
-- ROWNUM은 행을 제한하기 위해 행에 임시로 붙는 번호이고 정렬되기 이전에 부여된다. 
-- 따라서 ORDER BY에서 적용한 순서대로 부여되지 않는다.

-- 해결 방안
-- SUBQUERY의 INLINE VIEW를 사용하여 급여 순서로 먼저 정렬한 후 ROWNUM으로 제한한다. 

-- 2) 부서 별 평균 급여가 270만원을 초과하는 부서에 해당하는 
-- 부서코드, 부서 별 총 급여 합, 평균 급여, 사원 수를 조회하려 했으나, 제대로 조회되지 않았다.

-- 조건
-- 부서 별 평균 급여 조회
SELECT DEPT_CODE, FLOOR(AVG(SALARY)), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 평균 급여가 270만원을 초과하는 부서 조회
SELECT DEPT_CODE, FLOOR(AVG(SALARY)) 
FROM EMPLOYEE
GROUP BY DEPT_CODE HAVING FLOOR(AVG(SALARY)) > 2700000;

-- 부서코드, 부서 별 총 급여 합, 평균 급여, 사원 수 조회 
SELECT DEPT_CODE, SUM(SALARY), FLOOR(AVG(SALARY)), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE HAVING FLOOR(AVG(SALARY)) > 2700000;

-- 문제 쿼리
SELECT DEPT_CODE, SUM(SALARY) 총합, FLOOR(AVG(SALARY)) 평균, COUNT(*) "사원 수" 
FROM EMPLOYEE
WHERE SALARY > 2700000 -- 조건 잘못 사용
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- 문제점(원인) 
-- 실행 순서가 FROM, WHERE, GROUP BY, SELECT 순으로 진행되기 때문에 
-- 급여가 270만원을 초과하는 사원을 조회하고 해당 사원들의 데이터만 조회한다. 
-- WHERE 절은 그룹에 대한 조건이 아니라 컬럼을 조회하기 위한 조건이다. 
-- WHERE 절의 조건식도 SALARY가 아닌 FLOOR(AVG(SALARY)) > 2700000 으로 수정해야 한다.

-- 해결 방안 
-- 평균 급여를 우선 계산한 후 조건문이 적용되어야 한다. 
-- WHERE절의 조건을 그룹에 대한 조건으로 수정하여야 한다. 
SELECT DEPT_CODE 부서코드, SUM(SALARY) 총합, FLOOR(AVG(SALARY)) 평균, COUNT(*) "사원 수" 
FROM EMPLOYEE
GROUP BY DEPT_CODE HAVING FLOOR(AVG(SALARY)) > 2700000
ORDER BY DEPT_CODE;

SELECT *
FROM (
    SELECT DEPT_CODE 부서코드, SUM(SALARY) 총합, FLOOR(AVG(SALARY)) 평균, COUNT(*) "사원 수" 
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
    ORDER BY DEPT_CODE
)
WHERE 평균 > 2700000;

