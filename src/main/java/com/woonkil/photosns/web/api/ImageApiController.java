package com.woonkil.photosns.web.api;

import com.woonkil.photosns.config.auth.PrincipalDetails;
import com.woonkil.photosns.domain.image.Image;
import com.woonkil.photosns.service.ImageService;
import com.woonkil.photosns.service.LikesService;
import com.woonkil.photosns.web.dto.CMRespDto;
import com.woonkil.photosns.web.dto.image.ImageReqDto;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
public class ImageApiController {

    private final ImageService imageService;
    private final LikesService likesService;

    // pageUserId 로 해당 유저의  Page<이미지> 리스트 가져오기(프로필 페이지에서 사용)
    @GetMapping("/api/image/{pageUserId}")
    public ResponseEntity<?> imageStory3(@PathVariable int pageUserId,@AuthenticationPrincipal PrincipalDetails principalDetails,
                                         @PageableDefault(size=12) Pageable pageable){
        Page<Image> images = imageService.유저이미지스토리(pageUserId,principalDetails.getUser().getId(),pageable);
        System.out.println("######################### @GetMapping(\"/api/image3\") :: Page[Image] images  = imageService.유저이미지스토리(principalDetails.getUser().getId(),pageable) #######################");
        if (images.isEmpty()) { // ############### 유저가 등록한 이미지가 없는 경우 에러
            return new ResponseEntity<>(new CMRespDto<>(-1,"List images 없음",null), HttpStatus.BAD_REQUEST);
        } else {
            return new ResponseEntity<>(new CMRespDto<>(1, "List images 담기 성공", images), HttpStatus.OK);
        }
    }
    // popular 인기게시물 페이지 리스트 가져오기
    @GetMapping("/api/image/popular")
    public ResponseEntity<?> popularRank(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                         @PageableDefault(size=12) Pageable pageable){
        Page<Image> images = imageService.인기사진2(principalDetails.getUser().getId(),pageable);
        System.out.println("######################### imageService.인기사진2() #######################");
        if (images.isEmpty()) { // ############### 이미지가 없는 경우 에러
            return new ResponseEntity<>(new CMRespDto<>(-1,"List images 없음",null), HttpStatus.BAD_REQUEST);
        } else {
            return new ResponseEntity<>(new CMRespDto<>(1, "List images 담기 성공", images), HttpStatus.OK);
        }
    }
    /*
    // API로 구현을 한다면 -이유- 브라우저요청이 아니라 안드로이드나 iOS에서 요청시.
    // 좋아요 랭킹!!  인기많은 사진순으로  리턴 됨.
    @GetMapping("/image/popular")
    public String explore(Model model, @AuthenticationPrincipal PrincipalDetails principalDetails) {

        // API는 데이터를 리턴하는 서버!!
        List<Image> images = imageService.인기사진(principalDetails.getUser().getId());

        if (images.isEmpty()) { // likes table 에 좋아요가 아직 없는 경우
            return "image/nolike";
        }else {
            model.addAttribute("images", images);
            return "image/popular2"; // /image/popular2.jsp로 model data를 전달
        }
    }*/

    // 구독 이미지 조회
    @GetMapping("/api/image")
    public ResponseEntity<?> imageStory(@AuthenticationPrincipal PrincipalDetails principalDetails,
                                        @PageableDefault(size=12) Pageable pageable){
        Page<Image> images = imageService.이미지스토리(principalDetails.getUser().getId(),pageable);
        System.out.println("######################### @GetMapping(\"/api/image\") :: Page[Image] images  = imageService.이미지스토리(principalDetails.getUser().getId(),pageable) #######################");
        if (images.isEmpty()) { // ############### 구독자가 없는 경우 에러
            return new ResponseEntity<>(new CMRespDto<>(-1,"List images 없음",null), HttpStatus.BAD_REQUEST);
        } else {
            return new ResponseEntity<>(new CMRespDto<>(1, "List images 담기 성공", images), HttpStatus.OK);
        }
    }
    // 전체 이미지 조회
    @GetMapping("/api/image2")
    public ResponseEntity<?> imageStoryAll(@AuthenticationPrincipal PrincipalDetails principalDetails, @PageableDefault(size=12) Pageable pageable){
        Page<Image> images = imageService.이미지스토리올(principalDetails.getUser().getId(),pageable);
        // 로그인 사용자 ID와  페이지 전달 // imageRepository 에서 인자로 사용.

        System.out.println("######################### @GetMapping(\"/api/image\") :: Page[Image] images  = imageService.이미지스토리올(principalDetails.getUser().getId(),pageable) #######################");
        return  new ResponseEntity<>(new CMRespDto<>(1,"List images 담기 성공",images), HttpStatus.OK);
    }
    // 좋아요 표시
    @PostMapping("/api/image/{imageId}/likes")
    public ResponseEntity<?> likes(@PathVariable int imageId,@AuthenticationPrincipal PrincipalDetails principalDetails){

        likesService.좋아요(imageId,principalDetails.getUser().getId());
        return  new ResponseEntity<>(new CMRespDto<>(1,"좋아요성공",null),HttpStatus.CREATED);
    }
    // 좋아요 삭제
    @DeleteMapping("/api/image/{imageId}/likes")
    public ResponseEntity<?> unlikes(@PathVariable int imageId,@AuthenticationPrincipal PrincipalDetails principalDetails){
        likesService.좋아요취소(imageId,principalDetails.getUser().getId());
        return  new ResponseEntity<>(new CMRespDto<>(1,"좋아요취소성공",null),HttpStatus.OK);
    }
    // 이미지 삭제
    @DeleteMapping("/api/image/{imageId}/delete")
    public ResponseEntity<?> delete(@PathVariable int imageId,@AuthenticationPrincipal PrincipalDetails principalDetails){
        imageService.이미지삭제(imageId,principalDetails.getUser().getId());
        return  new ResponseEntity<>(new CMRespDto<>(1,"이미지 삭제 성공",null),HttpStatus.OK);
    }
    // 이미지 설명 수정
    @PatchMapping("/api/image/{imageId}/update")
    public ResponseEntity<?> update(@PathVariable int imageId, @RequestBody ImageReqDto imageReDto, @AuthenticationPrincipal PrincipalDetails principalDetails){
        imageService.이미지수정(imageId,imageReDto,principalDetails.getUser().getId());
        return  new ResponseEntity<>(new CMRespDto<>(1,"이미지 수정 성공",null),HttpStatus.OK);
    }

}
