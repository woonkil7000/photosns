package com.woonkil.photosns.web.dto.user;

import com.woonkil.photosns.domain.user.User;
import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
public class UserUpdateDto {

    @NotBlank
    private String name; //필수
    //@NotBlank 업데이트할때는 공백 가능??
    private String password; //필수
    private String website;
    private String bio;
    private String phone;
    private String gender;

    //조금 위험함. 코드수정필요.
    public User toEntity(){
        return User.builder()
                .name(name)
                .password(password)
                .website(website)
                .bio(bio)
                .phone(phone)
                .gender(gender)
                .build();

    }
}
