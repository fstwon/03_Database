 /*
    * GROUP BY 절
    : 그룹 기준을 제시할 수 있는 구문
    다수의 데이터를 하나의 그룹으로 묶어 처리하는 목적으로 사용
 */
 -- 전체 사원의 총 급여 조회
 SELECT TO_CHAR(SUM(SALARY), 'L999,999,999') "총 급여" FROM EMPLOYEE;
 
 -- 부서 별 총 급여
 SELECT DEPT_CODE, TO_CHAR(SUM(SALARY), 'L999,999,999') "부서 별 총 급여" FROM EMPLOYEE GROUP BY DEPT_CODE;
 
 -- 부서 별 사원 수
 SELECT DEPT_CODE, COUNT(*) FROM EMPLOYEE GROUP BY DEPT_CODE;
 
 -- 부서 코드가 D1, D6, D9의 각 부서 별 급여 총합, 사원 수 조회
 SELECT DEPT_CODE 부서, COUNT(*) "사원 수", SUM(SALARY) "급여 총합" FROM EMPLOYEE WHERE DEPT_CODE IN ('D1', 'D6', 'D9') GROUP BY DEPT_CODE ORDER BY DEPT_CODE ASC;
 
 -- 각 직급 별 총 사원 수, 보너스를 받는 사원 수, 급여 합, 평균 급여, 최저 급여, 최고 급여 조회
 -- (단, 직급 코드 오름차순으로 정렬)
 SELECT 
    JOB_CODE 직급, 
    COUNT(*) "직급 별 사원 수", 
    COUNT(BONUS) "보너스를 받는 사원 수", 
    SUM(SALARY) "급여 합", 
    MIN(SALARY) "최저 급여", 
    MAX(SALARY) "최고 급여"
FROM EMPLOYEE
GROUP BY JOB_CODE ORDER BY JOB_CODE;

-- 남자 사원 수, 여자 사원 수 조회
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') 성별, COUNT(*) "사원 수" FROM EMPLOYEE GROUP BY SUBSTR(EMP_NO, 8, 1);

-- 부서 내 직급 별 사원 수, 급여 총 합 조회 
SELECT DEPT_CODE 부서코드, JOB_CODE 직급코드, COUNT(*) "사원 수", SUM(SALARY) "급여 총 합" FROM EMPLOYEE GROUP BY DEPT_CODE, JOB_CODE ORDER BY DEPT_CODE;

--------------------------------------------------------------------------------

/*
    * HAVING 절
    : 그룹에 대한 조건을 제시할 때 사용하는 구문
    그룹 함수식을 사용하여 조건 작성
*/
-- 부서 별 평균 급여 조회
SELECT DEPT_CODE 부서코드, ROUND(AVG(SALARY)) "평균 급여" FROM EMPLOYEE GROUP BY DEPT_CODE;

-- 각 부서 별 평균 급여가 300만원 이상인 부서만 조회
SELECT DEPT_CODE 부서코드, ROUND(AVG(SALARY)) "평균 급여" 
FROM EMPLOYEE 
GROUP BY DEPT_CODE HAVING ROUND(AVG(SALARY)) >= 3000000;

-- 부서 별 보너스를 받는 사원이 없는 부서의 부서 코드 조회 
SELECT DEPT_CODE 부서코드 FROM EMPLOYEE GROUP BY DEPT_CODE HAVING COUNT(BONUS) = 0;
--------------------------------------------------------------------------------
/*
    * ROLLUP, CUBE : 그룹 별 산출 결과 값의 집계를 계산하는 함수
    
    - ROLLUP : 전달 받은 그룹 중 가장 먼저 지정한 그룹 별로 추가적 집계 결과 반환
    - CUBE : 전달 받은 그룹들로 가능한 모든 조합 별 집계 결과 반환
*/
-- 각 부서 별 부서 내 직급 별 급여 합, 부서 별 급여 합, 전체 직원 급여 총 합 조회 
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
-- GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
-- GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1;
--------------------------------------------------------------------------------
/*
    * 실행 순서
    
    SELECT 조회컬럼 AS "별칭" 또는 * 또는 함수식, 연산식
    FROM 조회테이블 또는 DUAL(임시 테이블)
    WHERE 조건식(연산자를 활용하여 작성)
    GROUP BY 그룹화 기준 컬럼 또는 함수식
    HAVING 조건식 (그룹화 함수를 활용하여 작성)
    ORDER BY 컬럼 또는 별칭 또는 컬럼 순번 [ASC | DESC] [NULLS LAST | NULLS FIRST]
*/
--------------------------------------------------------------------------------
/*
    * 집합 연산자 : 여러 개의 명령문(SQL/QUERY)을 하나의 명령문으로 만드는 연산자
    - UNION : 합집합 (두 명령문을 수행한 결과 셋을 더한다) -> OR 연산자와 유사
    - INTERSECT : 교집합 (두 명령문을 수행한 결과 셋의 중복 부분 추출) -> AND 연산자와 유사
    - UNION ALL : 합집합 + 교집합 (중복되는 부분이 두번 조회될 수 있다)
    - MINUS : 차집합 (선행 결과에서 후행 결과를 뺀 나머지)
*/

-- UNION
-- 부서 코드가 'D5'인 사원 또는 급여가 300만원을 초과하는 사원의 사번, 이름, 부서 코드, 급여 조회
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서코드, SALARY 급여 FROM EMPLOYEE WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

-- 부서 코드가 'D5'인 사원의 사번, 이름, 부서코드, 급여 조회 
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서코드, SALARY 급여 FROM EMPLOYEE WHERE DEPT_CODE = 'D5';
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서코드, SALARY 급여 FROM EMPLOYEE WHERE SALARY > 3000000;

-- UNION 연산자로 2개의 쿼리문 합치기
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서코드, SALARY 급여 FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서코드, SALARY 급여 FROM EMPLOYEE WHERE SALARY > 3000000;
--------------------------------------------------------------------------------
-- INTERSECT
-- 부서 코드가 'D5'이고 급여가 300만원 초과인 사번, 이름, 부서코드, 급여 조회 
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서코드, SALARY 급여 FROM EMPLOYEE WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;

SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서코드, SALARY 급여 FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서코드, SALARY 급여 FROM EMPLOYEE WHERE SALARY > 3000000;
--------------------------------------------------------------------------------
-- UNION ALL
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서코드, SALARY 급여 FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서코드, SALARY 급여 FROM EMPLOYEE WHERE SALARY > 3000000;
--------------------------------------------------------------------------------
-- MINUS
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서코드, SALARY 급여 FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서코드, SALARY 급여 FROM EMPLOYEE WHERE SALARY > 3000000;
--------------------------------------------------------------------------------
/*
    * 집합 연산자 사용 시 주의 사항 
    1. 명령문들의 컬럼 개수가 동일해야 한다. 
    2. 컬럼 자리마다 동일한 데이터 타입으로 작성해야 한다. 
    3. 정렬이 필요한 경우 ORDER BY절의 위치는 마지막에 작성해야 한다. 
*/
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서코드, SALARY 급여 FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION
SELECT EMP_ID 사번, EMP_NAME 이름, DEPT_CODE 부서코드, SALARY 급여 FROM EMPLOYEE WHERE SALARY > 3000000
ORDER BY EMP_ID;












