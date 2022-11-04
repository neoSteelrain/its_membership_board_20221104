CREATE TABLE `member_table` (
   `id` bigint unsigned NOT NULL AUTO_INCREMENT,
   `memberEmail` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL unique,
   `memberPassword` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
   `memberName` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
   `memberMobile` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `memberProfile` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `board_table` (
   `id` bigint unsigned NOT NULL AUTO_INCREMENT,
   `boardTitle` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
   `boardWriter` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
   `boardContents` varchar(4000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   `boardHits` int unsigned DEFAULT '0',
   `boardCreatedDate` datetime DEFAULT CURRENT_TIMESTAMP,
   `boardFileName` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
   PRIMARY KEY (`id`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
 
CREATE TABLE comment_table (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  boardId BIGINT UNSIGNED not null,
  commentWriter VARCHAR(50) not null,
  commentCreatedDate DATETIME DEFAULT now(),
  PRIMARY KEY (id),
  constraint fk_comment foreign key(boardId) references board_table(id) on delete cascade)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;