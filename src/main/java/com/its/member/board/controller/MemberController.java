package com.its.member.board.controller;

import com.its.member.board.service.MemberService;
import com.its.member.datamodel.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpSession;

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
     * @return 로그인 페이지
     */
    @PostMapping(value = "/sign-up")
    @ResponseBody
    public String memberSignUp(@ModelAttribute MemberDTO memberDTO){
        System.out.println("request = " + memberDTO);
        //memberService.signUp(memberDTO);
        return "yes";
    }
}
