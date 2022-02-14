package com.cos.photogram.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import com.cos.photogram.domain.comment.handler.ex.CustomApiException;
import com.cos.photogram.domain.comment.handler.ex.CustomException;
import com.cos.photogram.domain.comment.handler.ex.CustomValidationApiException;
import com.cos.photogram.web.dto.user.UserProfileDto;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.cos.photogram.domain.subscribe.SubscribeRepository;
import com.cos.photogram.domain.user.User;
import com.cos.photogram.domain.user.UserRepository;

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

		// UserprofileDto
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

		// 구독 여부: 프로필페이지 주인 = principaId가 subscribe 에서 구독중인가 아닌가?
		int subscribeState = subscribeRepository.mSubscribeState(principalId,pageUserId);
		dto.setSubscribeState(subscribeState == 1); // 1 == true

		// 내가 구독중인 게시자 count 수: select count(*) from subscribe where fromUserId = pageUserId;
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
	public User 회원프로필사진변경(int principalId,MultipartFile profileImageFile) {

		UUID uuid = UUID.randomUUID();
		String imageFileName = uuid + "_" + profileImageFile.getOriginalFilename(); //1.jpg
			//System.out.println("이미지 파일이름 : "+imageFileName);

		// 이미지 파일명 문자열에서 공백제거!!
		imageFileName = imageFileName.replaceAll(" ","");
		System.out.println("이미지 파일명 공백제거 = "+imageFileName);

		Path imageFilePath = Paths.get(uploadFolder + imageFileName);
			//System.out.println("파일 path : "+imageFilePath);

		System.out.println(" ###############   회원프로파일사진변경  just before Files.write() ################ ");
		try {
			Files.write(imageFilePath, profileImageFile.getBytes());
			System.out.println("---------------------- :: 파일쓰기 완료 :: ------------------------");
		} catch (Exception e) {
			e.printStackTrace();
		}

		//User userEntity = userRepository.findById(principalId).orElseThrow(()->{});
		User userEntity = userRepository.findById(principalId).orElseThrow(()->{
			throw new CustomApiException("유저를 찾을 수 없습니다.");
		});

		userEntity.setProfileImageUrl(imageFileName); // 이미지 경로 DB 저장.

		return userEntity; // 세션에 저장
	} // 더티체킹으로 업데이트 됨.

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
