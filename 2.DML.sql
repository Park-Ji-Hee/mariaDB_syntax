-- insert into : 데이터 삽입
insert into 테이블명(컬럼명1, 컬럼명2, 컬럼명3) values(데이터1, 데이터2, 데이터3);
-- id, name, email -> author 1건 추가
insert into author(id, name, email) values(1, 'hongildong', 'hongildong@naver.com')
(글자는 ''안에다가 넣어야함!)
-- select : 데이터 조회, * : 모든 컬럼조회
select * from author;

-- id, title, content, author_id -> posts에 1개 추가
insert into posts(id, title, content, author_id) values(1, 'hello', 'hello world', 1); (=> author_id는 author에 id로 지정된 숫자로 넣어야함)
insert into posts(id, title, content) values(1, 'hello', 'hello world');   (=> not null 조건이 없기 때문에 가능함)

-- ****제약조건 조회
select * from information_schema.key_column_usage where table_name = 'posts';
(스키마(information_schema) 안에 있는 테이블(key_column_usage) //
데이터베이스 selected 안되어 있으면 테이블 앞에 데이터 베이스(information_schema.key) 써주기)

use information_schema;
select * from key_column_usage where table_name = 'posts';
(use 데이터베이스명으로 지정했으면 => INFORMATION_SCHEMA 쓸 필요 없음)





