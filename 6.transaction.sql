-- start transaction 한 이후에 테이블에 직접적인 데이터 변환이 안될 수 있음 => 프로그램 종료 후 재실행해보기

-- author테이블에 post_count라고 컬럼(int) 추가
  alter table author add column post_count int not null default 0;
  --(null값이 있는 상태에서 숫자를 더해도 결과 값 = null // 이럴 상태에는 drop하고 디폴트 값을 넣어주기)

-- post에 글 쓴 후에, author 테이블에 post_count값에 +1 => 트랜잭션
  start transaction;
  update author set post_count = post_count+1 where id = 1;  --(존재하는 id라서 성공함)
  insert into post(title, author_id) Values('hello world', 20); --(존재하지 않는 id라서 실패함)
  -- 위 쿼리들이 정상실행되었으면 X 실패해쓰면 Y -> 분기처리 procedure
  commit;
    --(=> commit 실패할경우 : 임시상태로 저장됨 // 이미 완전히 commit된 이후에는 rollback을 실행해도 rollback 되지 않음)
  -- 또는
  rollback;


-- stored 프로시저를 활용한 트랜잭션 테스트
  DELIMITER //  --(DELIMITER //에서 '//'도 포함해야 함 // *새로고침)
  CREATE PROCEDURE InsertPostAndUpdateAuthor() --(InsertPostAndUpdateAuthor : 쿼리집단의 이름부분)
  BEGIN
      DECLARE exit handler for SQLEXCEPTION
      BEGIN
          ROLLBACK;  --(rollback 되면 해당 값이 시행되지 않음  // 임시저장 상태 : 상단에 가능한 코드는 시행됨 -> COMMIT 상태와 다른 점 : ROLLBACK 처리하면 뒤로 복구 가능)
      END;
      -- 트랜잭션 시작
      START TRANSACTION;
      -- UPDATE 구문
      UPDATE author SET post_count = post_count + 1 where id = 1;
      -- INSERT 구문
      insert into post(title, author_id) values('hello world java', 20);  --(없는 id 값을 넣어서 실행이 안되는 것을 확인해야함)
        -- 모든 작업이 성공했을 때 커밋
      COMMIT;
  END //
  DELIMITER ;

-- 프로시저 호출
CALL InsertPostAndUpdateAuthor();


-- 




