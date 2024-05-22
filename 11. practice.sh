# 1. linux에 db설치 (git에다가 파일 올림)
# 2. -> local의 dump 작업 후 sql쿼리 생성 (git에서 colon 전체로 받기)
# 3. -> linux에서 해당 쿼리 실행
# local 컴퓨터의 boardDB -> 마이그레이션 -> linux 이전


# local에서 sql 덤프파일 생성
mysqldump -u root -p --default-character-set=utf8mb4 board > dumfile.sql

# 한글이 깨질 때
mysqldump -uroot -p board -r dumpfile.sql


# dump파일을 github에 업로드

# 리눅스에서 mariadb 서버 설치
sudo apt-get install mariadb-server

# mariadb 서버 시작
sudo systemctl start mariadb

# mariadb 접속 테스트
sudo mariadb -u root -p

# 






