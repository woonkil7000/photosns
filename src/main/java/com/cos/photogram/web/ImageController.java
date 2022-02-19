package com.cos.photogram.web;

import com.cos.photogram.domain.comment.handler.ex.CustomValidationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cos.photogram.config.auth.PrincipalDetails;
import com.cos.photogram.domain.image.Image;
import com.cos.photogram.service.CommentService;
import com.cos.photogram.service.ImageService;
import com.cos.photogram.service.LikesService;
import com.cos.photogram.web.dto.CMRespDto;
import com.cos.photogram.web.dto.image.ImageReqDto;

import lombok.RequiredArgsConstructor;

import java.util.List;

@RequiredArgsConstructor
@Controller
public class ImageController {

	private final ImageService imageService;
	private final LikesService likesService;
	private final CommentService commentService;

	@GetMapping("/image/upload")
	public String upload() {
		return "image/upload";
	}

	// 이미지 업로딩
	@PostMapping("/image") // upload.js 에서 post 로 받음.
	public String image(ImageReqDto imageReqDto, @AuthenticationPrincipal PrincipalDetails principalDetails) {

		if(imageReqDto.getFile().isEmpty()) {
			//System.out.println("이미지가 첨부되지 않았습니다.");
			throw new CustomValidationException("이미지가 첨부되지 않았습니다.",null);
		}
		// 서비스 호출
		imageService.사진업로드(imageReqDto, principalDetails);

		return "redirect:/user/"+principalDetails.getUser().getId();
	}

	// /image/story.jsp 구독중인 사진 리스트 페이지로 리텀됨
	@GetMapping({"/image/story"})
	public String feed() {
		return "image/story";
	}

	// /image/storyall.jsp // 모든 사진 불러오는 페이지로 리턴됨
	@GetMapping({"/","/image/storyall"})
	public String feed2() {
		return "/image/storyall";
	}

	@GetMapping("/fetchaxios")
	public String fetchaxios() {
		return "/image/fetchaxios";
	}

	//  주소 : /image?page=0
	@GetMapping("/image") // imageApi json data
	public @ResponseBody CMRespDto<?> image(Model model, @AuthenticationPrincipal PrincipalDetails principalDetails, 
			@PageableDefault(size=3, sort = "id", direction = Sort.Direction.DESC) Pageable pageable) {
		
		Page<Image> pages = imageService.피드이미지(principalDetails.getUser().getId(), pageable);
		//return new CMRespDto<>(1, pages); // MessageConverter 발동 = Jackson = 무한참조
		return null;
	}
	
	
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
			return "image/popular"; // /image/popular.jsp로 model data를 전달
		}
	}
	

	
	@PostMapping("/image/{imageId}/likes")
	public @ResponseBody CMRespDto<?> like(@AuthenticationPrincipal PrincipalDetails principalDetails, @PathVariable int imageId){
		likesService.좋아요(imageId, principalDetails.getUser().getId());
		//return new CMRespDto<>(1, null);
		return null;
	}
	
	@DeleteMapping("/image/{imageId}/likes")
	public @ResponseBody CMRespDto<?> unLike(@AuthenticationPrincipal PrincipalDetails principalDetails, @PathVariable int imageId){
		likesService.좋아요취소(imageId, principalDetails.getUser().getId());
		//return new CMRespDto<>(1, null);
		return null;
	}

	@DeleteMapping("/image/{imageId}/delete")
	public @ResponseBody CMRespDto<?> delete(@AuthenticationPrincipal PrincipalDetails principalDetails, @PathVariable int imageId){
		imageService.이미지삭제(imageId, principalDetails.getUser().getId());
		//return new CMRespDto<>(1, null);
		return null;
	}
	
	/*@PostMapping("/image/{imageId}/comment")
	public @ResponseBody CMRespDto<?> save(@PathVariable int imageId, @RequestBody String content, @AuthenticationPrincipal PrincipalDetails principalDetails){   // content, imageId, userId(세션)
		Comment commentEntity = commentService.댓글쓰기(principalDetails.getUser(), content, imageId);
		
		//return new CMRespDto<>(1, commentEntity);
		return null;
	}*/

}













