package com.its.member.board.service;

import com.its.member.board.repository.CommentRepository;
import com.its.member.datamodel.CommentDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {

    @Autowired
    private CommentRepository commentRepository;

    public boolean commentWrite(CommentDTO comment) {
        return commentRepository.commentWrite(comment) > 0;
    }

    public List<CommentDTO> getCommentListByBoardId(long boardId) {
        return commentRepository.getCommentListByBoardId(boardId);
    }
}
