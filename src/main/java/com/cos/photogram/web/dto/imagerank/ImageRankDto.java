package com.cos.photogram.web.dto.imagerank;

import com.cos.photogram.domain.user.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
@Data
public class ImageRankDto {


    private String imageId;
    private String caption;
    private String postImageUrl;
    private String userId;
    private Integer likeCount;
    private User user; // 유저 Entity


}
