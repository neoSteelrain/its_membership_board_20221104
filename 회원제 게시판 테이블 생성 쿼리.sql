create database db_springframework;
use db_springframework;
create user 'user_springframework'@'localhost' identified by '1234';
grant all privileges on db_springframework.* to user_springframework@localhost;

CREATE TABLE `member_table` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `memberEmail` VARCHAR(255) COLLATE utf8mb4_unicode_ci NOT NULL UNIQUE,
    `memberPassword` VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL,
    `memberName` VARCHAR(20) COLLATE utf8mb4_unicode_ci NOT NULL,
    `memberMobile` VARCHAR(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `memberProfile` VARCHAR(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

    CREATE TABLE `board_table` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `boardTitle` VARCHAR(100) COLLATE utf8mb4_unicode_ci NOT NULL,
    `boardWriter` VARCHAR(50) COLLATE utf8mb4_unicode_ci NOT NULL,
    `boardContents` VARCHAR(2000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `boardHits` INT UNSIGNED DEFAULT '0',
    `boardCreatedDate` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `boardFileName` VARCHAR(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
    `memberId` BIGINT UNSIGNED NOT NULL,
    constraint fk_board_table_memberId foreign key(memberId) references member_table(id) on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `comment_table` (
     `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
     `boardId` BIGINT UNSIGNED NOT NULL,
     `memberId` BIGINT UNSIGNED NOT NULL,
     `commentWriter` VARCHAR(50) NOT NULL,
     `comment_contents` VARCHAR(500),
     `commentCreatedDate` DATETIME DEFAULT CURRENT_TIMESTAMP,
     constraint fk_comment_memberId foreign key(memberId) references member_table(id) on delete cascade,
     constraint fk_comment_boardId foreign key(boardId) references board_table(id) on delete cascade
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;