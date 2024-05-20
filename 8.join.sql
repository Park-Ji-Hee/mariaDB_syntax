글쓴이 중에 글쓴 사람을 골라서 그 사람이 쓴 글을 합한 테이블 생성
select * from post inner join author on author id. = post.author_id;
(순서 바꿔도 결과값은 동일)


-- inner join
-- 두 테이블 사이에 지정된 조건에 맞는 레코드만 반환, on 조건을 통해 교집합 찾기    (결과값 : 두 테이블 합쳐져서 보임)
SELECT * FROM POST inner join author on author.id = post.author_id;
SELECT * FROM author a inner join post p on a.id = p.author_id;   --(as == a : 별칭)
-- 글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력하시오.
SELECT p.id, p.title, p.contents, a.email FROM post p inner join author a on p.author_id = a.id;


****** 중요! / 복습하기
-- 모든 글목록을 출력하고, 만약에 글쓴이가 있다면 이메일을 출력 (글쓴이가 없는 애들은 null로 출력)
-- select * from post left outer join == select * from post left join  (왼쪽에 잇는 데이터들은 다 나오는거다)
select p.id, p.title, p.contents, a.email from post p 
left outer join author a on p.author_id = a.id;  --(outer 생략가능 // from 메인테이블, left joing 곁들이는테이블)


*********** 
-- join된 상항에서의 where 조건 : on 뒤에 where 조건이 나옴
-- 1) 글쓴이가 있는 글 중에 글의 title과 저자의 email을 출력, 저자의 나이는 25세 이상인 글만 출력하여라
select p.title, a.email, --(a.age)
from author a
inner join post p on a.id = p.author_id
where a.age >= 25;
-- 2) 모든 글 목록 중에 글의 title과 저자가 있다면 email을 출력, 2024-05-01 이후에 만들어진 글만 출력하시오
select p.title, p.email,  --(p.created_time)
from post p
left join author a on p.author_id = a.id
where p.created_time >= '2024-05-01';


