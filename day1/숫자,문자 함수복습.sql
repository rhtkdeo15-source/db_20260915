SELECT * FROM STUDENT;
SELECT * FROM ENROL;
SELECT * FROM SUBJECT;

-- 숫자함수 - 소수점 처리하는 함수는 꼭알아둘것

--ROUND : 반올림
SELECT ROUND (12.345, 2)
FROM DUAL;

-- CEIL : 올림
SELECT CEIL (12.345)
FROM DUAL;

-- FLOOR : (내림)
SELECT FLOOR (12.345)
FROM DUAL;

-- TRUNC : (날림)
SELECT TRUNC (12.34567, 2)
FROM DUAL;

-- 문자함수
-- CONCAT : 문자열 이어 붙이기, || 로 대처해서 사용

-- 이름_학번 형태로 출력,옥한빛_20153075
SELECT * FROM STUDENT;
SELECT 
    CONCAT(CONCAT (STU_NAME,'_'), STU_NO) AS 이름_학번,
    STU_NAME || '_' || STU_NO "이름 학번2"
FROM STUDENT;

-- SUBSTR : 문자열 자르기
SELECT 
    STU_NO,
    SUBSTR(STU_NO, 5),
    SUBSTR(STU_NO, 2, 3)
FROM STUDENT;

SELECT
    STU_DEPT,
    LENGTH(STU_DEPT)
FROM STUDENT;

SELECT
    EMAIL,
    INSTR(EMAIL, '@')
FROM PROFESSOR;

-- LPAD, RPAD
SELECT 
    SUBSTR(STU_NAME, 1, 2) || '*'
FROM STUDENT;

SELECT
    ID,
    RPAD(ID, 10 ,'*'),
    SUBSTR(ID, 1, LENGTH(ID)-3),
    RPAD(SUBSTR(ID, 1, LENGTH(ID)-3), LENGTH(ID), '*')
FROM PROFESSOR;

-- 이름 마지막이 *로출력
SELECT 
    NAME,
    SUBSTR(NAME,1 ,2) || '*',
    SUBSTR(NAME, 1, LENGTH(NAME)-1),
    RPAD(SUBSTR(NAME, 1, LENGTH(NAME)-1), LENGTH(NAME), '*')
FROM PROFESSOR;











