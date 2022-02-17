package com.cos.photogram.web.dto.image;

import org.springframework.web.multipart.MultipartFile;

import com.cos.photogram.domain.image.Image;
import com.cos.photogram.domain.user.User;

import lombok.Data;

@Data
public class ImageReqDto {

	// 이미지 업로드 폼에서 입력한 값들
	private MultipartFile file; // 첨부 파일을 여기로 받는다.
	private String caption; // 해당 사진의 부가 정보1
	private String tags; // 해당 사진의 부가 정보2
	private String contentType; // 파일 Type
	
	public Image toEntity(String postImageUrl,String contentType, User userEntity) {
		return Image.builder()
				.caption(caption)
				.postImageUrl(postImageUrl)
				.contentType(contentType)
				.user(userEntity)
				.build();
	}
}
