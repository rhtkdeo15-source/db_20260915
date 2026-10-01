--1. 조건을 이용한 SELECT 조회 
-- STUDENT 테이블에서 컴퓨터정보 학과(STU_DEPT) 학생들을 모두 출력하시오.
-- 난이도 : 하
SELECT * FROM STUDENT
WHERE STU_DEPT = '컴퓨터정보';

--2. DML 명령어
--   2-1) EMP 테이블에 INSERT 구문을 이용하여 레코드 추가
SELECT * FROM EMP;
--	 (필수 컬럼 : EMPNO, ENAME, MGR, SAL) 
--   데이터는 임의의 값을 넣으면 되나, MGR의 경우 EMPNO와 MGR의 관계를 고려하여 값을 넣을 것.
INSERT INTO EMP
VALUES (1234,'ABCD','',1234,SYSDATE,500,'','');
--	 2-2) 2-1에서 만든 데이터의 SAL을 2000으로 변경
UPDATE EMP SET
    SAL = 2000
WHERE EMPNO = 1234;
--	 2-3) 2-1에서 만든 데이터를 EMPNO를 조건으로 삭제
DELETE EMP WHERE EMPNO = 1234;
-- 난이도 : 하
 
-- 3. 미공개

-- 4. 그룹 함수 (STUDENT)
-- STUDENT테이블에서 컴퓨터정보 학과(STU_DEPT) 학생들의 수를 구하시오.
-- 난이도 : 하
SELECT STU_DEPT,COUNT(*) 
FROM STUDENT
WHERE STU_DEPT = '컴퓨터정보'
GROUP BY STU_DEPT;
-- 5. 조인 - 2문제
-- 5-1) 컴퓨터정보 학과에 속한 교수의 수업을 듣는 학생들의 목록을 출력하시오. (STUDENT, ENROL, SUBJECT)
SELECT * FROM STUDENT;
SELECT * FROM ENROL;
SELECT * FROM SUBJECT;

SELECT * 
FROM STUDENT S
INNER JOIN ENROL E ON S.STU_NO = E.STU_NO
INNER JOIN SUBJECT SUB ON E.SUB_NO = SUB.SUB_NO
WHERE SUB_DEPT = '컴퓨터정보';
-- 5-2) EMP 테이블에 속한 사람들의 사번(EMPNO), 이름(ENAME), 급여등급을 출력하시오. (EMP, SALGRADE)
-- 난이도 : 중
SELECT * FROM EMP;
SELECT * FROM SALGRADE;

SELECT 
    E.EMPNO, E.ENAME, S.GRADE
FROM EMP E
INNER JOIN SALGRADE S ON E.SAL BETWEEN LOSAL AND HISAL;
-- 6. 셀프조인 
-- 부하직원(본인을 MGR로 가지고 있는 사원)이 가장 많은 사원의 사번, 이름, 부하직원 수를 출력하시오.
-- (EMP)
-- 난이도 : 중
SELECT 
     E2.EMPNO,E2.ENAME, COUNT(E2.EMPNO) AS EMP_COUNT
FROM EMP E1
INNER JOIN EMP E2 ON E1.MGR = E2.EMPNO
GROUP BY E2.EMPNO, E2.ENAME;

SELECT MAX(EMP_COUNT)
FROM (
   SELECT 
     E2.EMPNO,E2.ENAME, COUNT(E2.EMPNO) AS EMP_COUNT
FROM EMP E1
INNER JOIN EMP E2 ON E1.MGR = E2.EMPNO
GROUP BY E2.EMPNO, E2.ENAME 
);

-- 7. 2개의 수업을 들은 학생들의 평균점수와 1개의 수업을 들은 학생들의 평균점수를 구하시오.
-- (수업 개수, 평균 점수 출력)
-- (STUDENT, ENROL)
-- 난이도 : 중

-- 8. 본인 학과에서 본인보다 몸무게가 큰 학생의 수를 출력하시오. ( 학번, 이름, 학과, 큰 학생 수 출력 )
-- (STUDENT)
-- 난이도 : 중