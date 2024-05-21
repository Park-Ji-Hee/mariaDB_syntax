1. 조회 : show(데이터베이스, 테이블) describe(컬럼) select*from(value)
    show databases;             --(데이터베이스)
    show table 테이블명;         --(테이블)
    describe 테이블명;           --(컬럼)
    select * from 테이블명;       --(value)

2. 생성 : create(데이터베이스, 테이블) alter(컬럼 추가) intsert into(데이터/밸류)
    create database 데이터베이스명;        --(데이터베이스)
    create table 테이블명;                 --(테이블)
      -- 부모테이블 만들기
      create table author(id INT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), password VARCHAR(255));
      -- 자식테이블 만들기
      create table posts(id INT PRIMARY KEY, title VARCHAR(255), content VARCHAR(255), author_id INT, FOREIGN KEY(author_id) REFERENCES author(id));
    alter table 테이블명 add 컬럼명 컬럼타입; --(컬럼 // 컬럼만 추가 세부값 미지정)
    insert into 테이블명(컬럼명1, 컬럼명2) values(데이터1, 데이터2); --(컬럼 데이터 같이 추가)

3. 수정 : (데이터를 제외하고는 이름변경을 제외한 수정이 필요없음)
  alter table 테이블명 modify column 컬럼명 바꿀 조건
    alter table author modify column email varchar(255) not null;
  update 테이블명 set 컬럼명1 = 데이터1, 컬럼명2 = 데이터2 where id = 값;
    update author set name = 'abc', email='abc@test.com' where id = 1;

4. 삭제 : 
  drop database 데이터베이스명;          --(데이터베이스)
  drop table 테이블명;                  --(테이블)
  alter table 테이블명 drop 컬럼명;      --(컬럼)
  delete from 테이블명 where id=해당값;  --(자식테이블에서의 행 삭제)

5. 이름변경 : 
  ALTER DATABASE 원래데이터베이스이름 MODIFY NAME = 새로운데이터베이스이름;    --(테이블)
  alter table 원래테이블명 rename 바꿀테이블명;                               --(테이블)
  alter table 테이블명 change column 원래컬럼명 바꿀컬럼명 컬럼타입;          --(컬럼)
  *** 데이터는 이름변경이 자체수정과 같은 의미이므로 수정 참고

6. 선택 : 
  use board;                            --(데이터베이스 선택)
  select 컬럼명 from 테이블명;           --(해당 컬럼만 조회)
  select distinct 컬럼명 from 테이블명;  --(중복 제거하고 조회)

7. 중복값 제한 / 데이터 한정 / 디폴트값+들어갈데이터값한정
  select distinct 컬럼명 from 테이블명;  --(중복 제거하고 조회)
  select * from 테이블명 order by 컬럼명 desc limit 인덱스번호; --(추출할데이터인덱스) 
  alter table 테이블명 add column 컬럼명 enum('admin', 'user') not null default '디폴트값';  --(디폴트값)


-- 붙여넣기 : 우클릭

-- 데이터베이스 접속  
  mairadb -u root -p (+ enter + passwd입력)
  (????? 근데 왜 로그인 요거 안되고ㅡ> mysql -u root -p로 되징..?)

-- 스키마(database) 목록조회
  show databases;

-- (스키마)테이터베이스 생성
  CREATE DATABASE board; 
  (CREATE database: 명령문(대문자가 원래 원칙) // board : 문자열 
  // table, column 은 보통 소문자)

-- 데이터베이스 선택 (1. 테이블 생성 할 데이터 베이스 선택 -> 2. 테이블 생성)
  use board;

-- 테이블 조회
  show tables;

-- author 테이블 생성
  create table author(id INT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), password VARCHAR(255));
  (create table 테이블명(들어갈 항목 + column의 타입 + 길이(숫자는 양 자동 배정이라 길이 쓸 필요 없음/글자는 지정 필요함) 모두 적어야 함) + PK)

-- 테이블 컬럼조회
  describe author;
  (describe 테이블명;)
-- 컬럼 상세 조회 (주석까지 포함해서 봄)
  SHOW FULL COLUMNS FROM author;
  (SHOW FULL COLUMNS FROM 테이블명;)

-- 테이블 생성문 조회
  show create table author;

-- posts 테이블 신규 생성 (id, title, content, author_id
  create table posts(id INT PRIMARY KEY, title VARCHAR(255), content VARCHAR(255), author_id INT, FOREIGN KEY(author_id) REFERENCES author(id));
  (generally  id는 long으로 지정 // pk는 ','를 안쓰거나 가장 마지막에 'PRIMARY KEY(id)'라고 써도됨 // fk는 ', foreign key'라고 바로 써야함)

-- 테이블 index 조회
  show index from author;
  show index from posts;

-- ALTER문 :테이블의 구조를 변경
-- 테이블 이름 변경 (rename)
  alter table posts rename post;
-- 테이블 컬럼 주기
  alter table author add column test1 varchar(50);
-- 테이블 컬럼 삭제
  alter table author drop column test1;

-- 테이블 컬럼명 변경 (change)
  alter table post change column content contents varchar(255);
 
-- 테이블컬럼 타입과 제약조건 변경   (*** 가장 많이 사용!)
  alter table author modify column email varchar(255) not null;
  (alter table 테이블명 modify column 컬럼명 바꿀 조건)

*** 실습 ***
-- 실습 : author 테이블에 address 컬럼 추가. varchar 255추가
  alter table author add column addres varchar(255);
-- 실습 : post 테이블에 title은 not null, contents는 3000자로 변경
  alter table author modify column title varchar(255) not null;
  alter table post modify column contents varchar(3000);

(연결된 자식 테이블에 not null 설정하기 전에 앞에서 해당 컬럼을 null(= 비워두기)로 해놓으면,
바로 연결된 자식테이블 not null 설정 불가능 // not null 설정하고 싶은 경우 임의 값을 넣어야함)

-- 테이블 삭제
  drop table post;
  (drop table 테이블명;)
  (만약 지운 테이블을 재생성하고 싶다면 show create table author;으로 다시 살릴 수 있음 //
  초본 아니고 최종적으로 변경된 해당 테이블로 복구)
  (재생성 : 만들은 테이블 내용 복사해서 다시 붙이면 됨)
  | post  | CREATE TABLE `post` (
    `id` int(11) NOT NULL,
    `title` varchar(255) NOT NULL,
    `contents` varchar(3000) DEFAULT NULL,
    `author_id` int(11) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `author_id` (`author_id`),
    CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci |
  => 
  CREATE TABLE `post` (
    `id` int(11) NOT NULL,
    `title` varchar(255) NOT NULL,
    `contents` varchar(3000) DEFAULT NULL,
    `author_id` int(11) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `author_id` (`author_id`),
    CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)

-- insert문을 통해 author데이터 4개 추가, post 5개 추가 1개정도는 익명
  (1개정도는 익명 => null 하려면 해당 내용을 따로 안적으면 됨)
  (*** 컬럼은 존재하는 것을 지칭해야함!! // id는 다르게 해야함 //
  author의 id와 post의 author_id는  1:n 관계임 => n:n 관계는 정규화에 위배되어 불가능함)
  insert into author (id, name, email) values(2, 'a1', 'ha@naver.com1');
  insert into author (id, name, email) values(3, 'a2', 'ha@naver.com2');
  insert into author (id, name, email) values(4, 'a3', 'ha@naver.com3');
  insert into author (id, name, email) values(5, 'a4', 'ha@naver.com4');

  insert into post (id, title, contents, author_id) values(2, 'b2', 'bb1', 2);
  insert into post (id, title, contents, author_id) values(3, 'b3', 'bb2', 3);
  insert into post (id, title, contents, author_id) values(4, 'b4', 'bb3', 4);
  insert into post (id, title, contents, author_id) values(5, 'b5', 'bb4', 5);
  insert into post (id, title, contents) values(6, 'b6', 'bb5');

  (대입한 값 보기 위해서 => select * from 보고싶은테이블명; = 전체 인덱스 조회법 쓰면 됨)

-- update [테이블명] set 컬럼명1=데이터, 컬럼명2=데이터 where id = 1; (=> 해당 요소만 변경시키는 것)
-- where id 작성하지X -> 전체 값이 빠지게 됨     ******실행에 주의!!
  update author set name = 'abc', email='abc@test.com' where id = 1;
  update author set email ='abc@naver.com' where id = 2;

--  delete from 테이블명 where 조건
--  where 조건이 생략될 경우 모든 데이터가 삭제됨에 유의
  delete from author where id=5;
  (**** post 값이 해당 id를 물고 있는 경우 삭제가 불가능 할 수 있기 때문에
    -> 자식 테이블이 물고 있는 id 값을 삭제하고 싶다면 해당 값을  null로 바꾸거나 다른 값으로 변경
    => null값 만들기 = 해당 인덱스의 author_id=null로 update문 작성)

-- SELECT문의 다양한 조회방법
  select * from author;
  select * from author where id=1;
  select * from author where id>2 and name='a';
  select * from author where id>2 or name='a';

-- 특정 컬럼만을 조회할때
  select name, email from author where id = 3;

-- 중복 제거하고 조회
  select title from post; (해당 컬럼만 조회)
  select distinct title from post; (중복 제거하고 조회)

-- 정렬 : order by, 데이터의 출력결과를 특정 기준으로 정렬
-- 아무런 정렬조건없이 조회할 경우 pk기준을 오름차순 정렬 (order by 생략시 pk를 기준으로 오름차순 정렬하여 결과값 반환)
-- asc : 오름차순 // desc 내림차순 
  select * from author order by name asc;

-- 멀티 order by : 여러 컬럼으로 정렬, 먼저쓴컬럼 우선 정렬, 중복시 그 다음음 정렬옵션 적용
  select * from post order by title; --asc/dsc 생략시 오름차순
  select * from post order by title, id desc; (id 기준으로 오름차순 할 예정)

-- limit number : 특정 숫자로 결과값 개수 제한 *****사용多
  select * from author order by id desc limit 1; (= author 테이블을 id 기준으로 올림차순하여 가장 상위 1개를 선택하겠다)

-- alias(별칭)을 이용한 select : as 키워드 사용
  select name as 이름, email as 이메일 from author;
  select a.name as 이름, a.email as 이메일 from author as a; (별칭을 a 라고 지정)
  (각 column 명이 동일함을 예방하여 별칭을 사용)

-- null을 조회조건으로
  select * from post where author_id is null; (비어져 있는 것 조회)
  select * from post where author_id is not null; (비어져 있지 않은 것 조회)

*** 프로그래머스 문제 ***
  -- 여러 기준으로 정렬하기 
  -- 상위 n개 레코드
  => SELECT NAME FROM ANIMAL_INS ORDER BY DAYTIME LIMIT 1;







