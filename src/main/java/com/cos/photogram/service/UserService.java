package com.cos.photogram.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import com.cos.photogram.handler.ex.CustomException;
import com.cos.photogram.handler.ex.CustomValidationApiException;
import com.cos.photogram.web.dto.user.UserProfileDto;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.cos.photogram.config.auth.PrincipalDetails;
import com.cos.photogram.domain.subscribe.SubscribeRepository;
import com.cos.photogram.domain.user.User;
import com.cos.photogram.domain.user.UserRepository;
import com.cos.photogram.web.dto.user.UserProfileRespDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class UserService {

	private final UserRepository userRepository;
	private final SubscribeRepository subscribeRepository;
	private final BCryptPasswordEncoder bCryptPasswordEncoder;

	@Value("${file.path}")
	private String uploadFolder;

	@Transactional(readOnly = true) // ex) /user/1, /user/2, /user/3
	public UserProfileDto 회원프로필(int pageUserId,int principalId){
		UserProfileDto dto = new UserProfileDto();
		// UserProfileDto dto has
		// : pageOwnerState,imageCount,subscribeState,subscribeCount,User user

		// select * from Image where userId=:userId;
		// image has id,createDate,imageId,userId

		// UserRepository has User(id,bio,createDate,email,name,password,....)
		// interface UserRepository extends JpaRepository<User, Integer>
		User userEntity = userRepository.findById(pageUserId).orElseThrow(()->{
			throw new CustomException("해당 프로필 페이지는 없는 페이지입니다");
		});
//		System.out.println("================== userEntity . getImages() 호출됨. ======================");
//		userEntity.getImages().get(0);

		dto.setUser(userEntity);
		dto.setPageOwnerState(pageUserId == principalId); // 1은 페이지 주인/ -1은 주인아님
		dto.setImageCount(userEntity.getImages().size());

		int subscribeState = subscribeRepository.mSubscribeState(principalId,pageUserId);
		dto.setSubscribeState(subscribeState == 1); // 1 == true
		int subscribeCount = subscribeRepository.mSubscribeCount(pageUserId);
		dto.setSubscribeCount(subscribeCount);

		// 좋아요 카운트 추가하기
		userEntity.getImages().forEach((image -> {
			image.setLikeCount(image.getLikes().size());
		}));

		//return userEntity;
		return dto;
	}

	@Transactional
	public User 회원사진변경(MultipartFile profileImageFile, PrincipalDetails principalDetails) {

		UUID uuid = UUID.randomUUID();
		String imageFileName = uuid + "_" + profileImageFile.getOriginalFilename();
		// System.out.println("파일명 : "+imageFileName);

		Path imageFilePath = Paths.get(uploadFolder + imageFileName);
		// System.out.println("파일패스 : "+imageFilePath);
		try {
			Files.write(imageFilePath, profileImageFile.getBytes());
		} catch (Exception e) {
			e.printStackTrace();
		}

		User userEntity = userRepository.findById(principalDetails.getUser().getId()).get();
		userEntity.setProfileImageUrl(imageFileName);

		return userEntity;
	} // 더티체킹

	@Transactional
	public User 회원수정(int id, User user) {
		// username, email 수정 불가
		//User userEntity = userRepository.findById(id).get();
		//User userEntity = userRepository.findById(id).orElseThrow(() -> {return new IllegalArgumentException("찾을수없는 ID입니다.");});
		User userEntity = userRepository.findById(id).orElseThrow(() -> {return new CustomValidationApiException("찾을수없는 ID입니다.");});
		// 영속화

		// 영속화된 오브젝트 수정. 더티체킹.수정완료.
		userEntity.setName(user.getName());
		userEntity.setBio(user.getBio());
		userEntity.setWebsite(user.getWebsite());
		userEntity.setPhone(user.getPhone());
		userEntity.setGender(user.getGender());
		String rawPassword = user.getPassword();
		String encPassword = bCryptPasswordEncoder.encode(rawPassword);

		// 비밀번호입력란이 공백이 아니면 새로 비번 저장(입력란이 공백이면 그대로 유지)
		if(!user.getPassword().equals("")) {
			userEntity.setPassword(encPassword);
		}
		return userEntity;
	} // 더티체킹

	/*@Transactional(readOnly = true)
	public UserProfileRespDto 회원프로필(int userId, int principalId) {
		UserProfileRespDto userProfileRespDto = new UserProfileRespDto();

		User userEntity = userRepository.findById(userId).orElseThrow(() -> {
			return new IllegalArgumentException();
		});

		int subscribeState = subscribeRepository.mSubscribeState(principalId, userId);
		int subscribeCount = subscribeRepository.mSubscribeCount(userId);

		userProfileRespDto.setSubscribeState(subscribeState == 1);
		userProfileRespDto.setSubscribeCount(subscribeCount); // 내가 팔로우 하고 있는 카운트
		userProfileRespDto.setImageCount(userEntity.getImages().size());

		userEntity.getImages().forEach((image) -> {
			image.setLikeCount(image.getLikes().size());
		});

		userProfileRespDto.setUser(userEntity);

		return userProfileRespDto;
	}*/
}
