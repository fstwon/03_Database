/*
	오라클(DB)에는 다양한 객체들이 있다.
	다음은 어떤 객체에 대한 설명인가? 해당 객체의 구문도 작성해보자.
	
	* VIEW : 테이블과 다르게 물리적으로 데이터를 저장하지 않으며,
						   기존 테이블의 특정 컬럼이나 조건을 적용하여 데이터를 볼 수 있다.
    [생성문]
    CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW 뷰명 AS (SUBQUERY) [WITH CHECK OPTION] [WITH READ ONLY];
						   
	* SEQUENCE : 자동 증가 값을 생성하는 객체. 주로 기본 키 관리 시 사용.
	[생성문] 
    CREATE SEQUENCE 시퀀스명 
    [START WITH 시작값] [INCREMENT BY 증가값] [MAXVALUE 최대값] [MINVALUE 최소값] [CYCLE | NOCYCLE] [CACHE | NOCACHE]
    
    현재 시퀀스 값 확인(NEXTVAL이 마지막으로 성공한 값) : 시퀀스명.CURRVAL
    현재 시퀀스 값 + 증가값 : 시퀀스명.NEXTVAL
    
	* TRIGGER : 특정 이벤트 발생 시 자동으로 실행되도록 설정한 객체.
    [생성문]
    CREATE TRIGGER 트리거명 BEFORE|AFTER INSERT | UPDATE | DELETE ON 테이블명 
    [FOR EACH ROW] [DECLARE] BEGIN [EXCEPTION] END;/
	
	* USER : 테이블, 뷰, 시퀀스 등의 객체를 소유할 수 있는 객체. 특정 권한을 부여 받아 다른 객체에 접근할 수 있음.
    [생성문]
    CREATE USER [C##]유저명 IDENTIFIED BY 패스워드
    
    GRANT 권한 TO [C##]유저명
    최소 권한 : CONNECT, RESOURCE;
*/
-- * ---------------------------------------------------------------------- * --
/*
    * 사수의 사번을 입력받아 해당 사원의 사번, 이름을 출력
      - 사번 : XXX
      - 이름 : XXX
      
      단, 조회된 결과가 없을 경우 '입력한 사수 사번을 가진 사원이 없습니다.' 출력
      조회된 결과가 많을 경우 '해당 사수에 대한 사원이 많습니다.' 출력
      그 외의 예외 발생 시 '오류가 발생했습니다. 관리자에게 문의하세요.' 출력
*/
SET SERVEROUTPUT ON;

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN 
    SELECT EMP_ID, EMP_NAME INTO EID, ENAME FROM EMPLOYEE WHERE MANAGER_ID = &사수사번;
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('입력한 사수 사번을 가진 사원이 없습니다.');
        WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('해당 사수에 대한 사원이 많습니다.');
        WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('오류가 발생했습니다. 관리자에게 문의하세요.');
END;
/























