package com.its.member.board.controller;

import com.its.member.datamodel.BoardDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/board")
public class BoardController {

    /**
     * 게사판 전제목록 페이지로 가는 컨트롤러
     * @return
     */
    @GetMapping("/boardList")
    public String boardList(){
        return "/board/boardList";
    }

    /**
     * 게시물을 새로 등록하는 페이지로 가는 컨트롤러
     * @return
     */
    @GetMapping("/boardReg")
    public String boardReg(){
        return "/board/boardReg";
    }

    @PostMapping("/boardReg")
    @ResponseBody
    public String boardRegister(@ModelAttribute BoardDTO boardDTO){
        System.out.println("BoardController.boardRegister");
        System.out.println("boardDTO = " + boardDTO);
        return "success";
    }

//    // 페이징목록
//    @GetMapping("/paging")
//    public String paging(Model model,
//                         @RequestParam(value = "page", required = false, defaultValue = "1") int page) {
////        System.out.println("page = " + page);
//        // 해당 페이지에서 보여줄 글 목록
//        List<BoardDTO> pagingList = boardService.pagingList(page);
//        // 하단 페이지 번호 표현을 위한 데이터
//        PageDTO pageDTO = boardService.pagingParam(page);
//        model.addAttribute("boardList", pagingList);
//        model.addAttribute("paging", pageDTO);
//        return "boardPages/boardPaging";
//    }
}
