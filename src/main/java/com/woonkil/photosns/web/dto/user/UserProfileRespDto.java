package com.woonkil.photosns.web.dto.user;

import com.woonkil.photosns.domain.user.User;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class UserProfileRespDto {
	private boolean subscribeState;
	private int subscribeCount;
	private int imageCount;
	private User user;
}
