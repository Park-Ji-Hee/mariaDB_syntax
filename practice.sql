>> LIMIT *****사용多
    select * from author order by id desc limit 1; 
    (= author 테이블을 id 기준으로 올림차순하여 가장 상위 1개를 선택하겠다)

>> ORDER BY : 가장 마지막에 씀 // 순서조건 여러개일 때 같이 쓰면 됨 // 기본 디폴트 값 == ASC
    ORDER BY HIRE_YMD DESC, DR_NAME;

>> WHERE LIKE/NOT LIKE : FROM 값 뒤에 씀 // aa%(시작) %aa%(포함) %aa(끝남)
    select * from post where title like '%llo%';     --% => %사이에 있는llo가 단어 중간에있는 문자를 검색하겠다
    select * from post where title not like '%o';    --o로 끝나는 title이 아닌 title 검색

>> WHERE IN : 2가지 이상을 해당 범위에서 지정할때(?)
    WHERE MCDP_CD IN('CS', 'GS')
    (== WHERE MCDP_CD = "CS" OR MCDP_CD= "GS")

>> DATE_FORMAT *****사용多  : 날짜/시간 타입의 데이터를 지정된 형식의 문자열로 변환
    (DATE_FORMAT(date, format))
    DATE_FORMAT(HIRE_YMD, '%Y-%m-%d')  -- %Y-%m-%d // Y, mm, dd, H, i, s (Y만 대문자)
        +) NOW(): 현재 날짜와 시간을 반환

>> IF
    -- if 문  : if(a, b, c) => a가 참이면 b, 거짓이면 c  => 조건이 들어갔을 때는 if값 쓰기
    SELECT id, title, contents,
        IF(author_id is NULL, '익명사용자', author_id,)
        as author_id
    FROM post;

>> IFNULL
    SELECT id, title, contents,              --(끝에 ',' 들어가있어야 함)
        IFNULL(author_id, '익명사용자')
        as author_id
    FROM post;


-- 여러 기준으로 정렬하기 
    SELECT ANIMAL_ID, NAME, DATETIME 
    FROM ANIMAL_INS 
    ORDER BY NAME, DATETIME DESC;

-- 상위 n개 레코드 
        => LIMIT == 해당 값만 추출하기 // 아래 명령문 == NAME에 해당하는 가장 상단 값 1개만 추출
    SELECT NAME  FROM ANIMAL_INS ORDER BY DATETIME ASC LIMIT 1;

-- 경기도에 위치한 식품창고 목록 출력하기 
    SELECT WAREHOUSE_ID, WAREHOUSE_NAME, ADDRESS, IFNULL(FREEZER_YN, 'N')
    FROM FOOD_WAREHOUSE
    where ADDRESS like '%경기도%'
    ORDER BY WAREHOUSE_ID ASC;

-- 흉부외과 또는 일반외과 의사 목록 출력하기 
    SELECT DR_NAME, DR_ID, MCDP_CD, DATE_FORMAT(HIRE_YMD, '%Y-%m-%d')
    FROM DOCTOR 
    WHERE MCDP_CD = "CS" OR MCDP_CD= "GS"
    ORDER BY HIRE_YMD DESC, DR_NAME;

    SELECT DR_NAME, DR_ID, MCDP_CD, DATE_FORMAT(HIRE_YMD, '%Y-%m-%d')
    FROM DOCTOR 
    WHERE MCDP_CD IN('CS', 'GS')
    ORDER BY HIRE_YMD DESC, DR_NAME;


