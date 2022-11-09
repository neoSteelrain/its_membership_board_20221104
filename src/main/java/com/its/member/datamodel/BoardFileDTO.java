package com.its.member.datamodel;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

/**
 * 게시물 첨부파일에 대한 DTO 클래스
 * DB의 board_file_table 테이블과 매칭된다.
 * 첨부파일 id
 * 파일이름의 원래이름
 * 서버에 저장하기 위해 재설정된 이름
 * 첨부파일이 첨부된 게시물의 id
 */
@Data
public class BoardFileDTO {
    private long id;
    private String originalFileName;
    private String storedFileName;
    private long boardId;
}
