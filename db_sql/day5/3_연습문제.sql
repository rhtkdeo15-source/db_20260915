SELECT * FROM TBL_EMP; -- 1. 직원 테이블
SELECT * FROM TBL_DEPT; -- 2. 부서 테이블
SELECT * FROM TBL_PROJECT; -- 3. 프로젝트 테이블
SELECT * FROM TBL_ASSIGNMENT; -- 4. 업무 배정 테이블
-- 1. 각 부서별 평균 금여를 구한 후 평균 급여를 기준으로 내림차순 하시오. 
-- 사용테이블 : TBL_EMP, TBL_DEPT
-- 출력 컬럼 : 부서 이름, 평균 급여
SELECT 
    E.DEPT_ID,AVG(SALARY)
FROM TBL_EMP E
INNER JOIN TBL_DEPT D ON E.DEPT_ID = D.DEPT_ID
GROUP BY E.DEPT_ID;
-- 2. 모든 부서장들의 급여 평균보다 높은 급여를 받는 직원들을 출력하시오. 
-- 사용 테이블 : TBL_EMP, TBL_DEPT
-- 출력 컬럼 : 직원 이름, 급여, 부서장들의 평균 급여
SELECT 
    D.HEAD_ID,    
    AVG(SALARY) AVG_SAL
FROM TBL_EMP E
INNER JOIN TBL_DEPT D ON E.EMP_ID = D.HEAD_ID
GROUP BY D.HEAD_ID;

SELECT E.EMP_NAME, E.SALARY, T.AVG_SAL
FROM TBL_EMP E
CROSS JOIN (
    SELECT AVG(E2.SALARY) AS AVG_SAL
    FROM TBL_EMP E2
    INNER JOIN TBL_DEPT D ON E2.EMP_ID = D.HEAD_ID
) T
WHERE E.SALARY > T.AVG_SAL;

-- 3. '모바일 앱 개발' 프로젝트에 배정된 직원들중 가장 높은 급여를 받는 직원을 출력하시오. 
-- 사용 테이블 : TBL_EMP, TBL_PROJECT, TBL_ASSIGNMENT
-- 출력 컬럼 : 직원 이름, 직급, 급여
SELECT  *
FROM TBL_EMP E
INNER JOIN TBL_PROJECT P ON E.DEPT_ID = P.DEPT_ID
INNER JOIN TBL_ASSIGNMENT A ON P.PROJ_ID = A.PROJ_ID;
-- 4. 각 직원의 부하직원의 수(자신의 emp_id를 manager_id로 가지고 있는 사람 수)를 구하시오. 단, 없으면 0으로 출력하시오. 
-- 사용 테이블 : TBL_EMP
-- 출력 컬럼 : 직원 이름, 직급, 부하직원 수

-- 5. 각 프로젝트에 투입된 직원의 수를 출력하시오.
-- 사용 테이블 : TBL_PROJECT
-- 출력 컬럼 : 프로젝트 이름, 투입된 인원 수