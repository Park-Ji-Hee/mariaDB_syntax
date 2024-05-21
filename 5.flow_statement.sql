-- 흐름제어 : case 문 (나열간능)
SELECT 컬럼1, 컬럼2, 컬럼3
CASE 컬럼4
    WHEN [비교값1] THEN 결과값1
    WHEN [비교값2] THEN 결과값2
    ELSE 결과값3
END 
 FROM 테이블명;

-- post테이블에서 1번 user는 first author, 2번 usesr는 second author
SELECT id, title, contents,
    case author_id
        WHEN 1 THEN 'first author'    --(when 뒤에 나오는 해당 컬럼에 되는 값 성립할 경우 실행됨)
        WHEN 2 THEN 'second author'
        ELSE 'other'
    END
FROM post;

**** (다시 보기!)
-- author_id가 있으면 그대로 출력 else author_id,
-- 없으면 '익명사용자'로 출력되도록 post테이블 조회
SELECT id, title, contents,
    case 
        when author_id is null THEN '익명사용자'   --(when is null THEN '익명사용자' => 문법깨짐 => is null의 주어를 넣어줌 )
        ELSE author_id
    END as author_id   --(select from 적용 시 'as ~'를 안넣어주면 컬럼 값에 select 뒤에 오는 값이 컬럼 제목으로 올라감 ==> 별칭 넣어주기)
FROM post;

-- case 문을 if문 / ifnull구문으로 변환
    (CASE문)
    -- author_id가 있으면 그대로 출력 else author_id,
    -- 없으면 '익명사용자'로 출력되도록 post테이블 조회
*****(다시보기)
-- if 문  : if(a, b, c) => a가 참이면 b, 거짓이면 c  => 조건이 들어갔을 때는 if값 쓰기
    SELECT id, title, contents,
        IF(author_id is NULL, '익명사용자', author_id,)
        as author_id
    FROM post;
-- ifnull구문
    SELECT id, title, contents,   --(끝에 ',' 들어가있어야 함)
        IFNULL(author_id, '익명사용자')
        as author_id
    FROM post;

+++) 다시풀어보기
-- 프로그래머스 문제풀이 : 조건에 부합하는 중고거래 상태 조회하기
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

    SELECT PT_NAME, PT_NO, GEND_CD, AGE,
        IF (TLNO IS NULL, 'NONE', TLNO)
        AS TLNO
    FROM PATIENT WHERE AGE <=12
    ORDER BY AGE DESC, PT_NAME;

-- 











