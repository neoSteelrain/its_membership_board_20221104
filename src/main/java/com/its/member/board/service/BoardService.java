package com.its.member.board.service;

import com.its.member.board.repository.BoardRepository;
import com.its.member.common.ConfigManager;
import com.its.member.common.PageingConst;
import com.its.member.datamodel.BoardDTO;
import com.its.member.datamodel.BoardFileDTO;
import com.its.member.datamodel.MemberDTO;
import com.its.member.datamodel.PageDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BoardService {

    @Autowired
    private BoardRepository boardRepository;


    private boolean saveAttachedFiles(BoardDTO boardDTO, String memberEmail){
        if(boardDTO.getBoardFileList() == null || boardDTO.getBoardFileList().length == 0)
            return true; // 게시물만 등록할 수 있으므로 첨부파일도 없어도 정상이다.

        // 이제 boardId가 만들어졌다.
        MultipartFile[] files = boardDTO.getBoardFileList();
        BoardFileDTO fileDTO = null;
        String originalFileName = null;
        String storedFileName = null;
        try{
            for( MultipartFile file : files){
                fileDTO = new BoardFileDTO();
                originalFileName = file.getOriginalFilename();
                storedFileName = memberEmail+"-"+ originalFileName;
                fileDTO.setOriginalFileName(originalFileName);
                fileDTO.setStoredFileName(storedFileName);
                fileDTO.setBoardId(boardDTO.getId());
                if(boardRepository.registerAttachedFile(fileDTO) == 0)
                    return false;

                // 이제 첨부파일을 실제로 디스크에 저장한다.
                file.transferTo(new File(ConfigManager.MEMBER_ATTACHED_FILE_SAVE_PATH + storedFileName));
            }
        }catch (IOException ioe){
            ioe.printStackTrace();
            return false;
        }
        return true;
    }

    /**
     *  BoardFileDTO 에 boardId를 넣어주려면 먼저 boardDTO를 DB에 insert하고 DB에서 생성된 boardId를 받아와야 한다.
     *  1. boardId를 얻은 다음 BordFileDTO 에 넣어준다.
     *  2. 첨부파일을 디스크에 저장한다.
     *  3. 첨부파일을 DB에 저장한다.
     *  4. 전부 하나의 트랜잭션에 걸어야 하지만 아직 더 공부해야...나중에 트랜잭션 걸어야 한다.
     * @param boardDTO
     * @param memberId
     * @param memberEmail
     * @return
     */
    public boolean boardRegister(BoardDTO boardDTO, long memberId, String memberEmail) {
        boardDTO.setMemberId(memberId);
        boardDTO = boardRepository.registerBoard(boardDTO);
        // 이제 boardId가 만들어졌으니 첨부파일들을 저장하고 성공이냐 실패냐 리턴한다.
        return saveAttachedFiles(boardDTO, memberEmail);
    }

    /**
     * page값 번째에 해당하는 화면에 보여줄 pageCount값 만큼의 게시물목록을 반환하는 서비스
     * ex) page = 2 이면 2페이지에 해당하는 게시물목록을 반환
     * @param page 이동하고자 하는 페이지
     * @param pageCount 한 페이지에 보여질 게시물의 갯수
     * @return
     */
    public List<BoardDTO> getPagingList(int page, int pageCount) {
        /*
        limit start, offset : 페이징 쿼리에 들어가야 하는 형식
        pageStart, pageCount : service 에서 만들어줘야 하는 값들

        페이징 처리는 아래와 같이 처리됨.
        시작페이지번호, 한번에 표시할 게시글의 갯수
        페이지 값이 1이면 0
        첫번째 페이지
        select * from board_table order by id desc limit 0, 3;
        두번째 페이지
        select * from board_table order by id desc limit 3, 3;
        세번째 페이지
        select * from board_table order by id desc limit 6, 3;

        myBatis의 mapper에 들어갈 쿼리형식
        select id, boardTitle, boardWriter, boardContents, boardHits, boardCreatedDate
        from board_table
        order by boardHits desc limit #{offset}, #{pageCount};
         */
        int pageStart = (page-1) * pageCount;
        Map<String, Integer> pagingParams = new HashMap<>();
        pagingParams.put("offset", pageStart);
        pagingParams.put("pageCount", pageCount);
        return boardRepository.getPageList(pagingParams);
    }

    public PageDTO pagingParam(int page, int pageCount) {
        int totalBoardCount = boardRepository.getTotalBoardCount();
        int maxPage = (int) Math.ceil( (double) totalBoardCount / pageCount);
        int startPage =(((int) (int)Math.ceil( (double)page / PageingConst.BLOCK_LIMIT)) -1) * PageingConst.BLOCK_LIMIT + 1;
        int endPage = startPage + PageingConst.BLOCK_LIMIT -1;

        if(endPage > maxPage){
            endPage = maxPage;
        }
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setStartPage(startPage);
        pageDTO.setEndPage(endPage);
        pageDTO.setMaxPage(maxPage);
        return pageDTO;
    }
}
