package com.woonkil.photosns.web.dto.visitor;

import lombok.Data;

import javax.validation.Valid;

@Valid
@Data
public class VisitorDto {

    private String ip;
    private String pageUrl;
    private String device;
    private Integer userId;
}
