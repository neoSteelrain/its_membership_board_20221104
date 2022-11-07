package com.its.member.board.repository;

import com.its.member.datamodel.MemberDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberRepository {

    @Autowired
    private SqlSessionTemplate sql;

    public int checkDuplicatedEmail(String email) {
        return sql.selectOne("Member.checkDuplicatedEmail", email);
    }

    public MemberDTO signUp(MemberDTO memberDTO) {
        sql.insert("Member.memberSignUp", memberDTO);
        return memberDTO;
    }
}
