-- =================== 수업용 계정 접속 후 아래 내용 조회 =================== --
-- 러시아에서 근무중인 사원의 사번, 사원명, 부서명, 지역명, 국가명을 조회
/*
        211	전형돈	기술지원부	EU	러시아
        212	장쯔위	기술지원부	EU	러시아
        222	이태림	기술지원부	EU	러시아
*/
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE, NATIONAL_NAME
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
    JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '러시아';

-- 부서 별 보너스율이 가장 높은 사원의 부서명, 직급명, 이름, 보너스 조회 
/*
        인사관리부	대리	전지연	0.3
        해외영업1부	부장	심봉선	0.15
        해외영업2부	부장	유재식	0.2
        기술지원부	대리	이태림	0.35
        총무부	대표	선동일	0.3
*/
-- 가장 높은 보너스 조회
SELECT DEPT_TITLE, JOB_NAME, EMP_NAME, BONUS
FROM EMPLOYEE 
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB USING (JOB_CODE)
WHERE (DEPT_CODE, BONUS) IN
        (
            SELECT DEPT_CODE, MAX(BONUS)
            FROM EMPLOYEE
            GROUP BY DEPT_CODE
        );



-- 나이가 5살 차이나는 사원들의 정보 조회 
-- ( 사원A의 사번, 사원A의 이름, 사원A의 생년월일, 사원B의 사번, 사원B의 이름, 사원B의 생년월일 )
/*
        209	심봉선	750206	221	유하진	800808
        212	장쯔위	780923	211	전형돈	830807
        221	유하진	800808	214	방명수	856795
        211	전형돈	830807	215	대북혼	881130
*/
SELECT 
    A.EMP_ID, A.EMP_NAME, SUBSTR(A.EMP_NO, 1, 6), 
    B.EMP_ID, B.EMP_NAME, SUBSTR(B.EMP_NO, 1, 6)
FROM EMPLOYEE A, EMPLOYEE B
WHERE 
    ABS(TO_NUMBER('19' || SUBSTR(A.EMP_NO, 1, 2)) 
    - TO_NUMBER('19' || SUBSTR(B.EMP_NO, 1, 2))) = 5
    AND TO_NUMBER('19' || SUBSTR(A.EMP_NO, 1, 2)) < TO_NUMBER('19' || SUBSTR(B.EMP_NO, 1, 2));
