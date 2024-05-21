-- not null 조건 추가
alter table 테이블명 modify column 컬럼명 타입 not null;

==========> 요기서 부터 책이랑 같이 보기
  (1. auto_increment시행하려고 했더니 fk걸려 있어서 못한다고 함
  2. fk 조회해서 값 확인 + fk 지우는 작업 함
  3. 원래 하려고 했던 auto_increment 시행함
  4. 삭제된 fk 제약조건 재추가함
  5. increments 적용된거 확인 test 함)
-- auto_increment
  alter table author modify column id bigint auto_increment;
  alter table post modify column id bigint auto_increment;
  (post에서 author_id에 제약조건을 가지고 있다보니 author_id에 새로운 제약조건을 추가하는 부분에서 문제 발생)
  use INFORMATION_SCHEMA.key_column_usage where table_name = 'post';
      ==> 
      -- author.id에 제약조건 추가시 fk로 인해 문제 발생시
      -- fk먼저 제거 이후에 author.id에 제약조건 추가
      SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE table_name = 'post'; --제약조건 정보조회
      (SELECT * FROM information_schema.key_column_usage WHERE  table_name = '테이블명';)
      (오류 줄이기 위해서 처음 생성시 auto 설정하면 됨)
      -- 삭제 (for remove error)
      alter table post drop foreign key post_author_fk; post_ibfk_1
      (alter table post drop foreign key 조회된fk값)
      (~ == foreing key 값 == (SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE table_name = 'post';)로 조회했을 때 나오는 값)
    post에 있는 author bigint로 변경 하라는딩
    -> alter table post modify column author_id bigint;
  -- 삭제된 제약조건 다시 추가
    alter table post add constraint post_author_fk foreign key(author_id) references author(id);
    (alter table post add constraint 'CONSTRAINT_NAME' foreign key('COLUMN_NAME') references author('REFERENCED_COLUMN_NAME');)
  -- increments 확인용 test  
    insert into author(email) values('hello@naver.com'); -- => 결과 확인 : increments 적용 되어 있어야 함


--UUID
  insert into post(title) values('abc'); --(작업하려고한 사전작업)
  -- 여기서 UUID추가하는거
  alter table post add column use_id char(36) default(UUID());
  (alter table 테이블명 add column 컬럼명 타입 default(UUID());)

??? -- unique 제약조건 (=> index가 생성된당)
  ALTER TABLE author ADD CONSTRAINT unique_email UNIQUE (email);
  -- (이거 지피티가 틀렸다고 함)alter table author modify column email varchar(255) unique;
  -- (Error Code: 1062. Duplicate entry 'ha@naver.com' for key 'emai')

-- on delete cascade 테스트 -> 부모테이블의 id를 수정하면? 수정안됨
  -- (1. 조회 2. 삭제)
  1. 조회
      select * from information_schema.key_column_usage where table_name = 'post';
  2. 삭제
    alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade;
    (alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade;)
    -- (부모를 지워야 자식이 같이 날라감 // 같이 확인하기)
    delete from author where id =(지울id)  
    -- (정상작동 상태 : on delete만 조건 준 상태라서 'on update는 restrict' 상태로 남아있다 => post에 있는 author_id가 수정되면 안되는 상태이다)
    -- ( 밑에꺼 => on update 조건 삭제하는 과정 / 케이스 없을 경우 만들기 : 글쓴이 중(글쓴 사람이 있는 인덱스로 선택)에 해당 글 쓴 사람이 있어야 함)
    -- (1. 조회 2. 항목 확인 3. )
    alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete on update cascade;

-- ****(실습) delete는 set null, update cascade; 
  -- (delete는 set null)  요기는 drop하는 코드 들어가야된뎅
  -- (update cascade) 
  alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete set null on update cascade;
  --(=> 삭제할 경우 연결되어 있던 자식테이블의 author_id는 null로 바뀌어야됨 확인해보깅)


>>>>>>>
  -- (1. 조회 2. 삭제)
1. 조회
  select * from information_schema.key_column_usage where table_name = 'post';
2. 삭제
  alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade;
  (alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete cascade;)
  -- (부모를 지워야 자식이 같이 날라감 // 같이 확인하기)
  delete from author where id =(지울id)  
  -- (정상작동 상태 : on delete만 조건 준 상태라서 'on update는 restrict' 상태로 남아있다 => post에 있는 author_id가 수정되면 안되는 상태이다)
  -- ( 밑에꺼 => on update 조건 삭제하는 과정 / 케이스 없을 경우 만들기 : 글쓴이 중(글쓴 사람이 있는 인덱스로 선택)에 해당 글 쓴 사람이 있어야 함)
  -- (1. 조회 2. 항목 확인 3. )
  alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete on update cascade;

-- ****(실습) delete는 set null, update cascade; 
  -- (delete는 set null)  요기는 drop하는 코드 들어가야된뎅
  -- (update cascade) 
  alter table post add constraint post_author_fk foreign key(author_id) references author(id) on delete set null on update cascade;
  --(=> 삭제할 경우 연결되어 있던 자식테이블의 author_id는 null로 바뀌어야됨 확인해보깅)




