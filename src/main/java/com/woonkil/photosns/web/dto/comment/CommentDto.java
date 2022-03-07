package com.woonkil.photosns.web.dto.comment;

import lombok.Data;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
@Valid
@Data
public class CommentDto {

    @Size(min=1,max=20)
    private String content;
    @NotNull // 자료형을 Integer 로 @NotNull 만 사용해야함. // @NotBlank:빈값,널,스페이스 @NotEmpty:빈값,널  사용 불가.
    private Integer imageId;
    private Integer commentCount;

    //  toEntity가 필요없음.
}
