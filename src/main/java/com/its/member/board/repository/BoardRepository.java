package com.its.member.board.repository;

import com.its.member.datamodel.BoardDTO;
import com.its.member.datamodel.BoardFileDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class BoardRepository {

    @Autowired
    private SqlSessionTemplate sql;

    public BoardDTO registerBoard(BoardDTO boardDTO) {
        sql.insert("Board.registerBoard", boardDTO);
        return boardDTO;
    }

    public int registerAttachedFile(BoardFileDTO fileDTO) {
        return sql.insert("Board.registerAttachedFile", fileDTO);
    }

    public List<BoardDTO> getPageList(Map<String, Integer> pagingParams) {
        return sql.selectList("Board.pagingList", pagingParams);
    }

    public int getTotalBoardCount() {
        return sql.selectOne("Board.totalBoardCount");
    }

    public BoardDTO getBoardDetail(long boardId) {
        return sql.selectOne("Board.boardDetail", boardId);
    }

    public int increaseBoardHits(long boardId) {
        return sql.update("Board.increaseBoardHits", boardId);
    }

    public int boardUpdate(BoardDTO boardDTO) {
        return sql.update("Board.boardUpdate", boardDTO);
    }

    public int boardDelete(long boardId) {
        return sql.delete("Board.boardDelete", boardId);
    }

    public List<BoardDTO> boardSearch(Map param) {
        return sql.selectList("Board.boardSearch", param);
    }

    public int getTotalSearchedBoardCount(Map<String, String> param) {
        return sql.selectOne("Board.totalSearchedBoardCount", param);
    }

    public List<BoardDTO> search(Map<String, String> searchParams) {
        return sql.selectList("Board.search", searchParams);
    }
}