-- 조건에 부합하는 중고거래 상태 조회하기
    SELECT BOARD_ID, WRITER_ID, TITLE, PRICE
        CASE STATUS
            WHEN STATUS 'SALE' THEN '판매중' 
            WHEN STATUS 'RESERVED' THEN '예약중' 
            WHEN STATUS 'DONE' THEN '거래완료'
        END AS STATUS
    FROM USED_GOODS_BOARD WHERE CREATED_DATE = '2022-10-05'
      -- (지정된 타입쓰기 // date타입=> CREATED_DATE = '2022-10-05' // DATE_FORMAT타입 => DATE_FORMAT(CREATED_DATE, '%Y-%m-%d') = '2022-10-05')
    ORDER BY BOARD_ID DESC;


-- 프로그래머스 문제풀이 : 12세 이하인 여자 환자 목록 출력하기
    SELECT PT_NAME, PT_NO, GEND_CD, AGE,
        IFNULL(TLNO, 'NONE')
        AS TLNO
    FROM PATIENT WHERE AGE <=12
    ORDER BY AGE DESC, PT_NAME;


-- 12세 이하인 여자 환자 목록 출력하기
    -- 방법1
    SELECT PT_NAME, PT_NO, GEND_CD, AGE,
        IFNULL(TLNO, 'NONE')
        AS TLNO
    FROM PATIENT WHERE AGE <=12
    ORDER BY AGE DESC, PT_NAME;

    -- 방법2
    SELECT PT_NAME, PT_NO, GEND_CD, AGE,
        IF (TLNO IS NULL, 'NONE', TLNO)
        AS TLNO
    FROM PATIENT WHERE AGE <=12
    ORDER BY AGE DESC, PT_NAME;


-- 조건에 맞는 도서와 저자 출력 (자료타입 / 제약조건 먼저확인!)
    --(author 저자에 left join 하면 곤란 -> 안쓴 저자가 있을 수 있음
    -- -> nullable false == not null -> book left join은 가능, author left join은 안됨)
    SELECT b.BOOK_ID,  a.AUTHOR_NAME, b.PUBLISHED_DATE
    FROM AUTHOR a
    INNER JOIN BOOK b ON a.AUTHOR_ID = b.AUTHOR_ID
    WHERE b.CATEGORY = '경제'
    ORDER BY PUBLISHED_DATE;

    +) 시간까지 나오면 datetime
        SELECT b.BOOK_ID,  a.AUTHOR_NAME, date_format(b.PUBLISHED_DATE, '%Y-%m-%d') as PUBLISHED_DATE
        FROM AUTHOR a
        INNER JOIN BOOK b ON a.AUTHOR_ID = b.AUTHOR_ID
        WHERE b.CATEGORY = '경제'
        ORDER BY PUBLISHED_DATE;


-- 없어진 기록 찾기
    -- 방법1. join으로 풀 수 있는 문제
        --(: 한 쪽에 없는 값이 있기 때문에 left outer join 써야 함)
        SELECT o.ANIMAL_ID, o.NAME
        FROM ANIMAL_OUTS o
        LEFT OUTER JOIN ANIMAL_INS i
        ON i.ANIMAL_ID = o.ANIMAL_ID
        WHERE i.ANIMAL_ID IS NULL   --(i.ANIMAL_ID에만 null 있으므로 잘 선택해야함)
        ORDER BY o.ANIMAL_ID;

    -- 방법2. subquery로 풀어도 좋을것
        SELECT o.ANIMAL_ID, o.NAME
        FROM ANIMAL_OUTS o
        WHERE i.ANIMAL_ID NOT IN(SELECT i.ANIMAL_ID FROM ANIMAL_INS)
        ORDER BY ANIMAL_ID;


-- 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기 
        --(DISTINCT로 구분해서 쓸 수 있음)
    SELECT R.CAR_TYPE, COUNT(*) AS CARS  --(별칭 as 안써줘도 됨 : 비록 count(*) 같은 존재더라도)
    FROM CAR_RENTAL_COMPANY_CAR R
    WHERE OPTIONS LIKE '%통풍시트%' OR OPTIONS LIKE '%열선시트%' OR OPTIONS LIKE '%가죽시트%'
    GROUP BY CAR_TYPE
    ORDER BY CAR_TYPE;


-- 입양 시각 구하기(1)
    SELECT DATE_FORMAT(DATETIME, '%H') AS HOUR, COUNT(*) ANIMAL_OUTS GROUP BY DATETIME  --(CAST UNSIGNED 될 수 있어서 확인해야함)

    -- 방법1
    SELECT HOUR(DATETIME) HOUR AS HOUR, COUNT(*)COUNT
    FROM ANIMAL_OUTS
    WHERE HOUR(DATETIME) >= 9 AND HOUR(DATETIME) < 20
    GROUP BY DATETIME
    ORDER BY DATETIME;

    -- 방법2
    SELECT DATE_FORMAT(DATETIME, '%H') AS HOUR, COUNT(*)
    FROM ANIMAL_OUTS
    WHERE DATE_FORMAT(DATETIME, '%H:%i')    --(%i == 분 // 밑에 구체적인 분까지 넣어서 조건을 작성하였기 때문에 상단부분에 '분'까지 넣었음)
    BETWEEN '09:00' AND '19:59'
    GROUP BY HOUR ORDER BY HOUR;


-- 동명 동물 수 찾기
    -- : (GROUP BY / HAVING) 위치 기억하기 + 어떤 것으로 GROUP BY 하는지 이해하고 풀기!!
    SELECT NAME, COUNT(*) AS COUNT
    FROM ANIMAL_INS
    GROUP BY NAME
    HAVING COUNT >= 2
    WHERE NAME IS NOT NULL
    ORDER BY NAME;


 **** 다시보기
-- 재구매가 일어난 상품과 회원 리스트 구하기  
    SELECT USER_ID, COUNT(*) FROM ONLINE_SALE GROUP BY USER_ID,  PRODUCT_ID HAVING COUNT(*)>= ORDER BY USER_ID,  PRODUCT_ID








