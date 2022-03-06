package com.woonkil.photosns.web;

import java.util.List;

import com.woonkil.photosns.web.dto.subscribe.SubscribeDto;
import com.woonkil.photosns.web.dto.user.UserProfileDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.woonkil.photosns.config.auth.PrincipalDetails;
import com.woonkil.photosns.domain.user.User;
import com.woonkil.photosns.service.SubscribeService;
import com.woonkil.photosns.service.UserService;
import com.woonkil.photosns.web.dto.CMRespDto;

import lombok.RequiredArgsConstructor;


@Slf4j
@RequiredArgsConstructor
@Controller
public class UserController {

	private final UserService userService;
	private final SubscribeService subscribeService;

	// 구독자 조회
	@GetMapping("/user/{pageUserId}/subscribe") // data 리턴하는 것
	public @ResponseBody CMRespDto<?> followList(@AuthenticationPrincipal PrincipalDetails principalDetails,
			@PathVariable int pageUserId) {
		List<SubscribeDto> subscribeDto = subscribeService.구독리스트(principalDetails.getUser().getId(), pageUserId);

		//return new CMRespDto<>(1, subscribeRespDto);
		return null;
	}
	// 회원 프로필 정보 조회 // profile.jsp 페이지로 dto 리턴
	@GetMapping("/user/{pageUserId}")
	public String profile(@PathVariable int pageUserId,Model model,@AuthenticationPrincipal PrincipalDetails principalDetails){

		//User userEntity = userService.회원프로필(pageUserId,principalDetails.getUser().getId());
		UserProfileDto dto = userService.회원프로필(pageUserId,principalDetails.getUser().getId());
		// dto 로 data:User, PageOwnerState,ImageCount,subscribeState,subScribeCount 를 받는다
		model.addAttribute("dto",dto);
		return "user/profile2"; // userEntity를 user속성으로 전달한다.
	}
	// 로그인 세션 정보 업데이트?
	@GetMapping("/user/{id}/update")
	public String profileSetting(@PathVariable int id,@AuthenticationPrincipal PrincipalDetails principalDetails,Model model) {

		//log.info("==================세션정보:principalDetails.getUser()="+principalDetails.getUser());
		log.info("================== 세션정보: principalDetails.getUser() ===================================");
		/*
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		PrincipalDetails mPrincipalDetails = (PrincipalDetails) auth.getPrincipal();
		log.info("==================세션정보:(PrincipalDetails)) auth.getPrincipal()="+mPrincipalDetails.getUser());
		*/
		model.addAttribute("principal",principalDetails.getUser());
		return "user/update";
	}
	// 회원 정보 수정
	@PutMapping("/user/{id}")
	public @ResponseBody CMRespDto<?> profileUpdate(@PathVariable int id, User user,
			@AuthenticationPrincipal PrincipalDetails principalDetails) {
		User userEntity = userService.회원수정(id, user);
		principalDetails.setUser(userEntity);
		//return new CMRespDto<>(1, null);
		return null;
	}
	// 프로필 사진 변경
	@PutMapping("/user/{id}/profileImageUrl")
	public @ResponseBody CMRespDto<?> profileImageUrlUpdate(@PathVariable int id, MultipartFile profileImageFile,
			@AuthenticationPrincipal PrincipalDetails principalDetails) {
		int principalId;
		System.out.println(" ################# PutMapping /user/id/profileImageUrl");
		User userEntity = userService.회원프로필사진변경(id,profileImageFile);
		System.out.println(" ################# userEntity =>"+userEntity.toString());
		principalDetails.setUser(userEntity);
		//return new CMRespDto<>(1, null);
		return null;
	}




}
