package com.its.member.board.controller;

import com.its.member.board.service.BoardService;
import com.its.member.common.SESSION_KEY;
import com.its.member.datamodel.BoardDTO;
import com.its.member.datamodel.PageDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardService boardService;

    /**
     * 게사판 전제목록 페이지로 가는 컨트롤러
     * @return
     */
//    @GetMapping("/boardList")
//    public String boardList(){
//        return "/board/boardList";
//    }

    /**
     * 게시물을 새로 등록하는 페이지로 가는 컨트롤러
     * @return
     */
    @GetMapping("/boardReg")
    public String boardReg(){
        return "/board/boardReg";
    }

    /**
     * 게시물을 등록하는 컨트롤러
     * 첨부파일을 여러개 첨부할수있다.
     * @param boardDTO
     * @param session
     * @return
     */
    @PostMapping("/boardReg")
    @ResponseBody
    public String boardRegister(@ModelAttribute BoardDTO boardDTO, HttpSession session){
        boolean isRegister = boardService.boardRegister(boardDTO,
                                                     (long)session.getAttribute(SESSION_KEY.ID),
                                                     (String)session.getAttribute(SESSION_KEY.MEMBER_EMAIL));

        return isRegister ? "success" : "fail";
    }

    /**
     * 게시물목록 페이지로 가는 컨트롤러
     * @return
     */
    @GetMapping("/")
    public String boardListPage(){
        return "/board/boardList";
    }

    /**
     * 게시물 페이징 처리 컨트롤러
     * @param page
     * @param model
     * @return
     */
    @GetMapping("/boardList")
    public String boardListPaging(@RequestParam(value="page", required=false, defaultValue="1") int page,
                                  @RequestParam("pageCount") int pageCount,
                                  Model model){
        // 현제 페이지에서 보여질 글목록
        List<BoardDTO> boardList = boardService.getPagingList(page, pageCount);
        // 하단의 페이지 번호목록을 위한 데이터
        PageDTO pageDTO = boardService.pagingParam(page, pageCount);
        model.addAttribute("paging", pageDTO);
        model.addAttribute("boardList", boardList);
        return "/board/boardList";
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
