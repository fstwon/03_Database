-- DDL

/*
    1. 계열 정보 저장 카테고리 테이블 생성 
    테이블 명 : TB_CATEGORY
    컬럼
        NAME VARCHAR2(10)
        USE_YN CHAR(1) DEFAULT 'Y'
*/
CREATE TABLE TB_CATEGORY (
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);

SELECT * FROM TB_CATEGORY;

/*
    2. 과목 구분 저장 테이블 생성
    테이블명 : TB_CLASS_TYPE
    컬럼
        NO VARCHAR2(5) PRIMARY KEY
        NAME VARCHAR(10)
*/

CREATE TABLE TB_CLASS_TYPE (
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

SELECT * FROM TB_CLASS_TYPE;

/*
    3. TB_CATEGORY 테이블의 NAME 컬럼에 PRIMARY KEY 생성
*/
ALTER TABLE TB_CATEGORY ADD PRIMARY KEY (NAME);
-- ALTER TABLE TB_CATEGORY ADD CONSTRAINT TB_CATEGORY_NAME_PK PRIMARY KEY (NAME);
-- ALTER TABLE TB_CATEGORY RENAME CONSTRAINT SYS_C008449 TO TB_CATEGORY_NMPK; 

/*
    4. TB_CLASS_TYPE 테이블 NAME 컬럼에 NULL 값이 들어가지 않도록 속성 변경
*/
ALTER TABLE TB_CLASS_TYPE MODIFY NAME NOT NULL;

/*
    5. TB_CATEGORY, TB_CLASS_TYPE 테이블의 NO 컬럼을 크기를 10으로 
    NAME은 크기를 20으로 변경
*/
-- ALTER TABLE TB_CATEGORY ADD NO VARCHAR2(10); -- NO 컬럼 추가
ALTER TABLE TB_CATEGORY MODIFY (NAME VARCHAR(20));
ALTER TABLE TB_CLASS_TYPE MODIFY (NAME VARCHAR(20));
ALTER TABLE TB_CLASS_TYPE MODIFY (NO VARCHAR(10));

/*
    6. TB_CATEGORY, TB_CLASS_TYPE 테이블의 NO 컬럼과 NAME 컬럼의 이름을 
    각 TB_를 제외한 테이블 이름을 앞에 붙여 변경한다. 
    (EX. CATEGORY_NAME)
*/
ALTER TABLE TB_CATEGORY RENAME COLUMN NO TO CATEGORY_NO;
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NO TO CLASS_TYPE_NO;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NAME TO CLASS_TYPE_NAME;

/*
    7. TB_CATEGORY, TB_CLASS_TYPE 테이블의 PK 이름을 'PK_칼럼명' 으로 변경
*/
ALTER TABLE TB_CATEGORY RENAME CONSTRAINT TB_CATEGORY_NMPK TO PK_CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME CONSTRAINT SYS_C008448 TO PK_CLASS_TPYE_NAME;

/*
    8. INSERT 문 수행
*/
ALTER TABLE TB_CATEGORY ADD CATEGORY_NO VARCHAR2(10);

INSERT INTO TB_CATEGORY VALUES ('공학', 'Y');
INSERT INTO TB_CATEGORY VALUES ('자연과학', 'Y');
INSERT INTO TB_CATEGORY VALUES ('의학', 'Y');
INSERT INTO TB_CATEGORY VALUES ('예체능', 'Y');
INSERT INTO TB_CATEGORY VALUES ('인문사회', 'Y');

/*
    9. TB_DEPARTMENT의 CATEGORY 컬럼이 TB_CATEGORY 테이블의 CATEGORY_NAME 컬럼을 
    부모 값으로 참조하도록 FOREIGN KEY 지정
    KEY 이름은 FK_테이블명_컬럼명
*/

ALTER TABLE TB_DEPARTMENT 
    ADD CONSTRAINT FK_DEPARTMENT_CATEGORY_NAME 
    FOREIGN KEY (CATEGORY) 
    REFERENCES TB_CATEGORY (CATEGORY_NAME);

/*
    10. 학생일반정보 VIEW 생성
    VW_학생일반정보
    
    학번
    학생이름
    주소
*/

-- 뷰 생성 권한 부여 
-- GRANT CREATE VIEW TO C##WORKBOOK;

CREATE VIEW VW_학생일반정보 
AS (SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS FROM TB_STUDENT);

/*
    11. 학생이름, 학과이름, 담당교수 이름으로 구성된 VIEW 생성
    STUDENT_NAME, DEPARTMENT_NAME, PROFESSOR_NAME
    TB_STUDENT, TB_DEAPRTMENT, TB_PROFESSOR
    DEPARTMENT_NO, COACH_PROFESSOR_NO = PROFESSOR_NO
    
    지도 교수가 없는 학생 고려
    SELECT 시 학과 별로 정렬
*/
CREATE OR REPLACE VIEW VW_지도면담
AS (
    SELECT STUDENT_NAME, DEPARTMENT_NAME, PROFESSOR_NAME
    FROM TB_STUDENT
        JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
        JOIN TB_PROFESSOR ON COACH_PROFESSOR_NO = PROFESSOR_NO
    WHERE COACH_PROFESSOR_NO IS NOT NULL
);

SELECT * FROM VW_지도면담 ORDER BY DEPARTMENT_NAME;

/*
    12. 모든 학과의 학과별 학생 수를 확인할 수 있는 VIEW 생성
    VW_학과별학생수
    DEPARTMENT_NAME
    STUDENT_COUNT
*/
CREATE VIEW VW_학과별학생수 
AS (
    SELECT DEPARTMENT_NAME, COUNT(*) STUDENT_COUNT
    FROM TB_STUDENT JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
    GROUP BY DEPARTMENT_NAME
);

SELECT * FROM VW_학과별학생수;

/*
    13. 학생일반정보 VIEW 를 통해 학번이 
    A213046 학생의 이름을 본인 이름으로 변경
*/
UPDATE VW_학생일반정보 SET STUDENT_NAME = '박영철' WHERE STUDENT_NO = 'A213046';

SELECT * FROM VW_학생일반정보 WHERE STUDENT_NAME = '박영철';

/*
    14. 13번에서 VIEW를 통해 데이터 변경하는 상황 방지
*/
CREATE OR REPLACE VIEW VW_학생일반정보 
AS (SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS FROM TB_STUDENT) 
WITH READ ONLY;

/*
    15. 최근 3년 기준 수강인원이 가장 많았던 3과목 찾는 구문
    CLASS_NO, CLASS_NAME, COUNT(*) WHERE SYSDATE - 3년
    TB_STUDENT, TB_DEPARTMENT, TB_CLASS
    09, 08, 07
*/
SELECT CLASS_NO, CLASS_NAME, COUNT(*) 
FROM TB_CLASS
    JOIN TB_GRADE USING (CLASS_NO)
WHERE TERM_NO LIKE '2005%' 
    OR TERM_NO LIKE '2006%'
    OR TERM_NO LIKE '2007%'
    OR TERM_NO LIKE '2008%'
    OR TERM_NO LIKE '2009%'
GROUP BY CLASS_NO, CLASS_NAME
ORDER BY 3 DESC;

-- 해당 과목의 학생 수
SELECT 과목번호, 과목이름, "누적수강생수(명)"
FROM (
    SELECT CLASS_NO 과목번호, CLASS_NAME 과목이름, COUNT(*) "누적수강생수(명)"
    FROM TB_GRADE
    JOIN TB_CLASS USING (CLASS_NO)
    WHERE SUBSTR(TERM_NO, 1, 4) IN (2009, 2008, 2007, 2006, 2005)
    GROUP BY CLASS_NO, CLASS_NAME
    ORDER BY 3 DESC)
WHERE ROWNUM <= 3;









