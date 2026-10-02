-- 1. EMP 테이블에서 급여(SAL)가 3000이상인 사원의 사번, 이름, 급여를 출력하시오
SELECT * FROM EMP
WHERE SAL > 3000;
-- 2. TBL_EMP 테이블에 데이터를 삽입, 수정, 삭제하시오. 
-- 조건 1. 데이터 삽입 시 들어갈 내용은 자유롭게 정의하되, manager_id 컬럼은 테이블의 연관성을 고려하여 삽입한다. (NULL 금지)
-- 조건 2. 조건 1에서 삽입한 직원의 급여 정보를 10%로 증가한다. 
-- 조건 3. 조건 1에서 삽입한 직원을 PK를 조건으로 삭제 한다.
SELECT * FROM TBL_EMP;
INSERT INTO TBL_EMP 
VALUES('E1008', '홍길동', '인턴', 'E1004', SYSDATE, 3000000, 'D03'); -- 조건 1
UPDATE TBL_EMP SET
    SALARY = SALARY + 300000
WHERE EMP_ID = 'E1008'; -- 조건 2
DELETE FROM TBL_EMP WHERE EMP_ID = 'E1008'; -- 조건3
-- 3. 시험 점수가 80점 이상이면 'A', 70점 이상이면 'B', 60점 이상이면 'C', 그외는 '노력요망' 으로 출력하시오. 
-- 사용테이블 : ENROL
-- 출력 컬럼 : 학생번호, 평가정보
SELECT
    E.STU_NO,
    CASE 
        WHEN ENR_GRADE >= 80 THEN 'A'
        WHEN ENR_GRADE >= 60 THEN 'B'
        ELSE '노력요망'
    END AS 평가정보
FROM ENROL E;
-- 4. PROFESSOR테이블에서 직급(POSITION)이 '정교수'인 데이터의 수를 구하시오.
SELECT 
    POSITION,COUNT(*)
FROM PROFESSOR
WHERE POSITION = '정교수'
GROUP BY POSITION;
-- 5. PROFESSOR테이블에서 EMAIL컬럼 내용 중 아이디(@이전 값들)만 추출하여 출력하시오.
SELECT * FROM PROFESSOR;
SELECT
    EMAIL,
    INSTR(EMAIL, '@'),
    SUBSTR(EMAIL, 1, INSTR(EMAIL, '@') -1)
FROM PROFESSOR;
-- 6. PROFESSOR테이블에서 월별 입사한 사람의 수를 구하시오.
-- 출력 : 월, 입사한 사람 수
SELECT 
    TO_CHAR(HIREDATE,'MM'),COUNT(TO_CHAR(HIREDATE,'YY-MM-DD'))
FROM PROFESSOR P
GROUP BY TO_CHAR(HIREDATE,'MM');

-- 7. 조인 - 2문제 (STU, PROFESSOR, DEPARTMENT)
SELECT * FROM STU;
SELECT * FROM PROFESSOR;
SELECT * FROM DEPARTMENT;
-- 7-1) 컴퓨터공학과에 속한 교수의 교수번호, 이름, 직급, 학과명을 출력하시오.
SELECT 
    PROFNO, P.NAME, D1.DNAME, D2.DNAME, D3.DNAME
FROM PROFESSOR P
INNER JOIN DEPARTMENT D1 ON P.DEPTNO = D1.DEPTNO
INNER JOIN DEPARTMENT D2 ON D1.PART = D2.DEPTNO
INNER JOIN DEPARTMENT D3 ON D2.PART = D3.DEPTNO
WHERE D1.DNAME = '컴퓨터공학과';
-- 7-2) 학생들의 학번, 이름, 부전공명을 출력하시오. 단, 부전공이 없으면 '해당없음' 으로 출력하시오.
SELECT 
    STUNO, NAME, NVL(D2.DNAME, '부전공없음')
