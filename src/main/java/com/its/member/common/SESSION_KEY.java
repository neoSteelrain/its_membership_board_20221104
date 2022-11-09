package com.its.member.common;

/**
 * 세션에 저장될 회원의 정보를 보다 쉽게 접근하기 위해 정의한
 * 회원정보를 설정하는 키값들
 * MemberDTO 에 있는 속성들은 전부들어가도록 한다.
 */
public class SESSION_KEY {
    /*
    private long id;
    private String memberName;
    private String memberEmail;
    private String memberMobile;
    private String memberPassword;

    // 회원의 프로필이미지 파일 이름
    private String memberProfile;
     */
    public final static String ID = "id";
    public final static String MEMBER_NAME = "memberName";
    public final static String MEMBER_EMAIL = "memberEmail";
    public final static String MEMBER_MOBILE = "memberMobile";
    public final static String MEMBER_PROFILE_FILE_NAME = "memberProfile";
}
