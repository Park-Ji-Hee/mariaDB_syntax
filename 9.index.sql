    -- index
    : pk, fk, unique 시 index option 만들어짐

-- index 생성문
CREATE INDEX 인덱스명 ON 테이블명(컬럼명);


-- index 조회
SHOW INDEX FROM 테이블명;

-- index 삭제
ALTER TABLE 테이블명 DROP INDEX 인덱스명;

-- 테이블 생성
use board;

CREATE TABLE author (
   id bigint(20) NOT NULL AUTO_INCREMENT,
   email varchar(255) DEFAULT NULL,
   PRIMARY KEY (id)
 );

show index from author;

-- 대량 데이터 생성 프로시져 생성
DELIMITER //
CREATE PROCEDURE insert_authors()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE email VARCHAR(100);
    DECLARE batch_size INT DEFAULT 10000; -- 한 번에 삽입할 행 수
    DECLARE max_iterations INT DEFAULT 100; -- 총 반복 횟수 (100000000 / batch_size)
    DECLARE iteration INT DEFAULT 1;
    WHILE iteration <= max_iterations DO
        START TRANSACTION;    
        WHILE i <= iteration * batch_size DO
            SET email = CONCAT('jihee', i, '@naver.com');
            INSERT INTO author (email) VALUES (email);
            SET i = i + 1;
        END WHILE;
        COMMIT;
        SET iteration = iteration + 1;
        DO SLEEP(0.1); -- 각 트랜잭션 후 0.1초 지연
    END WHILE;
END //
DELIMITER ;

call insert_authors();              --트랜잭션 돌리는 중

select count(*) from author;        -- 들어간 값 확인


-- 인덱스 생성
CREATE INDEX email_index ON author(email);

SHOW INDEX FROM author;  -- 인덱스 있는지 확인해보기 // 결과 : 빠름(beacuase 인덱스 효과 // index == 목차역할)



