package com.its.member.board.service;

import com.its.member.board.repository.MemberRepository;
import com.its.member.common.ConfigManager;
import com.its.member.datamodel.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MemberService {

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private ServletContext servletContext;

    /**
     * 회원의 이메일 중복을 검사하는 메서드
     * @param email
     * @return
     */
    public boolean checkDuplicatedEamil(String email) {
        return memberRepository.checkDuplicatedEmail(email) > 0;
    }

    /**
     * 프로필 이미지 작업
     * 회원의 프로필이미지는 1개이며 파일이름으로 member_table 테이블의 memberProfile 에 저장된다.
     * 현재 시스템에선 DB에 insert 하기전엔 회원 id를 알수없으므로 뷰에서 중복체크를 거친 회원의 이메일을
     * 유니크한 식별자로 사용한다. 따라서 회원의 프로필이미지 파일 이름은 "회원이메일-프로일이미지파일이름" 으로 설정
     * 회원이 프로필을 설정하지 않으면 DB에 null 값으로 insert 한다.
     * 회원정보를 리턴할때는 지정된 프로필이미지가 없으면 디폴트이미지로 보여줘야 한다.
     * @param memberDTO
     * @return
     */
    public boolean signUp(MemberDTO memberDTO) {
        // 프로필이 없으면 DB에 null 값으로 insert 된다.
        saveProfile(memberDTO);
        return memberRepository.signUp(memberDTO) > 0;
    }

    /**
     * 회원가입한 유저의 프로필이미지를 처리한다.
     * @param memberDTO
     */
    private void saveProfile(MemberDTO memberDTO){
        if(memberDTO.getProfileFile() == null){
            memberDTO.setProfileAttached(0);
            return;
        }
        MultipartFile profile = memberDTO.getProfileFile();
        String originalFileName = profile.getOriginalFilename();
        String storedFileName = memberDTO.getMemberEmail() + "-" + originalFileName;
        memberDTO.setMemberProfile(originalFileName);
        // 프로필이미지 저장
        try{
            String contextPath = ConfigManager.MEMBER_PROFILE_SAVE_PATH + storedFileName;
            File profileFile = new File(contextPath);
            profile.transferTo(profileFile);
        }catch(IOException ioe){
            ioe.printStackTrace();
        }
        memberDTO.setProfileAttached(1);
    }

    public MemberDTO signIn(String memberEmail, String memberPassword) {
        return memberRepository.isSignIn(memberEmail, memberPassword);
    }

    public List<MemberDTO> memberList() {
        return memberRepository.memberList();
    }

    public boolean memberDelete(long id) {
        return memberRepository.memberDelete(id) > 0;
    }

    public MemberDTO getMemberInfo(long id) {
        return memberRepository.getMemberInfo(id);
    }

    public boolean updateMemeberInfo(MemberDTO memberDTO) {
        return memberRepository.updateMemberInfo(memberDTO) > 0;
    }

    public boolean checkMemberPassword(String pw, long id) {
        String originalPW = memberRepository.getMemberPassword(id);
        return pw.equals(originalPW);
    }
}
