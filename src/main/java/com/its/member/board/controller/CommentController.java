package com.its.member.board.controller;

import com.its.member.board.service.CommentService;
import com.its.member.datamodel.CommentDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private CommentService commentService;

    @PostMapping("/commentWrite")
    @ResponseBody
    public List<CommentDTO> commentWrite(@ModelAttribute CommentDTO comment){
        boolean isWrited = commentService.commentWrite(comment);
        List<CommentDTO> result = commentService.getCommentListByBoardId(comment.getBoardId());
        return result;
    }
}
