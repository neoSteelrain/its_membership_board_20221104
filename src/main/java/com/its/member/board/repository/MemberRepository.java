package com.its.member.board.repository;

import com.its.member.datamodel.MemberDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository
public class MemberRepository {

    @Autowired
    private SqlSessionTemplate sql;

    public int checkDuplicatedEmail(String email) {
        return sql.selectOne("Member.checkDuplicatedEmail", email);
    }

    public int signUp(MemberDTO memberDTO) {
        return sql.insert("Member.memberSignUp", memberDTO);
    }

    public MemberDTO isSignIn(String memberEmail, String memberPassword) {
        Map<String, String> signInParam = new HashMap<>();
        signInParam.put("email", memberEmail);
        signInParam.put("pw", memberPassword);
        return sql.selectOne("Member.memberSignIn", signInParam);
    }
}
