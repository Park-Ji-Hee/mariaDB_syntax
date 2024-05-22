# https://app.diagrams.net/#G1p09GRYnhVVdOii9W_PfHS89prdQsGAc-#%7B%22pageId%22%3A%22R2lEEEUBdFMjLlhIrx00%22%7D
여기에 있는 ERD 내용을 코드로 짜거 
 
    -- 조건거는거 : created_time datetime defaul current_timestamp
    -- fk : 테이블 상에서 mull
    -- fk 2개 거는 법 : 요렇게 그냥 2개 쓰면 됨
        FOREIGN KEY(author_id) REFERENCES author(id),
        FOREIGN KEY(author_id) REFERENCES author(id));


create table author(
    id int AUTO_INCREMENT, 
    name varchar(255), 
    email varchar(255) not null, 
    created_time datetime default current_timestamp, 
    primary key(id), unique(email)
);


create table post(
    id int auto_increment,
    title varchar(255) not null,
    contents varchar(255),
    primary key(id)
);


create table author_address(
    id auto_increment,
    country varchar(255),
    city varchar(255),
    street varchar(255),
    author_id int not null, 
    primary key(id),
    unique(author_id),
    foreign key(author_id) references author(id)
    on delete cascade  -- (좀 찾아보기)
);


create table author_post(
    id int auto_increment primary key,
    author_id int not null,
    post_id int not null,
    foreign key(author_id) references author(id),
    foreign key(post_id) references post(id)
);
















