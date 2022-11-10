package com.its.member.board.controller;

import com.its.member.board.service.BoardService;
import com.its.member.common.SESSION_KEY;
import com.its.member.datamodel.BoardDTO;
import com.its.member.datamodel.MemberDTO;
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
                                  @RequestParam(value="pageCount", required = false, defaultValue = "5") int pageCount,
                                  Model model){
        // 현제 페이지에서 보여질 글목록
        List<BoardDTO> boardList = boardService.getPagingList(page, pageCount);
        // 하단의 페이지 번호목록을 위한 데이터
        PageDTO pageDTO = boardService.pagingParam(page, pageCount);
        model.addAttribute("paging", pageDTO);
        model.addAttribute("boardList", boardList);
        return "/board/boardList";
    }

    /**
     * 검색결과 페이징을 시도하다 실패한 컨트롤러
     * 아직 내공부족 mybatis 실제 실행 쿼리를 보면 좋겠지만 일단 잠시 뒤로 미룬다.
     */
//    @GetMapping("/boardSearch")
//    public String boardSearch(@RequestParam("searchQuery") String searchQuery,
//                              @RequestParam("searchType") String searchType,
//                              @RequestParam(value="page", required=false, defaultValue="1") int page,
//                              @RequestParam(value="pageCount", required = false, defaultValue = "5") int pageCount,
//                              Model model){
//        List<BoardDTO> boardDTOLit = boardService.getSearchedPagingList(page, pageCount, searchType, searchQuery);
//        PageDTO pageDTO = boardService.searchedPagingParam(page, pageCount,searchType, searchQuery);
//        model.addAttribute("paging", pageDTO);
//        model.addAttribute("boardList", boardDTOLit);
//        return "/board/boardList";
//    }

    @GetMapping("/boardSearch")
    public String boardSearch(@RequestParam("searchQuery") String searchQuery,
                              @RequestParam("searchType") String searchType,
                              Model model){
        List<BoardDTO> searchList = boardService.search(searchType, searchQuery);
        model.addAttribute("boardList", searchList);
        return "/board/boardSearch";
    }


    /**
     * 게시판 상세조회 컨트롤러
     * 상세조회 하고 싶은 게시판의 id 와, 게시판의 페이지 번호를 전달받는다.
     * 게시판의 조회수를 증가시킨다.
     * 게시판의 댓글정보도 같이 리턴한다.
     * @param boardId
     * @param page
     * @param model
     * @return
     */
    @GetMapping("/boardDetail")
    public String boardDetail(@RequestParam("boardId") long boardId,
                              @RequestParam(value="page", required = false, defaultValue = "1") long page,
                              Model model){
        // 조회수증가에 성공하면 true, 실패하면 false 를 반환하지만 사용하지는 않는다.
        boardService.increaseBoardHits(boardId);
        BoardDTO boardDTO = boardService.getBoardDetail(boardId);
        model.addAttribute("board", boardDTO); // 게시판 정보
        model.addAttribute("page", page); // 게시판의 페이지 번호
        return "/board/boardDetail";
    }

    @PostMapping("/boardUpdate")
    @ResponseBody
    public String boardUpdate(@RequestParam("boardId") long boardId,
                              @RequestParam("boardTitle") String boardTitle,
                              @RequestParam("boardContents") String boardContents){

        return boardService.boardUpdate(boardId, boardTitle, boardContents) ? "success" : "fail";
    }

    @GetMapping("/boardDelete")
    @ResponseBody
    public String boardDelete(@RequestParam("boardId") long boardId){
        return boardService.boardDelete(boardId) ? "success" : "fail";
    }


}
