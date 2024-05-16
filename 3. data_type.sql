-- tinyint는 -128~127까지 표현
-- author 테이블에 age 컬럼 추가
alter table author add column age tinyint;

-- insert 시에 age : 200 -> 125
insert into author(id, email, age) values(5, 'hello@naver.com', 130);
insert into author(id, email, age) values(5, 'hello@naver.com', 125);
-- unsigned시에 255까지 표현범위 확대
alter table author modify column age tinyint unsigned;
insert into author(id, email, age) values(5, 'hello@naver.com', 200);

-- decimal 실습
alter table post add column price decimal(10,3);
describe post;

-- decimal 초과값 입력 후 짤림 확인a
insert into post(id, title, price) values(7, 'hello', 12.123123);
(=> 7, 'hello', 12.123123
 ==> id는 select * from post에서 조회한 후에 없는 id값을 지정
 ==> title은 필수 값이기 때문에 넣어주기
 ==> describe post에서 decimal(10,3)라고  이전에 지정해준 값을 확인가능 + 이에 넘어가는 값을 지정)
-- update : price를 1234.1
update post set price=1234.1 where id=;




