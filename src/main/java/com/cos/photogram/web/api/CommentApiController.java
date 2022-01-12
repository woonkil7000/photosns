package com.cos.photogram.web.api;

import com.cos.photogram.config.auth.PrincipalDetails;
import com.cos.photogram.domain.comment.Comment;
import com.cos.photogram.domain.user.User;
import com.cos.photogram.handler.ex.CustomValidationApiException;
import com.cos.photogram.handler.ex.CustomValidationException;
import com.cos.photogram.service.CommentService;
import com.cos.photogram.web.dto.CMRespDto;
import com.cos.photogram.web.dto.comment.CommentDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.Map;
@Slf4j
@RequiredArgsConstructor
@RestController
public class CommentApiController {

    private final CommentService commentService;

    @PostMapping("/api/comment")
    public ResponseEntity<?>commentSave(@Valid @RequestBody CommentDto commentDto, BindingResult bindingResult, @AuthenticationPrincipal PrincipalDetails principalDetails){ // 전달값이 json을 받을때는 @RequestBody 사용.
//        System.out.println("commentDto json-data="+commentDto);
//        System.out.println("principalId="+principalDetails.getUser().getId());

        /*if(bindingResult.hasFieldErrors()){
            Map<String, String> errorMap = new HashMap<>();

            for(FieldError error:bindingResult.getFieldErrors()){
                errorMap.put(error.getField(),error.getDefaultMessage());
                System.out.println("=====================================");
                System.out.println(error.getDefaultMessage());
                System.out.println("=====================================");
            }
            throw new CustomValidationApiException("유효성 검사 실패함.",errorMap);

        }*/

        Comment comment = commentService.댓글쓰기(commentDto.getContent(),commentDto.getImageId(),principalDetails.getUser().getId()); //content, imageId, userId
        return new ResponseEntity<>(new CMRespDto<>(1,"댓글쓰기 성공",comment), HttpStatus.CREATED);
    }

    @DeleteMapping("/api/comment/{id}")
    public ResponseEntity<?>commentDelete(@PathVariable int id,@AuthenticationPrincipal PrincipalDetails principalDetails){

        commentService.댓글삭제(id,principalDetails.getUser().getId());
        return new ResponseEntity<>(new CMRespDto<>(1,"댓글삭제 성공",null), HttpStatus.OK);
    }
}
