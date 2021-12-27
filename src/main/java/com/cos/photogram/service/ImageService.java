package com.cos.photogram.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cos.photogram.config.auth.PrincipalDetails;
import com.cos.photogram.domain.image.Image;
import com.cos.photogram.domain.image.ImageRepository;
import com.cos.photogram.domain.tag.Tag;
import com.cos.photogram.domain.tag.TagRepository;
import com.cos.photogram.utils.TagUtils;
import com.cos.photogram.web.dto.image.ImageReqDto;

import lombok.RequiredArgsConstructor;


@Slf4j
@RequiredArgsConstructor
@Service
public class ImageService {

	private final ImageRepository imageRepository;

	@Transactional(readOnly = true) // 영속성 컨텍스트 변경감지. 더티체킹.flush(반영) 안하게함. 세션 유지.
	public Page<Image> 이미지스토리(int principalId, Pageable pageable){
		Page<Image> images=imageRepository.mStory(principalId,pageable);
		System.out.println("################## ImageService{} public Page<Image> 이미지스토리(int principalId, Pageable pageable) ##################");
		System.out.println("##################  Page<Image> images=imageRepository.mStory(principalId,pageable) ##################");
		System.out.println(images);

		// ############ images에 좋아요 상태 likeState: true/false 담기 ######### //
		// 2(cos) 로그인에서
		images.forEach((image -> {

			// 좋아요 카운트 추가하기
			image.setLikeCount(image.getLikes().size());

			image.getLikes().forEach(likes -> {
				if(likes.getUser().getId() == principalId){ //해당 이미지에 좋아요한 사람들을 찾아서 현재 로그인한 사람이 좋아요한것인지 비교.
					image.setLikeState(true);
				}
			});
		}));

		System.out.println("######################################## End of Page[Image] images ###################################################");
		log.info("imageRepository.mStory(principalId,pageable) String.valueOf( [images] ) =============>>>>>>>>>> "+String.valueOf(images));
		log.info("###################  return [images] :: Page[Image] images=imageRepository.mStory(principalId,pageable)    ######################### ");
		return images;
	}

	@Value("${file.path}")
	private String uploadFolder;

	private final TagRepository tagRepository;

	@Transactional
	public void 사진업로드(ImageReqDto imageReDto, PrincipalDetails principalDetails) {

		UUID uuid = UUID.randomUUID();
		String imageFileName = uuid+"_"+imageReDto.getFile().getOriginalFilename(); // xxxxxx_1.jpg
		System.out.println("이미지 파일명 : "+imageFileName);

		// 이미지 파일명 문자열에서 공백제거!!
		imageFileName = imageFileName.replaceAll(" ","");
		System.out.println("이미지 파일명 공백제거 = "+imageFileName);

		Path imageFilePath = Paths.get(uploadFolder+imageFileName);
		System.out.println("이미지 파일 패스 : "+imageFilePath);

		// 통신. IO -> 예외발생할수있다....
		try {
			Files.write(imageFilePath, imageReDto.getFile().getBytes()); // 파일 쓰기
			System.out.println("------------------------  :: 파일쓰기 :: ------------------------");
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 참고 :  Image 엔티티에 Tag는 주인이 아니다. Image 엔티티로 통해서 Tag를 save할 수 없다.

		// 1. Image 저장
		Image image = imageReDto.toEntity(imageFileName, principalDetails.getUser());
		Image imageEntity = imageRepository.save(image);
		//imageRepository.save(image);
		System.out.println("==================================== 이미지 Entity DB 저장.  =======================================");
		//System.out.println(imageEntity);
		// ########## imageEntity를 출력하면 무한 참조로 no session Error 발생시킴 ###########
		//log.info(imageEntity.toString());

		// 2. Tag 저장
		List<Tag> tags = TagUtils.parsingToTagObject(imageReDto.getTags(), imageEntity);
		tagRepository.saveAll(tags);

	}

	@Transactional(readOnly = true)
	public List<Image> 인기사진(int principalId){
		return imageRepository.mExplore(principalId);
	}
	
	
//	@Value("${file.path}")
//	private String uploadFolder;
	
	public Page<Image> 피드이미지(int principalId, Pageable pageable){
		
		// 1. principalId 로 내가 팔로우하고 있는 사용자를 찾아야 됨. (한개이거나 컬렉션이거나)
		// select * from image where userId in (select toUserId from follow where fromUserId = 1);
		
		Page<Image> images = imageRepository.mFeed(principalId, pageable);
		
		// 좋아요 하트 색깔 로직 + 좋아요 카운트 로직
		images.forEach((image)-> {
			
			int likeCount = image.getLikes().size();
			image.setLikeCount(likeCount);
			
			image.getLikes().forEach((like)->{
				if(like.getUser().getId() == principalId) {
					image.setLikeState(true);
				}
			});
		});
		
		return images;
	}
	

}







