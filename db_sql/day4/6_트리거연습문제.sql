--ENROL 테이블 트리거 만들기
SELECT * FROM ENROL;
--조건 1. 테이블명은 ENROL_LOG
--       컬럼은 과목번호, 학생번호, 수정전시험점수, 수정후시험점수, 작업자ID, 작업종류, 작업날짜
--조건 2. INSERT할 경우 ENROL_LOG에 해당 내용 자동 저장
--       단, 시험점수가 0~100사이가 아니면 0으로 저장
--조건 3. UPDATE할 경우 ENROL_LOG에 해당 내용 자동 저장
--       단, 시험점수가 0~100사이가 아니면 에러를 띄운 후 종료
--조건 4. DELETE할 경우 에러를 띄운 후 종료
CREATE TABLE ENROL_LOG(
    L_SUBNO NUMBER,
    L_STUNO NUMBER,
    O_ENRGRADE NUMBER,
    N_ENRGRADE NUMBER,
    L_ID VARCHAR2(50),
    EVENT VARCHAR2(50),
    L_TIME DATE
);
CREATE OR REPLACE TRIGGER ENROL_TRIGGER
    BEFORE INSERT OR UPDATE OR DELETE ON ENROL
    FOR EACH ROW
BEGIN
    IF INSERTING THEN

        IF :NEW.ENR_GRADE NOT BETWEEN 0 AND 100 THEN
            :NEW.ENR_GRADE := 0;
        END IF;
        INSERT INTO ENROL_LOG
        VALUES(
            :NEW.SUB_NO, :NEW.STU_NO, :NEW.ENR_GRADE, :NEW.ENR_GRADE, SYS_CONTEXT('USERENV', 'SESSION_USER'), 'I',SYSDATE
        );
    ELSIF UPDATING THEN
        IF :NEW.ENR_GRADE NOT BETWEEN 0 AND 100 THEN
            RAISE_APPLICATION_ERROR(-20003, '0~100사이 입력');
        END IF;
        INSERT INTO ENROL_LOG
        VALUES(:NEW.SUB_NO, :NEW.STU_NO, :OLD.ENR_GRADE, :NEW.ENR_GRADE, SYS_CONTEXT('USERENV', 'SESSION_USER'), 'U', SYSDATE
        );
    ELSIF DELETING THEN
        RAISE_APPLICATION_ERROR(-20004, '학생 성적 삭제불가');
    END IF;
END;
/

