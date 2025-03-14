-- KH_연습문제
-- 1. 2025년 12월 25일의 요일 조회
SELECT TO_CHAR(TO_DATE('251225', 'YYMMDD'), 'DAY') FROM DUAL;

-- 2. 70년대 생(1970~1979) 중 여자이면서 전씨인 사원의 이름과, 주민번호, 부서명, 직급 조회
-- 조건 : 70 ~ 79, 여자, 전씨
-- 컬럼 : 이름과, 주민번호, 부서명, 직급 조회
SELECT EMP_NAME 이름, EMP_NO 주민번호, DEPT_TITLE 부서명, JOB_NAME 직급
FROM EMPLOYEE E, DEPARTMENT, JOB J 
WHERE 
    DEPT_CODE = DEPT_ID 
    AND E.JOB_CODE = J.JOB_CODE
    AND SUBSTR(EMP_NO, 1, 2) BETWEEN 70 AND 79
    AND SUBSTR(EMP_NO, 8, 1) IN ('2', '4')
    AND EMP_NAME LIKE '전%';
      
-- 3. 가장 막내의 사원 코드, 사원 명, 나이, 부서 명, 직급 명 조회
-- 조건 : 가장 막내, 
-- 1. 주민번호 생년월일 추출 후 날짜 타입으로 변경 
-- SYSDATE 사용하여 나이 계산 후 최소 값 비교 
-- 결과 : 사원 코드, 사원 명, 나이, 부서 명, 직급 명 
SELECT 
    EMP_ID "사원 코드", EMP_NAME "사원 명", 
    SUBSTR(EXTRACT(YEAR FROM SYSDATE) - SUBSTR(EMP_NO, 1, 2), 3, 2) 나이,
    DEPT_TITLE "부서 명", JOB_NAME "직급 명"
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB USING (JOB_CODE)
WHERE 
    SUBSTR(EXTRACT(YEAR FROM SYSDATE) - SUBSTR(EMP_NO, 1, 2), 3, 2) 
        = (SELECT MIN(SUBSTR(EXTRACT(YEAR FROM SYSDATE) - SUBSTR(EMP_NO, 1, 2), 3, 2)) FROM EMPLOYEE);
        
-- 4. 이름에 ‘형’이 들어가는 사원의 사원 코드, 사원 명, 직급 조회
-- 조건 : 이름에 '형'
-- 결과 : 사원 코드, 사원 명, 직급
SELECT EMP_ID "사원 코드", EMP_NAME "사원 명", DEPT_TITLE "직급" 
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID AND EMP_NAME LIKE '%형%'; 
 
-- 5. 부서 코드가 D5이거나 D6인 사원의 사원 명, 직급, 부서 코드, 부서 명 조회
-- 조건 : 'D5' 'D6' 부서 사원
-- 결과 : 사원 명, 직급, 부서 코드, 부서명
SELECT EMP_NAME "사원 명", JOB_NAME 직급, DEPT_CODE "부서 코드", DEPT_TITLE "부서 명" 
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB USING (JOB_CODE)
WHERE DEPT_CODE IN ('D5', 'D6');
 
-- 6. 보너스를 받는 사원의 사원 명, 보너스, 부서 명, 지역 명 조회
-- 조건 : 보너스가 NULL이 아닌 사원
-- 결과 : 사원 명, 보너스, 부서 명, 지역 명
SELECT EMP_NAME "사원 명", BONUS 보너스, DEPT_TITLE "부서 명", LOCAL_NAME "지역 명"
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE BONUS IS NOT NULL;

-- 7. 사원 명, 직급, 부서 명, 지역 명 조회
SELECT EMP_NAME "사원 명", JOB_NAME "직급", DEPT_TITLE "부서 명", LOCAL_NAME "지역 명"
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB USING (JOB_CODE)
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;
 
