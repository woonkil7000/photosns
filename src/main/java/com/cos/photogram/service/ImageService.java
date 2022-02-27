package com.cos.photogram.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import com.cos.photogram.domain.comment.CommentRepository;
import com.cos.photogram.domain.comment.handler.ex.CustomApiException;
import com.cos.photogram.domain.likes.LikesRepository;
import com.cos.photogram.domain.user.User;
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
	private final CommentRepository commentRepository;
	private final LikesRepository likesRepository;
	private final TagRepository tagRepository;

	@Transactional(readOnly = true) // 영속성 컨텍스트 변경감지. 더티체킹.flush(반영) 안하게함. 세션 유지.
	public Page<Image> 유저이미지스토리(int pageUserId,int principalId, Pageable pageable){
		Page<Image> images=imageRepository.userStory(pageUserId,pageable);

		if (images.isEmpty()) {  // 유저가 등록한 이미지가 없는 경우.
			log.info("#################### 유저가 등록한 이미지가 없는 경우");
		} else {
			System.out.println("################## ImageService{} public Page<Image> 유저이미지스토리() ##################");
			System.out.println("##################  Page<Image> images=imageRepository.userStory() ##################");
			System.out.println(images);

			// ############ images에 좋아요 상태 likeState: true/false 담기 ######### //
			// 2(cos) 로그인에서
			images.forEach((image -> {
				// 좋아요 카운트 값 저장.
				image.setLikeCount(image.getLikes().size());

				/*image.getLikes().forEach(likes -> {
					if (likes.getUser().getId() == principalId) { //해당 이미지에 좋아요한 사람들을 찾아서 현재 로그인한 사람이 좋아요한것인지 비교.
						image.setLikeState(true);
					}
				});*/
			}));

			System.out.println("######################################## End of Page[Image] images ###################################################");
			log.info("imageRepository.유저이미지스토리(String.valueOf( [images] ) =============>>>>>>>>>> String.valueOf(images)");
			log.info("###################  return Page[Image] images=imageRepository.userStory(principalId,pageable)    ######################### ");
		}
		return images;
	}

	@Transactional(readOnly = true) // 영속성 컨텍스트 변경감지. 더티체킹.flush(반영) 안하게함. 세션 유지.
	public Page<Image> 이미지스토리(int principalId, Pageable pageable){
		Page<Image> images=imageRepository.mStory(principalId,pageable);

		if (images.isEmpty()) {  // 조화 결과가 없을때 // 구독이 없는 경우.
			log.info("#################### 구독자 없는 경우");
		} else {
			System.out.println("################## ImageService{} public Page<Image> 이미지스토리(int principalId, Pageable pageable) ##################");
			System.out.println("##################  Page<Image> images=imageRepository.mStory(principalId,pageable) ##################");
			System.out.println(images);

			// ############ images에 좋아요 상태 likeState: true/false 담기 ######### //
			// 2(cos) 로그인에서
			images.forEach((image -> {

				// 좋아요 카운트 추가하기
				image.setLikeCount(image.getLikes().size());

				image.getLikes().forEach(likes -> {
					if (likes.getUser().getId() == principalId) { //해당 이미지에 좋아요한 사람들을 찾아서 현재 로그인한 사람이 좋아요한것인지 비교.
						image.setLikeState(true);
					}
				});
			}));

			System.out.println("######################################## End of Page[Image] images ###################################################");
			log.info("imageRepository.mStory(principalId,pageable) String.valueOf( [images] ) =============>>>>>>>>>> " + String.valueOf(images));
			log.info("###################  return [images] :: Page[Image] images=imageRepository.mStory(principalId,pageable)    ######################### ");
		}
		return images;
	}

	@Transactional(readOnly = true) // 영속성 컨텍스트 변경감지. 더티체킹.flush(반영) 안하게함. 세션 유지.
	public Page<Image> 이미지스토리올(int principalId,Pageable pageable){
		Page<Image> images=imageRepository.mStory(pageable);
		System.out.println("################## ImageService{} public Page<Image> 이미지스토리(Pageable pageable) ##################");
		System.out.println("##################  Page<Image> images=imageRepository.mStory(pageable) ##################");
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

	@Value("${file.path}") // application.yml file: path:
	private String uploadFolder; // <== @Value("$file.path") ex)c:/spring/upload

	//private final TagRepository tagRepository;

	@Transactional
	public void 사진업로드(ImageReqDto imageReDto, PrincipalDetails principalDetails) {
		// filename = imageRedDto.getFile().getOriginalFilename(); //ex) 1.jpg

		UUID uuid = UUID.randomUUID();
		String imageFileName = uuid+"_"+imageReDto.getFile().getOriginalFilename(); // xxxxxx_1.jpg
		String fileContentType = imageReDto.getFile().getContentType();
		// 추후 View 에서 사용하기 위해 file 정보에서 contentType 추출해서 DB에 저장.
		System.out.println("이미지 파일명 : "+imageFileName);

		// 이미지 파일명 문자열에서 공백제거!!
		imageFileName = imageFileName.replaceAll(" ","");
		System.out.println("이미지 파일명 공백제거 = "+imageFileName);

		Path imageFilePath = Paths.get(uploadFolder+imageFileName);
		System.out.println("이미지 파일 패스 : "+imageFilePath);

		// 통신. IO -> 항상 예외가 발생할 수 있다.... 꼭 예외 처리할 것.
		try {
			Files.write(imageFilePath, imageReDto.getFile().getBytes());
			// 파일 쓰기(경로포함 파일이름, 파일크기 정보)
			System.out.println("------------------------  :: 파일쓰기 :: ------------------------");
		} catch (Exception e) {
			e.printStackTrace(); // 예외상황 기록하기.
		}

		// 참고 :  Image 엔티티에 Tag는 주인이 아니다. Image 엔티티로 통해서 Tag를 save할 수 없다.

		// 1. Image table 저장
		imageReDto.setContentType(fileContentType); // file Type DB 저장.
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
	@Transactional
	public void 유튜브전송(ImageReqDto imageReDto, PrincipalDetails principalDetails) {
		String fileContentType = "youtube";
		// 추후 View 에서 사용하기 위해 file 정보에서 contentType 추출해서 DB에 저장.

		// 참고 :  Image 엔티티에 Tag는 주인이 아니다. Image 엔티티로 통해서 Tag를 save할 수 없다.

		// 1. Image table 저장
		imageReDto.setContentType(fileContentType); // file Type DB 저장.
		String imageFileName = imageReDto.getUAddress(); // 파일네임을 유튜브 주소로 대체
		Image image = imageReDto.toEntity(imageFileName, principalDetails.getUser());
		Image imageEntity = imageRepository.save(image);
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
		// mExplore:
		//return imageRepository.mExplore(principalId);
		//List<Image> images = imageRepository.mExplore(principalId);
		List<Image> images = imageRepository.mExplore(principalId);
		//ImageRankDto imageRankDto = new ImageRankDto();
		if (images.isEmpty()) {  // 조화 결과가 없을때 // 구독이 없는 경우.
			log.info("#################### 좋아요를 표시한 사진이 없는 경우에 해당 imageRepository.mExplore(principalId)");
		} else {
			System.out.println("################## 좋아요 표시한 사진만. Page<Image> images = imageRepository.mExplore(principalId) ##################");
		}
		System.out.println("#################  인기사진 List<Image> images = imageRepository.mExplore(principalId)  #####################");

		// 좋아요 하트 색깔 로직 + 좋아요 카운트 로직
		images.forEach((image)-> {

			int likeCount = image.getLikes().size();
			image.setLikeCount(likeCount); // set dto.image.likeCount = likeCount;

			image.getLikes().forEach((like)->{
				if(like.getUser().getId() == principalId) {
					image.setLikeState(true); // set dto.image.likeState = true;
				}
			});
		});

		// StackOverflow 발생시킴. 에러방지를 위해 toString 처리에서 userEntity제외함.
		//log.info("##### imageService: 인기사진: 인기사진 리스트 받음:{}",images);
		return images;
		// 콘트롤러에서 아래와 같이 수행함.
		// model.addAttribute("images", images);
		// return "image/popular"; // /image/popular.jsp 에서  model data 사용
	}
	@Transactional(readOnly = true) // api popular images. return Page<Image>.
	public Page<Image> 인기사진2(int principalId,Pageable pageable){
		// popular:
		//return imageRepository.mExplore(principalId);
		//List<Image> images = imageRepository.mExplore(principalId);
		Page<Image> images = imageRepository.popularRank(pageable);
		//ImageRankDto imageRankDto = new ImageRankDto();
		if (images.isEmpty()) {  // 조화 결과가 없을때 // 구독이 없는 경우.
			log.info("####################  imageRepository.popular() no data ############################");
		} else {
			System.out.println("##################  Page<Image> images = imageRepository.popular() ##################");
		}
		System.out.println("#################  인기사진 List<Image> images = imageRepository.popular()  #####################");

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

		// StackOverflow 발생시킴. 에러방지를 위해 toString 처리에서 userEntity제외함.
		//log.info("##### imageService: 인기사진: 인기사진 리스트 받음:{}",images);
		return images;
		// 콘트롤러에서 아래와 같이 수행함.
		// model.addAttribute("images", images);
		// return "image/popular"; // /image/popular.jsp 에서  model data 사용
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


	@Transactional
	public void 이미지삭제(int imageId, int princialId) {

		// id: 이미지 주인 id, imageId 이미지번호
		// 파일 삭제, DB 삭제(image,comment,likes,.....)
		// transaction 처리.
		Image image = imageRepository.findById(imageId).orElseThrow();
		User user = image.getUser();
		String contentType = image.getContentType();
		// 유튜브 데이터는 파일 삭제 없이 db에서만 삭제.
		log.info("#### #### principalId ={}",princialId);
		log.info("#### #### to delete image's user ={}",user);
		log.info("#### #### imageId ={}",imageId);
		log.info("################################################################# contentType='{}'",contentType);

		// user.id == principalId // image.user.getId 과 principalId 가 같을 때
		if(princialId==user.getId()) {

			// 파일 경로 지정 String path = ServletContext.getRealPath("저장된 파일 경로");
			// 현재 게시판에 존재하는 파일객체를 만듬 File file = new File(path + "\\" + "저장된 파일 이름");
			// if(file.exists()) {
			// 	파일이 존재하면 file.delete(); // 파일 삭제
			// }

			// "문자열" 비교할때 != == 사용하지 않는다! equals()메소드 사용!!
			if (!contentType.equals("youtube")) {

				log.info("#############################  contentType != youtube ####################################");
				Path imageFilePath = Path.of(uploadFolder + image.getPostImageUrl());
				log.info("#### #### To delete imageFilePath={}", imageFilePath);
				// 해당 경로에 파일이 있고 contentType 이 유튜브 데이타가 아니면. 파일 삭제 시도.
				if (Files.exists(imageFilePath)) {

					try {
						System.out.println("--------  :: 파일삭제 시도 :: --------");

						Files.delete(imageFilePath); // #### 파일 삭제 ####

						System.out.println(" ==== Files.delete(imageFilePath) : 파일삭제 ==== ");
						// 파일 삭제(경로포함 파일경로)
						// Files.delete(imageFilePath);
						// imageFilePath.toFile().delete() // ????
						// 삭제후 삭제 파일 exists 로 체크.
						if (Files.exists(imageFilePath)) {
							System.out.println("Files.exists 체크: 파일이 삭제되지 않았습니다.");
						} else {
							System.out.println("Files.exists 체크: 파일이 삭제된 것을 학인합니다.");
							System.out.println("관련 DB data 도 삭제해 주세요.");
							// 파일 삭제시 DB 에서 파일 경로 정보를 참조하므로 파일 삭제 후 디비 삭제하는 로직으로
							// comment, likes, tag, image  delete by imageId
							// tagRepository.deleteById(imageId);
							// likesRepository.deleteById(imageId);
							// commentRepository.deleteById(imageId);
							imageRepository.deleteById(imageId); // on delete cascade: delete with FK constraint
						}

					} catch (Exception e) {
						e.printStackTrace(); // 예외상황 기록하기.
					}

				} else { // Files.exists // 파일이 없거나 contentType 이 유튜브 데이터 등 이면.

					System.out.println(" ==== Files.exists() :: 삭제할 파일이 존재하지 않습니다. ==== ");
					System.out.println(" ==== 유트브 데이터 일때도 이부분 실행(DB 에서만 데이터 삭제) ==== ");

					// #### 삭제할 파일이 없으면 DB 가 잘못된 파일 경로 데이터를 가지고 있으므로  DB 에서 삭제하자 ####
					imageRepository.deleteById(imageId); // on delete cascade: delete with FK constraint
				}


			}else{ // when contentType= youtubu

				log.info("#############################  contentType == youtube ####################################");
				imageRepository.deleteById(imageId); // on delete cascade: delete with FK constraint
				log.info("##########   유튜브 데이터 DB 에서 삭제 ########");
				// ####   유튜브 데이터 DB 에서 삭제 ####
			}

		} else {
				log.info("삭제할 이미지의 주인이 아닙니다.");
			}

	}

	@Transactional
	public Image 이미지수정(int imageId, ImageReqDto imageReDto, int principalId) {

		// 이미지 설명 caption 만  수정
		// id: 이미지 주인 id, imageId 이미지번호
		// 파일 삭제, DB 삭제(image,comment,likes,.....)
		// transaction 처리.

		//Image imageEntity = imageRepository.findById(imageId).orElseThrow();
		Image imageEntity = imageRepository.findById(imageId).orElseThrow(()->{
			throw new CustomApiException("이미지를 찾을 수 없습니다.");
		});

		//User user = imageEntity.getUser();
		User user = imageEntity.getUser();
		//int principalId = principalDetails.getUser().getId();

		log.info("#### #### principalId ={}",principalId);
		log.info("#### #### to delete image's user ={}",user);
		log.info("#### #### imageId ={}",imageId);

		// user.id == principalId // image.user.getId 과 principalId 가 같을 때
		if(principalId==user.getId()) {
			System.out.println(" #### 로그인한 아이디와 이미지 userId가 같습니다");
		}else{
			System.out.println(" #### 로그인한 아이디와 이미지 userId가 다릅니다");
		}

		imageEntity.setCaption(imageReDto.getCaption()); // 이미지 경로 DB 저장.

		return imageEntity; // 세션에 저장 // 더티 체킹?


		// 영속화된 오브젝트 수정. 더티체킹.수정완료.
		/*
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
		*/


		/*
		//User userEntity = userRepository.findById(principalId).orElseThrow(()->{});
		User userEntity = userRepository.findById(principalId).orElseThrow(()->{
			throw new CustomApiException("유저를 찾을 수 없습니다.");
		});

		userEntity.setProfileImageUrl(imageFileName); // 이미지 경로 DB 저장.

		return userEntity; // 세션에 저장
		 */

	}

	}