FROM STU S
INNER JOIN DEPARTMENT D1 ON S.DEPTNO1 = D1.DEPTNO
LEFT JOIN DEPARTMENT D2 ON S.DEPTNO2 = D2.DEPTNO;
-- 8. 셀프조인 
SELECT * FROM EMP;
-- emp 테이블에서 부하직원(본인을 MGR로 가지고 있는 사원)이 1명도 없는 사원의 사번, 이름을 출력하시오.
SELECT E2.ENAME, COUNT(*)
FROM EMP E1
INNER JOIN EMP E2 ON E1.MGR = E2.EMPNO
WHERE E1.EMPNO IS NOT NULL
GROUP BY E2.ENAME;
-- 9. PROFESSOR테이블에서 보너스가 높은 순으로 출력하시오. 단, 보너스가 없을 경우 '없음'으로 출력하시오.
-- 출력 : 교수번호, 이름, 급여, 보너스 
-- 보너스가 없을 경우 제일 마지막에 출력
SELECT * FROM PROFESSOR;
SELECT 
    PROFNO, NAME, PAY, NVL(TO_CHAR(BONUS), '없음')
FROM PROFESSOR
ORDER BY NVL(TO_CHAR(BONUS), '정보없음') ASC;
-- 10. (TBL_EMP, TBL_DEPT) 각 부서의 부서아이디, 부서이름, 지역, 부서장 이름, 부서에 속한 사원의 수를 출력하시오.
SELECT * FROM TBL_EMP;
SELECT * FROM TBL_DEPT;
SELECT 
    E.DEPT_ID, D.DEPT_NAME, LOCATION, EMP_NAME, COT
FROM TBL_EMP E
INNER JOIN (
    SELECT 
    D.DEPT_ID, 
    COUNT(*) AS COT
FROM TBL_DEPT D 
INNER JOIN TBL_EMP E ON D.DEPT_ID = E.DEPT_ID
GROUP BY D.DEPT_ID
)T ON E.DEPT_ID = T.DEPT_ID;
-- 11. (TBL_EMP, TBL_DEPT) 본인 부서에서 본인보다 높은 급여를 받는 사원의 수를 출력하시오.
-- 출력 : 사원아이디, 이름, 부서명, 본인 부서에서 본인보다 높은 급여를 받는 사원의 수
-- 없으면 0 출력
SELECT 
    D.DEPT_ID, 
    COUNT(*) AS COT
FROM TBL_DEPT D 
INNER JOIN TBL_EMP E ON D.DEPT_ID = E.DEPT_ID
GROUP BY D.DEPT_ID;

SELECT *
FROM TBL_DEPT D
INNER JOIN (
    SELECT 
        D.DEPT_ID, E.SALARY
    FROM TBL_DEPT D
    INNER JOIN TBL_EMP E ON D.DEPT_ID = E.DEPT_ID
    GROUP BY DEPT_ID ,E.SALARY
)T ON D.DEPT_ID = T.DEPT_ID;

-- 12. (신규 테이블 기준) 사원 아이디, 이름, 진행중인 프로젝트 명, 진행 부서명, 해당 프로젝트 투입 인원 수를 출력하시오.
-- 진행중인 프로젝트가 없으면 아이디, 이름 외에 다른 정보를 NULL로 출력하시오.
SELECT * FROM TBL_EMP;
SELECT * FROM TBL_DEPT;
SELECT * FROM TBL_PROJECT;
SELECT * FROM TBL_ASSIGNMENT;
-- 13. (신규 테이블 기준) 부서별 급여합산이 가장 높은 부서의 부서이름, 급여합산 결과를 출력하시오.
SELECT * FROM TBL_EMP;
SELECT * FROM TBL_DEPT;
SELECT * FROM TBL_PROJECT;
SELECT * FROM TBL_ASSIGNMENT;
-- 14. (SAL, SALGRADE) 급여등급이 3이상인 사람의 수와 3미만인 사람의 수를 구하시오.
SELECT * FROM EMP;
SELECT * FROM SALGRADE;
