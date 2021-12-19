package com.cos.photogram.web;

import java.util.List;

import com.cos.photogram.web.dto.subscribe.SubscribeDto;
import com.cos.photogram.web.dto.user.UserProfileDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.cos.photogram.config.auth.PrincipalDetails;
import com.cos.photogram.domain.user.User;
import com.cos.photogram.service.SubscribeService;
import com.cos.photogram.service.UserService;
import com.cos.photogram.web.dto.CMRespDto;
import com.cos.photogram.web.dto.subscribe.SubscribeRespDto;
import com.cos.photogram.web.dto.user.UserProfileRespDto;

import lombok.RequiredArgsConstructor;
@Slf4j
@RequiredArgsConstructor
@Controller
public class UserController {

	private final UserService userService;
	private final SubscribeService subscribeService;

	@GetMapping("/user/{pageUserId}/subscribe") // data 리턴하는 것
	public @ResponseBody CMRespDto<?> followList(@AuthenticationPrincipal PrincipalDetails principalDetails,
			@PathVariable int pageUserId) {
		List<SubscribeDto> subscribeDto = subscribeService.구독리스트(principalDetails.getUser().getId(), pageUserId);

		//return new CMRespDto<>(1, subscribeRespDto);
		return null;
	}

	@GetMapping("/user/{pageUserId}")
	public String profile(@PathVariable int pageUserId,Model model,@AuthenticationPrincipal PrincipalDetails principalDetails){

		//User userEntity = userService.회원프로필(pageUserId,principalDetails.getUser().getId());
		UserProfileDto dto = userService.회원프로필(pageUserId,principalDetails.getUser().getId());
		model.addAttribute("dto",dto);
		return "user/profile"; // userEntity를 user속성으로 전달한다.
	}

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

	@PutMapping("/user/{id}")
	public @ResponseBody CMRespDto<?> profileUpdate(@PathVariable int id, User user,
			@AuthenticationPrincipal PrincipalDetails principalDetails) {
		User userEntity = userService.회원수정(id, user);
		principalDetails.setUser(userEntity);
		//return new CMRespDto<>(1, null);
		return null;
	}

	@PutMapping("/user/{id}/profileImageUrl")
	public @ResponseBody CMRespDto<?> profileImageUrlUpdate(@PathVariable int id, MultipartFile profileImageFile,
			@AuthenticationPrincipal PrincipalDetails principalDetails) {
		User userEntity = userService.회원사진변경(profileImageFile, principalDetails);
		principalDetails.setUser(userEntity);
		//return new CMRespDto<>(1, null);
		return null;
	}
}
