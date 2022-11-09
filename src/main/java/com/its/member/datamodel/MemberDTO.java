package com.its.member.datamodel;

import lombok.*;
import org.springframework.lang.Nullable;
import org.springframework.web.multipart.MultipartFile;

/**
 *  회원정보를 나타내는 DTO
 *  DB의 member_table 테이블과 매칭된다.
 */
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class MemberDTO {
    private long id;
    private String memberName;
    private String memberEmail;
    private String memberMobile;
    private String memberPassword;

    // 회원의 프로필이미지 파일 이름
    private String memberProfile;

    // 프로필이미지 객체
    private MultipartFile profileFile;

    /*
    회원이 업로드한 프로필이미지가 있는지 나타내는 플래그
    1 : 이미지 있음 , 0 : 이미지 없음, 디폴트 이미지로 대체 해야한다.
    */
    private int profileAttached;
}
