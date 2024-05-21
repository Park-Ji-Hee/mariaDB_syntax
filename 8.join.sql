********* sql : join 문제 대부분  ***********
+) inner join   ==> ex) inner join b
     : on 조건이 일치하는 데이터들만을 가지고 하나의 테이블로 만드는 것 (=> 교집합)
+) outer join   ==> ex) a left outer join b
     : 왼쪽 테이블 전부 일단 +  on 조건이 일치하는데이터 추가
     => a는 전부 다 복사 거기에 b 곁들이기 (만약 a 기준에 해당하는 b값이 없는 경우 해당 값 == null)


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


*********** 실습
-- join된 상항에서의 where 조건 : on 뒤에 where 조건이 나옴
## inner join 문제
-- 1) 글쓴이가 있는 글 중에(== 교집합 == inner join) 글의 title과 저자의 email을 출력, 저자의 나이는 25세 이상인 글만 출력하여라
    select p.title, a.email, --(a.age)
    from author a
    inner join post p on a.id = p.author_id
    where a.age >= 25;
        --(filter 2개 = on(= join시킬 때 사용)~ // where(generally used)~)

## left outer join 문제
-- 2) 모든 글 목록 중에(== outer join) 글의 title과 저자가 있다면(== 저자기준) email을 출력, 2024-05-01 이후에 만들어진 글만 출력하시오
    select p.title, p.email,  --(p.created_time)
    from post p
    left join author a on p.author_id = a.id
    where p.title is not null and p.created_time >= '2024-05-01';

    +) 조건 추가 : 이메일에 null이면 '익명' 출력
    select p.title, ifnull(p.email, '익명') 
    from post
    left join author a on p.author_id = a.id 
    where p.title is not null 
    and p.created_time >= '2024-05-01';


-- union
    --: 중복제외한 두 테이블의 select을 결합
-- 컬럼의 개수와 타입이 같아야함에 유의
-- union all : 중복포함
    SELECT 컬럼1, 컬럼2 FROM table1 UNION SELECT 컬럽1, 컬럼2 FROM table2;
-- author테이블의 name, email 그리고 post 테이블의 title, contents union
    SELECT name, email FROM author UNION SELECT title, contents FROM post;

    +) 사담
        -- 유지보수성 : 서비스를 유지하고, 서비스를 고치고
        -- 코드의 간결성과 직관성

-- 서브퀴리 : select문 안에 또다른 select문을 서브쿼리라 한다
    count(*) == 갯수 세기
-- 1) select절 안에 서브쿼리
--  author email과 해당 author거 쓴 글의 개수를 출력
    select email, (select count(*) from post p where p.author_id = a.id) as count from author a;

-- 2) from 절 안에 서브쿼리 (억지st)
    select a.name from (select * from author) as a;   --(from절 안에도 쓸 수 있음 // 피치못할 사정을 제외하고는 굳이굳이 쓸 필요는 없다)
    
-- 3) where 절 안에 서브쿼리 *******
    select a.* from author a inner join post p on a.id = p.author_id;
    select * from author where id in (select post.author_id from post);
      --(== select * from author where id in (select author_id from post); // 들어갈 내용에 해당하는 쿼리가 들어가야 함 // 서브쿼리 너무 많이 쓰면 안좋음)
    

-- 집계함수
    SELECT COUNT(*) FROM author;  -- (== SELECT COUNT(id) FROM author; == 엄마 테이블의 id 값은 전체와 동일함)
    SELECT SUM(price) FROM post;
    SELECT ROUND(AVG(price), 0) FROM post; --(ROUND == 반올림 // ROUND(반올림할값,소수점자리))


-- GROUP BY와 집계함수
    SELECT title FROM post GROUP BY author_id;               --(=> 불가능)
    SELECT author_id FROM post GROUP BY author_id;           --(=> 가능)
    SELECT author_id, COUNT(*) FROM post GROUP BY author_id; --(=> 가능)
    SELECT author_id, COUNT(*), SUM(price), ROUND(AVG(price), 0), MIN(price), MAX(price) FROM post GROUP BY author_id; --(=> 가능 // 한꺼번에 여러개 가능!)


-- 저자 email, 해당저자가 작성한 글 수를 출력
        -- inner join(교집합이기 때문에 어떤 한 테이블에 없는 값일 경우 최종 결과로 해당 값을 추출하지 않음)
        -- ==> if로 구분지어서 null이면 0 + null이 아니면 count값으로 출력하도록 함
    SELECT a.id, IF(p.id IS NULL, 0, COUNT(*))FROM author a LEFT JOIN post p ON a.id = p.author_id GROUP BY a.id;

-- where + group by 
    -- 연도별 post 글 출력, 연도가 null인 데이터는 제외(제외 값을 where에 넣어라)
        SELECT 연도, COUNT(*) FROM WHERE XXX GROUP BY 연도;
    SELECT DATEFORMAT(created_time, '%Y-%m-%d'), count(*) FROM post WHERE created_time IS NOT NULL GROUP BY DATEFORMAT(created_time, '%Y');  --(created_time IS NOT NULL == 조건)
     == SELECT DATEFORMAT(created_time, '%Y-%m-%d') as year, count(*) FROM post WHERE created_time IS NOT NULL GROUP BY year;  --(별칭 쓴 깔끔버전)


-- HAVING : 집계 함수에 대한 조건(where : 행에 대한 조건) group by를 통해 나온 통계에 대한 조건
    --(count ==> 전체 행의 수를 말함 // 특정 컬럼 언급X)
    SELECT author_id, count(*) FROM post GROUP BY author_id;
-- 글을 2개 이상 쓴 사람에 대한 통계정보
    SELECT author_id, count(*) as count FROM post GROUP BY author_id HAVING COUNT>=2;
    (각각(likewise id)에 대한 조건 = where)

    -- (실습) 포스팅 price가 2000원 이상인 글을 대상으로,
    --      작성자별로 몇 건인지와 평균 price를 구하되,
    --      평균 price가 3000원 이상인 데이터를 대상으로만 통계 출력
        SELECT author_id, avg(price) as avg_price FROM post where price>=2000 GROUP BY author_id HAVING avg_price >= 3000;
        SELECT author_id, round(avg(price), 0) as avg_price FROM post where price>=2000 GROUP BY author_id HAVING avg_price >= 3000;

    -- (실습) 2건 이상의 글을 쓴 사람의 ID와 email 구할건데, 글의 수 구할건데,
    -- 나이는 2 나이 많은 사람 1명의 통계를 출력5세 이상인 사람만 통계를 사용하고, 가장하시오, 나이 많은 순으로 정렬
        SELECT a.id, count(a.id) as count, MAX(a.age) as age FROM author a inner join post p
        ON a.id = p.author_id 
        WHERE a.age >= 25
        ORDER BY Max(a.age) DESC  
        GROUP BY a.id HAVING count >=2 LIMIT 1;
          --(new issue : order by가 마지막이기 때문에 group by 이후 age 정렬 가능한지 / order by )
    ***** 실행순서 : select -> join -> on -> where -> group -> having -> order -> limit


-- 다중열 group by
    SELECT author_id, title, COUNT(*) FROM post GROUP BY author_id, title; 


-- 














