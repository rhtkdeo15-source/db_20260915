-- 날짜함수

SELECT
    SYSDATE -- 현재시간
FROM DUAL;

-- TO_CHAR : 시간을 원하는 문자 포멧으로
-- TO_DATE : 문자를 시간포멧 으로
SELECT
    SYSDATE,
    TO_CHAR(SYSDATE, 'YY-MM-DD'),
    TO_CHAR(SYSDATE, 'YYYY-MM-DD'),
    TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS'),
    TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'),
    TO_DATE('2026-09-28', 'YYYY-MM-DD')
FROM DUAL;

SELECT 
    P.*,
    TO_CHAR(HIREDATE,'YY-MM-DD') AS 입사일
FROM PROFESSOR P
WHERE TO_CHAR(HIREDATE,'YY') = '85';

















