package com.its.member.datamodel;

import lombok.Data;

import java.sql.Timestamp;

/**
 * 게시물에 대한 댓글을 나타내는 DTO 클래스
 * 댓글 id
 * 게시물 id
 * 작성자 id
 * 작성자 이름
 * 내용
 * 댓글작성 생성시간
 */
@Data
public class CommentDTO {
    private long id;
    private long boardId;
    private long memberId;
    private String commentWriter;
    private String comment_contents;
    private Timestamp commentCreatedDate;
}
