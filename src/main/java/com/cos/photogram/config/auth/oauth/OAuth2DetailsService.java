package com.cos.photogram.config.auth.oauth;

import com.cos.photogram.config.auth.PrincipalDetails;
import com.cos.photogram.domain.user.User;
import com.cos.photogram.domain.user.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.UUID;

@RequiredArgsConstructor
@Slf4j
@Service
public class OAuth2DetailsService extends DefaultOAuth2UserService {

    private final UserRepository userRepository;

    //private final BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        log.info("===================== OAuth2 서비스 탐. ===========================");
        OAuth2User oAuth2User = super.loadUser(userRequest);
        log.info("======================== OAuth2User oAuth2User.toString() => {}",oAuth2User.toString());
        log.info("======================== OAuth2User oAuth2User.getAttributes() => {}",oAuth2User.getAttributes());
        // username,password,email required
        Map<String,Object> userInfo = oAuth2User.getAttributes();
        //String username = "facebook_"+(String) userInfo.get("id"); // id = facebook id number
        String username;
        if(userInfo.get("id") != null){
            username = "facebook_"+(String) userInfo.get("id"); // id = facebook id number
        }else if(userInfo.get("sub") != null){
            username = "google_"+(String) userInfo.get("sub"); // id = facebook id number
        }else{
            username=null; // make error
        }

        String password = new BCryptPasswordEncoder().encode(UUID.randomUUID().toString());
        String email = (String) userInfo.get("email");
        String name = (String) userInfo.get("name");
        // 기존 가입정보 확인
        User userEntity = userRepository.findByUsername(username);

        if(userEntity == null){
            User user = User.builder()
                    .username(username)
                    .password(password)
                    .name(name)
                    .email(email)
                    .role("USER")
                    .build();
            log.info("================= User user = User.builder() => {}",user.toString());
            return new PrincipalDetails(userRepository.save(user),oAuth2User.getAttributes());

        }else{ // 기존 가입회원 로그인 처리

            log.info("================= userEntity.toString() => {}",userEntity.toString());
            return new PrincipalDetails(userEntity,oAuth2User.getAttributes());
            // oAuth2User.getAttributes() facebook 로그인 사용자 구분할때만 필요.
        }

    }
}
