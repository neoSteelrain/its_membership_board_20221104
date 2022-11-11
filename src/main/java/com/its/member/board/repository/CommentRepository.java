package com.its.member.board.repository;

import com.its.member.datamodel.CommentDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class CommentRepository {

    @Autowired
    private SqlSessionTemplate sql;

    public int commentWrite(CommentDTO comment) {
        return sql.insert("commentWrite", comment);
    }

    public List<CommentDTO> getCommentListByBoardId(long boardId) {
        return sql.selectList("getCommentListByBoardId", boardId);
    }
}
