package com.cos.photogram.web.api;

import com.cos.photogram.config.auth.PrincipalDetails;
import com.cos.photogram.domain.comment.Comment;
import com.cos.photogram.service.CommentService;
import com.cos.photogram.web.dto.CMRespDto;
import com.cos.photogram.web.dto.comment.CommentDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
public class CommentApiController {

    private final CommentService commentService;

    @PostMapping("/api/comment")
    public ResponseEntity<?>commentSave(@RequestBody CommentDto commentDto, @AuthenticationPrincipal PrincipalDetails principalDetails){ // 전달값이 json을 받을때는 @RequestBody 사용.
//        System.out.println("commentDto json-data="+commentDto);
//        System.out.println("principalId="+principalDetails.getUser().getId());

        Comment comment = commentService.댓글쓰기(commentDto.getContent(),commentDto.getImageId(),principalDetails.getUser().getId()); //content, imageId, userId
        return new ResponseEntity<>(new CMRespDto<>(1,"댓글쓰기 성공",comment), HttpStatus.CREATED);
    }

    @DeleteMapping("/api/comment/{id}")
    public ResponseEntity<?>commentDelete(@PathVariable int id){

        return null;
    }
}
