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


-- blob 바이너리데이터 실습
INSERT INTO author(profile_phto) VALUES(LOAD_FILE('/path/to/your/file'));
(INSERT INTO 테이블명(컬럼명) VALUES(LOAD_FILE('사진경로'));)

-- author 테이블에 profile_image컬럼을 blob형식으로 추가
alter table author modify column profile_image longblob;
(alter table 테이블명 modify column 컬럼명 컬럼타입;)
insert into author(id, email, profile_image) values(6, 'abc@naver.com', LOAD_FILE('C:\\picture.jpg'));
(INSERT INTO 테이블명(컬럼1, 컬럼2, 컬럼3) VALUES(컬럼1값, '컬럼2값', LOAD_FILE('컬럼3_사진경로'));)

???? 
-- enum : 삽입될 수 있는 데이터 종류를 한정하는 데이터 타입 (-> 각 항목에 벗어나는 내용을 입력할 수 있기 때문)
-- role컬럼
(alter table author add column role varchar(10); (10개 이내로 값이 들어감))
alter table author add column role enum('admin', 'user') not null default 'user';
alter table author add column role2 enum('admin', 'user') not null default 'user';
 --(role 컬럼은 enum에 의해서 admin이랑 user 값만 가질 수 있음 + null 설정 불가능하며 디포트 값으로 user만 갖음 )

-- enum 컬럼 실습 ****
-- user1을 insert => error
insert into author (id, emamil, role) values(7, 'abc@naver.com', 'user1');
-- user 또는 admin insert => 정상

============================================================
alter table author modify column created_time2 datetime;


-- date 타입
-- author테이블에 birth_day 컬럼을 date로 추가
alter table author add column birth_day date; --(date으로 타입추가)
-- 날짜 타입의 insert는 문자열 형식으로 insert
insert into author(id, email, birth_day) values(13, 'efg@naver.com', '1999-05-01');
-- (insert into author(id, name, email, birth_day2) VALUES(9, 'jihee', 'ha@naver.com', '1999-04-03');)

14 / 10 => select * from author해서 id 확인하기
-- datetime 타입
-- author, post 둘다 datetime으로 created_time 컬럼추가
alter table author add column created_time datetime; --(datetime으로 타입추가)
insert into author(id, email, created_time) values(7, 'aaa@naver.com', 1999-05-01 12:01); -- +) 1999-05-01 12:01
alter table post add column created_time datetime;
insert into post(id, title, created_time) values(8, 'aaa@naver.com', 1999-05-01 12:01); -- +) 1999-05-01 12:01


-- current_timestamp 설정
alter table author modify column created_time datetime default current_timestamp;
 --(CURRENT_TIMESTAMP : 현재시간 자동설정 값)
insert into author(id, email) values(14, 'aaa@naver.com'); --(??? 디폴트 값을 current_timestamp로 달고 나서 원래 기본 값들은 디폴트 적용이 안되는가)
alter table post modify column created_time datetime;
insert into post(id, email) values(10, 'aaa@naver.com');

-- 비교연산자
-- and 또는 &&
select * from post where id >= 2 and id <= 4;
select * from post where id between 2 and 4;  -- (위에 코드와 동일한 코드)
-- or 또는 ||
select * from post where id < 2 or id > 4;
-- not 또는 !
select * from post where not(id < 2 or id > 4);
-- NULL인지 아닌지
SELECT * FROM post WHERE CONTENTS IS NULL;
SELECT * FROM post WHERE CONTENTS IS NULL;
-- in(리스트형태), not in(리스트형태)
SELECT * FROM post where id in(1,2,3,4); --(컬럼 value 중 in에 해당하는 값들만 고르시오)
SELECT * FROM post where id not in(1,2,3,4); --(컬럼 value 중 in에 해당하는 값을 제외한 것만 고르시오)

-- like : 특정 문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드
select * from post where title like '%o'; --o로 끝나는 title 검색
select * from post where title like 'm%'; --j로 끝나는 title 검색
select * from post where title like '%llo%'; --% => %사이에 있는llo가 단어 중간에있는 문자를 검색하겠다
select * from post where title not like '%o'; --o로 끝나는 title이 아닌 title 검색

--ifnull(a, b) : 만약 a가 null이면 b반환, null이 아니면 a반환
select title, contents, ifnull(author_id, '익명') as 저자 from post;


-- ***** 프로그래머스 : 경기도에 위치한 식품창고 목록 출력하기

-- REGEXP : 정규표현식
select * from author where name REGEXP '[a-z]'; --(a-z로만 이루어져 있는 name을 찾아라)
select * from author where name REGEXP '[가-힣]'; 

-- 날짜 변환 : 숫자 -> 날짜, 문자 -> 날짜

SELECT CAST(20200101 AS DATE); -- SELECT CAST(20200101 AS DATE) FROM author where;
-- (SELECT CAST(변환할값(문자열, 숫자) AS 타입) // cast 많이 씀)
SELECT CAST('20200101' AS DATE);
SELECT CONVERT(20200101, DATE);  --convert(날짜, 시간 변환하는데 사용 // 환경제약 많음)
SELECT CONVERT('20200101', DATE);

-- datetime  조회방법 (like + 비교연산자)
select * from author where created_time like '2024-05%'; --(문자열 형식으로 조회가능)
select * from author where created_time <= '2024-12-31' and created_time>='1999-01-01'; --년도만 확인 => like 쓰기
select * from author where created_time between'2024-12-31' and created_time>='1999-01-01';

-- date_format (// 가장 많이 사용 // )
select date_format(created_time, '%Y-%m') from author; -- (조회조건 안에다가 조건 넣음)
(select date_format(지정할컬럼, 지정된형식문자열) from 지정된컬럼이있는테이블;)
-- 실습 : 2024년 데이터 조회
select * from  author where date_format(created_time, '%Y') = '2024'; -- (조회조건 뒤에 변경된 조건 넣음)
select * from  author where date_format(created_time, '%Y-%m-%d') = '2024-05-17';

-- 오늘날짜 => EX) SELECT DATE(NOW());
select now();

-- date_format 같이 적용시킬 수 있음
***** 수정시키기 : select now();


-- ***** 프로그래머스 흉부외과 또는 일반외과 의사 목록 출력하기
-- <참고> 문제오류 : 날짜 같이 있음
SELECT DR_NAME, DR_ID, MCDP_CD, HIRE_YMD_DATE_FORMAT (HIRE_YMD, '%Y-%m-%d') AS HIRE_YMD
FROM DOCTOR WHERE MCDP_CD in ('CS', 'GS') ORDER BY HIRE_YMD DESC, DR_NAME;