-- 8. 한국이나 일본에서 근무 중인 사원의 사원 명, 부서 명, 지역 명, 국가 명 조회 
-- 조건 : 한국 또는 일본 지역 근무
-- 결과 : 사원 명, 부서 명, 지역 명, 국가 명
-- EMPLOYEE, DEPARTMENT, LOCATION, NATIONAL
SELECT *
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
    JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_CODE IN ('KO', 'JP')
ORDER BY NATIONAL_CODE DESC;

-- 9. 한 사원과 같은 부서에서 일하는 사원의 이름 조회
-- 조건 : 같은 부서
-- 결과 : 사원 이름
SELECT EMP_NAME 이름, DEPT_CODE "부서 코드"
FROM EMPLOYEE A, EMPLOYEE B WHERE A.DEPT_CODE = B.DEPT_CODE;
 
-- 10. 보너스가 없고 직급 코드가 J4이거나 J7인 사원의 이름, 직급, 급여 조회 (NVL 이용)
-- 조건 : 보너스가 NULL이고 직급 코드 'J4', 'J7'
-- 결과 : 이름 직급 급여 
SELECT EMP_NAME 이름, JOB_NAME 직급, NVL(BONUS, SALARY) 급여
FROM EMPLOYEE JOIN JOB USING (JOB_CODE) WHERE JOB_CODE IN ('J4', 'J7');
 
-- 11. 퇴사 하지 않은 사람과 퇴사한 사람의 수 조회
-- 조건 : ENT_DATE NULL 여부
-- 결과 : 퇴사하지 않은 사람, 퇴사한 사람 COUNT 
SELECT COUNT(ENT_DATE), COUNT(DECODE(ENT_DATE, NULL, 1, 'N', NULL)) FROM EMPLOYEE;
 
-- 12. 보너스 포함한 연봉이 높은 5명의 사번, 이름, 부서 명, 직급, 입사일, 순위 조회
-- 조건 : 보너스 포함 연봉 TOP 5
-- 결과 : 사번, 이름, 부서 명, 직급, 입사일, 순위 
SELECT *
FROM (
    SELECT 
        EMP_ID 사번, EMP_NAME 이름, DEPT_TITLE "부서 명", JOB_NAME 직급, HIRE_DATE 입사일,
        RANK() OVER(ORDER BY (SALARY + (SALARY * NVL(BONUS, 0))) * 12 DESC) 순위
    FROM EMPLOYEE 
        JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
        JOIN JOB USING (JOB_CODE)
)
WHERE 순위 <= 5;

-- 13. 부서 별 급여 합계가 전체 급여 총 합의 20%보다 많은 부서의 부서 명, 부서 별 급여 합계 조회
-- 조건 : 부서 별 급여 합계 > 급여 총 합 * 0.2 의 부서
-- 결과 : 부서 명, 부서 별 급여 합 

--	13-1. JOIN과 HAVING 사용
SELECT DEPT_TITLE "부서 명", SUM(SALARY) "부서 별 급여 합"
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
GROUP BY DEPT_TITLE HAVING SUM(SALARY) > (SELECT SUM(SALARY) * 0.2 FROM EMPLOYEE);
                      
--	13-2. 인라인 뷰 사용
-- BOTTOM-UP 방식으로 접근해서 다시 고민
-- HAVING 절에서 단일행 서브쿼리에 인라인 뷰를 사용하는 방법






--FROM (
--    SELECT DEPT_TITLE, SUM(SALARY) "부서 별 급여 합"
--    FROM DEPARTMENT
--    JOIN EMPLOYEE ON DEPT_CODE = DEPT_ID
--    GROUP BY DEPT_TITLE HAVING SUM(SALARY) > (SELECT SUM(SALARY)  FROM EMPLOYEE) * 0.2
--);

--	13-3. WITH 사용


-- 14. 부서 명과 부서 별 급여 합계 조회
-- 조건 : 부서 별 급여 합계
-- 결과 : 부서 명, 급여 합계

SELECT DEPT_TITLE "부서 명", SUM(SALARY) "부서 별 급여 합계"
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
GROUP BY DEPT_TITLE;







