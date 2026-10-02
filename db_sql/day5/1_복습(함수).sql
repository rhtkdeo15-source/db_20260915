-- ROUND(반올림), CELL(올림), FLOOR(내림), TRUNC(날림) -- 숫자함수
SELECT TRUNC(AVG(SAL), 1)
FROM EMP;

-- || => 문자열 이어붙히기
SELECT STU_GRADE || '학년'
FROM STUDENT;

-- LENGTH => 문자열 길이 ,SUBSTR => 문자열 자르기(첫번째 자리 => 몇번째, 두번쨰 자리 => 몇개)
SELECT
    ENAME,
    LENGTH(ENAME),
    SUBSTR(ENAME, 3), SUBSTR(ENAME, 2, 2)
FROM EMP;

SELECT *
FROM STUDENT
WHERE SUBSTR(STU_NO, 3, 2) = '15';

SELECT
    SUBSTR(STU_NO, 3, 2) AS 학번,
    AVG(STU_HEIGHT)
FROM STUDENT
GROUP BY SUBSTR(STU_NO, 3, 2);

-- INSTR => 찾는 문자열 처음나오는 위치
SELECT 
    TEL, LENGTH(TEL), INSTR(TEL, '-'),
    SUBSTR(TEL, 1, INSTR(TEL, '-')) || '****'
FROM STU;

-- SYSDATE => 현재시간
SELECT 
    SYSDATE,
    TO_CHAR(SYSDATE, 'YYYY.MM.DD HH24:MI:SS')
FROM DUAL;

SELECT *
FROM EMP
WHERE TO_CHAR(HIREDATE, 'YY') = 81;

SELECT 
    TO_CHAR(HIREDATE, 'YY') AS 입사년도,
    AVG(SAL)
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YY');

-- 그룹함수
--AVG, MAX, MIN, COUNT, SUM
SELECT 
    MAX(STU_HEIGHT)
FROM STUDENT;

SELECT *
FROM STUDENT
WHERE STU_HEIGHT = (
    SELECT 
        MAX(STU_HEIGHT)
    FROM STUDENT
);
-- RANK 활용한 방법
SELECT
    S.*,
    RANK()OVER(ORDER BY STU_HEIGHT DESC) AS RANK
FROM STUDENT S
WHERE STU_HEIGHT IS NOT NULL;

SELECT *
FROM(
    SELECT
        S.*,
        RANK()OVER(ORDER BY STU_HEIGHT DESC) AS RANK
    FROM STUDENT S
    WHERE STU_HEIGHT IS NOT NULL
)WHERE RANK = 1;

-- 각 학과별 가장 큰 키
SELECT 
    STU_DEPT,
    MAX(STU_HEIGHT)
FROM STUDENT
GROUP BY STU_DEPT;

-- 학과별 가장 큰 키 학번, 이름, 키, 출력
-- RANK
SELECT *
FROM (
    SELECT S.*, RANK() OVER(PARTITION BY STU_DEPT ORDER BY STU_HEIGHT DESC) AS RANK
    FROM STUDENT S
    WHERE STU_HEIGHT IS NOT NULL
)WHERE RANK = 1;

-- 
SELECT *
FROM EMP
WHERE SAL + NVL(COMM, 0) >= 2500;

-- EMP테이블에서 COMM이 NULL이면 '정보없음'으로 출력
SELECT E.*, NVL(TO_CHAR(COMM), '정보없음')
FROM EMP E;

-- DECODE, CASE WHEN
SELECT 
    S.*, 
    DECODE(STU_GENDER, 'M', '남자', '여자'),
    DECODE(STU_GENDER, 'M', '남자', 'F', '여자', '알수없음')
FROM STUDENT S;

-- ENEOL테이블
-- 80점 이상 A, 60점이 상 B, 나머지 C
SELECT
    E.*,
    CASE 
        WHEN ENR_GRADE >= 80 THEN 'A'
        WHEN ENR_GRADE >= 60 THEN 'B'
        ELSE 'C'
    END AS 등급
FROM ENROL E;











