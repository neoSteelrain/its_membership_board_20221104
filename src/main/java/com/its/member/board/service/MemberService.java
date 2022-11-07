package com.its.member.board.service;

import com.its.member.board.repository.MemberRepository;
import com.its.member.datamodel.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

    @Autowired
    private MemberRepository memberRepository;

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
    public void signUp(MemberDTO memberDTO) {

        // 프로필이 없으면 DB에 null 값으로 insert 한다.
        if(memberDTO.getMemberProfile() == null){
            memberDTO.setProfileAttached(0);
            MemberDTO signUpMemberDTO = memberRepository.signUp(memberDTO);
        }
    }
}
