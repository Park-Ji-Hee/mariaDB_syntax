이해가 부족하면 타 자료 참고하기
-- 각 어원 의미
    dirty read == 아직 commit 되지 않는 값이 읽히는 것
    phantom read == 중간에 내용 추가되는 것
    non-repeatable read == 중간에 내용 수정되는 것
    Serializable == lock을 해서 작업

### DB 동시성 이슈

1. dirty read(아직 commit되지 않은 데이터가 읽힘으로서, 추후 rollback 될 가능성이 있는 데이터)
    => read uncommitted -> read committed으로 올려라

2.  Phantom Read (갑작스런 추가로 팬텀리드가 되는건 read committed로 변경불가능하다)
    => Read committed -> Repeatable Read로 올려라

3.  insert/Update가 됐음에도 트랜잭션에서 반영되지 않는 문제 
    => 둘 다 insert/Update는 허용 안하는 상태 + 같이 있는 select까지 막을건지/아니면 select만 허용할건지
    1) select는 허용(격리수준 낮고, 성능 높아짐) : shared lock(select for share) == update만 막겠다
    2) select도 허용(격리수준 높고, 성능 낮아짐) : 배타적 락(select for update)


-- dirty read 실습
-- 워크밴치에서 auto_commit해제 후 update 실행 -> commmit이 안된 상태
    ==> 임시저장만 되어 있음(; 확정은 아님)
-- 터미널 열어서 select 했을 때 위 변경사항이 변경됐는지 확인
    ==> 변경안됨 (== 격리 수준이 높다)

(+++ blob 상태에서 뭐가 우루루루루 뭐징)
(commit이 안된 상태이기 때문에 터미널에서 확인은 안됨 // 이용 tool에서만 수치 바뀌었음)


-- phantom read 동시성 이유 실습
-- 워크밴치에서 시간을 두고 2번의 select가 이뤄지고,
-- 터미널에서 중간에 insert 실행 -> 2번의 select 결과값이 동일한지 확인
    START TRANSACTION;
    select * from author;
    do sleep(15);          --(do sleep() == 지정된 시간만큼 잠깐 멈추게 함 // 지정해놓은 시간 이내에 터미널 값 입력해야함)
    select count(*) from author;
    commit;
    -- 터미널에서 아래 insert문 실행
    insert into author(name, email) Values('kim', 'kil@naver.com')


**** 다시 해보기
-- lost update 이슈를 해결하기 위한 공유락(shared lock)
-- 워크밴치에서 아래 코드실행
    START TRANSACTION;
    select post_count from author where id = 1 lock in share mode;
    do sleep(15);
    select post_count from author where id = 1 lock in share mode;
    commit;

-- at. 터미널 // 검증하기위한 커리문
select post_count from author where id = 1 lock in share mode;
update AUTHOR SE post_count where id = 1;


-- 배타적 잠금(exculsive lock) : select for update     //// (For) event 상황
-- select 부터 lock을 거는 작업
START TRANSACTION;
select post_count from author where id = 1 for update;
do sleep(15);
select post_count from author where id = 1 for update;
commit;

-- at. 터미널 // 검증하기위한 커리문
select post_count from author where id = 1 for update;
update AUTHOR SE post_count where id = 1;



-- 






