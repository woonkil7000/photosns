package com.cos.photogram.web.api;

import com.cos.photogram.config.auth.PrincipalDetails;
import com.cos.photogram.domain.image.Image;
import com.cos.photogram.service.ImageService;
import com.cos.photogram.service.LikesService;
import com.cos.photogram.web.dto.CMRespDto;
import com.cos.photogram.web.dto.image.ImageReqDto;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
public class ImageApiController {

    private final ImageService imageService;
    private final LikesService likesService;

    @GetMapping("/api/image")
    public ResponseEntity<?> imageStory(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                        @PageableDefault(size=3) Pageable pageable){
        Page<Image> images = imageService.이미지스토리(principalDetails.getUser().getId(),pageable);
        System.out.println("######################### @GetMapping(\"/api/image\") :: Page[Image] images  = imageService.이미지스토리(principalDetails.getUser().getId(),pageable) #######################");
        if (images.isEmpty()) { // ############### 구독자가 없는 경우 에러
            return new ResponseEntity<>(new CMRespDto<>(-1,"List images 없음",null), HttpStatus.BAD_REQUEST);
        } else {
            return new ResponseEntity<>(new CMRespDto<>(1, "List images 담기 성공", images), HttpStatus.OK);
        }
    }
    @GetMapping("/api/image2")
    public ResponseEntity<?> imageStoryAll(@AuthenticationPrincipal PrincipalDetails principalDetails, @PageableDefault(size=3) Pageable pageable){
        Page<Image> images = imageService.이미지스토리올(principalDetails.getUser().getId(),pageable);
        System.out.println("######################### @GetMapping(\"/api/image\") :: Page[Image] images  = imageService.이미지스토리올(principalDetails.getUser().getId(),pageable) #######################");
        return  new ResponseEntity<>(new CMRespDto<>(1,"List images 담기 성공",images), HttpStatus.OK);
    }

    @PostMapping("/api/image/{imageId}/likes")
    public ResponseEntity<?> likes(@PathVariable int imageId,@AuthenticationPrincipal PrincipalDetails principalDetails){

        likesService.좋아요(imageId,principalDetails.getUser().getId());
        return  new ResponseEntity<>(new CMRespDto<>(1,"좋아요성공",null),HttpStatus.CREATED);
    }

    @DeleteMapping("/api/image/{imageId}/likes")
    public ResponseEntity<?> unlikes(@PathVariable int imageId,@AuthenticationPrincipal PrincipalDetails principalDetails){
        likesService.좋아요취소(imageId,principalDetails.getUser().getId());
        return  new ResponseEntity<>(new CMRespDto<>(1,"좋아요취소성공",null),HttpStatus.OK);
    }

    @DeleteMapping("/api/image/{imageId}/delete")
    public ResponseEntity<?> delete(@PathVariable int imageId,@AuthenticationPrincipal PrincipalDetails principalDetails){
        imageService.이미지삭제(imageId,principalDetails.getUser().getId());
        return  new ResponseEntity<>(new CMRespDto<>(1,"이미지 삭제 성공",null),HttpStatus.OK);
    }

    @PatchMapping("/api/image/{imageId}/update")
    public ResponseEntity<?> update(@PathVariable int imageId, @RequestBody ImageReqDto imageReDto, @AuthenticationPrincipal PrincipalDetails principalDetails){
        imageService.이미지수정(imageId,imageReDto,principalDetails.getUser().getId());
        return  new ResponseEntity<>(new CMRespDto<>(1,"이미지 수정 성공",null),HttpStatus.OK);
    }

}
