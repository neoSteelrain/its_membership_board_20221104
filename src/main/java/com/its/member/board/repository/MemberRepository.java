package com.its.member.board.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberRepository {

    @Autowired
    private SqlSessionTemplate sql;

    public int checkDuplicatedEmail(String email) {
        return sql.selectOne("User.checkDuplicatedEmail", email);
    }
}
