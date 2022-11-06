package com.its.member.board.controller;

import com.its.member.board.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
    public String memberSignUp(){
        return "/member/signUp";
    }

    @GetMapping("/checkDuplicatedEmail")
    @ResponseBody
    public String checkDuplicatedEmail(@RequestParam("email") String email){
        boolean isDuplicated = memberService.checkDuplicatedEamil(email);
        return isDuplicated ? "yes" : "no";
    }
}
