package com.woonkil.photosns.web.dto.user;

import com.woonkil.photosns.domain.user.User;
import lombok.*;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class UserProfileDto {
    private boolean pageOwnerState; // 이 페이지 주인인가?
    private int imageCount; // 이미지 수
    private boolean subscribeState; // 구독상태?
    private int subscribeCount; // 구독 수
    private User user; // 유저 Entity

}
