package com.its.member.datamodel;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Timestamp;
import java.util.ArrayList;

/**
 * 게시물을 나타내는 DTO 클래스
 * DB의 board_table 과 매칭된다.
 * - 게시물 id
 * - 제목
 * - 작성자 이름
 * - 내용
 * - 조회수
 * - 작성일
 * - 비밀번호
 * - 작성자 id
 * - 첨부파일 리스트
 */

@Data
public class BoardDTO {
    private long id;
    private String boardTitle;
    private String boardWriter;
    private String boardContents;
    private String boardPassword;
    private int boardHits;
    private Timestamp boardCreatedDate;
    private long memberId;
    private MultipartFile[] boardFileList;
    private BoardFileDTO[] attachedFiles;
}
