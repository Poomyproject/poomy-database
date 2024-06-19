use poomydb;

create table if not exists users(
    id mediumint unsigned auto_increment primary key,
    google_email varchar(63) not null unique ,
    nick_name varchar(7) not null unique,
    img_url varchar(255) null comment '유저 이미지',
    description varchar(127) null,
    created_at timestamp default CURRENT_TIMESTAMP ,
    updated_at timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
);

create table if not exists atmospheres(
    id tinyint unsigned auto_increment primary key,
    name varchar(15) not null unique,
    img_url varchar(255) not null,
    prefix varchar(15) not null
);

create table if not exists user_atmospheres(
    id bigint unsigned auto_increment primary key,
    user_id mediumint unsigned not null,
    atmosphere_id tinyint unsigned not null,
    created_at timestamp default CURRENT_TIMESTAMP,
    updated_at timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    unique key unique_userId_atmosphereId (user_id, atmosphere_id),
    constraint fk_userAtmospheres_atmosphereId foreign key (atmosphere_id) references atmospheres (id) on delete cascade,
    constraint fk_userAtmospheres_userId foreign key (user_id) references users (id) on delete cascade
);

create table if not exists hot_places(
    id tinyint unsigned auto_increment primary key,
    name varchar(15) not null unique ,
    img_url varchar(255) not null,
    latitude float not null comment '위도',
    longitude float not null comment '경도'
);

create table if not exists user_hot_places(
    id bigint unsigned auto_increment primary key,
    user_id mediumint unsigned not null,
    hot_place_id tinyint unsigned not null,
    created_at timestamp default CURRENT_TIMESTAMP,
    updated_at timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    unique key unique_userId_hotPlaceId (user_id, hot_place_id),
    constraint fk_userHotPlaces_hotPlaceId foreign key (hot_place_id) references hot_places (id) on delete cascade,
    constraint fk_userHotPlaces_userId foreign key (user_id) references users (id) on delete cascade
);

create table if not exists poom_shops(
    id smallint unsigned auto_increment primary key,
    name varchar(31) not null,
    location varchar(15) not null,
    nearby_station varchar(15) not null,
    start_time time null,
    end_time time null,
    phone_number varchar(15) null,
    latitude float not null comment '위도',
    longitude float not null comment '경도',
    hot_place_id tinyint unsigned null,
    atmosphere_id tinyint unsigned null,
    created_at timestamp default CURRENT_TIMESTAMP,
    updated_at timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    constraint fk_poomShops_hotPlaceId foreign key (hot_place_id) references hot_places(id) on delete set null,
    constraint fk_poomShops_AtmosphereId foreign key (atmosphere_id) references atmospheres (id) on delete set null
);

create table if not exists poom_shop_imgs(
    id mediumint unsigned auto_increment primary key,
    url varchar(255) not null,
    poom_shop_id smallint unsigned not null,
    created_at timestamp default CURRENT_TIMESTAMP,
    updated_at timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    constraint fk_poomShopImgs_poomShopId foreign key (poom_shop_id) references poom_shops(id) on delete cascade
);

create table if not exists user_favorite_poom_shops(
    id bigint unsigned auto_increment primary key,
    user_id mediumint unsigned not null,
    poom_shop_id smallint unsigned not null,
    created_at timestamp default CURRENT_TIMESTAMP,
    updated_at timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    unique key unique_userId_poomShopId (user_id, poom_shop_id),
    constraint fk_userFavoritePoomShops_userId foreign key (user_id) references users (id) on delete cascade,
    constraint fk_userFavoritePoomShops_poomShopId foreign key (poom_shop_id) references poom_shops(id) on delete cascade
);

create table if not exists reviews(
    id bigint unsigned auto_increment primary key,
    is_recommend bool not null,
    user_id mediumint unsigned not null,
    poom_shop_id smallint unsigned not null,
    content varchar(511) null,
    created_at timestamp default CURRENT_TIMESTAMP,
    updated_at timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    constraint fk_reviews_userId foreign key (user_id) references users (id) on delete cascade,
    constraint fk_reviews_poomShopId foreign key (poom_shop_id) references poom_shops(id) on delete cascade
);

create table if not exists review_imgs(
    id bigint unsigned auto_increment primary key,
    url varchar(255) not null,
    review_id bigint unsigned not null,
    created_at timestamp default CURRENT_TIMESTAMP,
    updated_at timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    constraint fk_reviewImgs_reviewId foreign key (review_id) references reviews (id) on delete cascade
);

create table if not exists review_atmospheres(
    id bigint unsigned auto_increment primary key,
    review_id bigint unsigned not null,
    atmosphere_id tinyint unsigned null,
    created_at timestamp default CURRENT_TIMESTAMP,
    updated_at timestamp default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
    constraint fk_reviewAtmosphere_reviewId foreign key (review_id) references reviews (id) on delete cascade,
    constraint fk_reviewAtmosphere_AtmosphereId foreign key (atmosphere_id) references atmospheres (id) on delete set null
);

create table if not exists news_letters(
    id tinyint unsigned auto_increment primary key,
    title varchar(31) not null,
    thumbnail varchar(511) not null comment '뉴스레터 썸네일 이미지 url',
    sub_title varchar(31) not null,
    explanation varchar(255) not null
);

create table if not exists news_letter_poom_shops(
    id smallint unsigned auto_increment primary key,
    news_letter_id tinyint unsigned not null,
    poom_shop_id smallint unsigned not null,
    one_line_intro varchar(31) not null,
    recommend_reason varchar(255) not null,
    img_url_1 varchar(511) null,
    img_url_2 varchar(511) null,
    constraint fk_newsLetterPoomShops_newsLetterId foreign key (news_letter_id) references news_letters (id) on delete cascade,
    constraint fk_newsLetterPoomShops_poomShopId foreign key (poom_shop_id) references poom_shops (id) on delete cascade
);

create table if not exists hashtags(
    id smallint unsigned auto_increment primary key,
    name varchar(15) not null
);

create table if not exists news_letter_hashtags(
    id mediumint unsigned auto_increment primary key,
    news_letter_id tinyint unsigned not null,
    hashtag_id smallint unsigned not null,
    constraint fk_newsLetterHashtags_newsLetterId foreign key (news_letter_id) references news_letters (id) on delete cascade,
    constraint fk_newsLetterHashtags_hashtagId foreign key (hashtag_id) references hashtags(id) on delete cascade
);


