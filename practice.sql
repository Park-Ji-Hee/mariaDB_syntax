>> LIMIT *****사용多
    select * from author order by id desc limit 1; 
    (= author 테이블을 id 기준으로 올림차순하여 가장 상위 1개를 선택하겠다)

>> ORDER BY : 가장 마지막에 씀 // 순서조건 여러개일 때 같이 쓰면 됨 // 기본 디폴트 값 == ASC
    ORDER BY HIRE_YMD DESC, DR_NAME;

>> WHERE LIKE/NOT LIKE : FROM 값 뒤에 씀 // aa%(시작) %aa%(포함) %aa(끝남)
    select * from post where title like '%llo%'; --% => %사이에 있는llo가 단어 중간에있는 문자를 검색하겠다
    select * from post where title not like '%o'; --o로 끝나는 title이 아닌 title 검색

>> WHERE IN : 2가지 이상을 해당 범위에서 지정할때(?)
    WHERE MCDP_CD IN('CS', 'GS')
    (== WHERE MCDP_CD = "CS" OR MCDP_CD= "GS")

>> DATE_FORMAT *****사용多  : 날짜/시간 타입의 데이터를 지정된 형식의 문자열로 변환
    (DATE_FORMAT(date, format))
    DATE_FORMAT(HIRE_YMD, '%Y-%m-%d')  -- %Y-%m-%d // Y, mm, dd, H, i, s (Y만 대문자)
        +) NOW(): 현재 날짜와 시간을 반환

>> IF

>> IFNULL



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


