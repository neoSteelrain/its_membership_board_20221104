package com.its.member.board.controller;

import com.its.member.board.service.MemberService;
import com.its.member.common.SESSION_KEY;
import com.its.member.datamodel.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    /**
     * 회원가입 페이지로 이동하기 위한 컨트롤러
     * @return
     */
    @GetMapping("/sign-up")
    public String memberSignUpPage(){
        return "/member/signUp";
    }

    /**
     * 로그인 페이지로 이동하기 위한 컨트롤러
     * @return
     */
    @GetMapping("/sign-in")
    public String memberSignInPage(){
        return "/member/signIn";
    }

    /**
     * 관리자 페이지로 이동하기 위한 컨트롤러
     * @return
     */
    @GetMapping("/admin")
    public String adminPage(){
        return "/member/admin";
    }
    
    /**
     * 회원록록 페이지를 처리하기 위한 컨트롤러
     * @return
     */
    @GetMapping("/")
    public String memberList(Model model){
        List<MemberDTO> memberDTOList = memberService.memberList();
        model.addAttribute("memberList", memberDTOList);
        return "/member/memberList";
    }

    @GetMapping("/memberDelete")
    @ResponseBody
    public String memberDelete(@RequestParam("id") long id){
        boolean isDeleted = memberService.memberDelete(id);
        return isDeleted ? "success" : "fail";
    }

    /**
     * 로그인페이지를 처리하는 컨트롤러
     * @param memberEmail
     * @param memberPassword
     * @param httpSession
     * @return
     */
    @PostMapping("/sign-in")
    @ResponseBody
    public String memberSignIn(@RequestParam("memberEmail") String memberEmail,
                               @RequestParam("memberPassword") String memberPassword,
                               HttpSession httpSession){
        MemberDTO memberDTO = memberService.signIn(memberEmail, memberPassword);
        if(memberDTO == null){
            return "fail";
        }
        /*
            세션에는 회원의 id, 이메일, 이름, 전화번호, 프로필이미지 파일이름이 저장한다.
         */
        httpSession.setAttribute(SESSION_KEY.ID, memberDTO.getId());
        httpSession.setAttribute(SESSION_KEY.MEMBER_NAME, memberDTO.getMemberName());
        httpSession.setAttribute(SESSION_KEY.MEMBER_EMAIL, memberDTO.getMemberEmail());
        httpSession.setAttribute(SESSION_KEY.MEMBER_MOBILE, memberDTO.getMemberMobile());
        httpSession.setAttribute(SESSION_KEY.MEMBER_PROFILE_FILE_NAME, memberDTO.getMemberProfile());

        return "success";
    }

    /**
     * 로그아웃 컨트롤러
     * 로그아웃 하고 index.jsp 리다이렉트한다.
     * @param session
     * @return
     */
    @GetMapping("/signOut")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }


    /**
     * 이메일 중복체크를 위한 컨트롤러
     * 뷰에서 ajax 호출용으로 만들어짐
     * @param email 중복체크할 이메일주소
     * @return 중복이면 yes , 새로운 이메일주소이면 no 문자열 반환
     */
    @GetMapping("/checkDuplicatedEmail")
    @ResponseBody
    public String checkDuplicatedEmail(@RequestParam("email") String email){
        boolean isDuplicated = memberService.checkDuplicatedEamil(email);
        return isDuplicated ? "yes" : "no";
    }

    /**
     * 회원가입을 처리하는 컨트롤러
     * <p>
     * 회원가입 뷰에서 이메일 중복체크를 통해 중복회원가입여부를 판단하기 때문에
     * 별도의 중복 회원가입 여부를 판단하지는 않는다.
     * 회원가입을 완료하면 로그인 페이지로 이동한다.
     * </p>
     * @param memberDTO
     * @return ajax 응답메시지, 회원가입 성공 == "yes"
     */
    @PostMapping(value = "/sign-up")
    @ResponseBody()
    public String memberSignUp(@ModelAttribute MemberDTO memberDTO){
        return memberService.signUp(memberDTO) ? "yes" : "no";
    }


}
