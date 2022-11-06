package com.its.member.board.service;

import com.its.member.board.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

    @Autowired
    private MemberRepository memberRepository;

    public boolean checkDuplicatedEamil(String email) {
        return memberRepository.checkDuplicatedEmail(email) > 0;
    }
}
