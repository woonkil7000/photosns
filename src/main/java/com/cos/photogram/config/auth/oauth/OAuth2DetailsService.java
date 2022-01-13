package com.cos.photogram.config.auth.oauth;

import com.cos.photogram.config.auth.PrincipalDetails;
import com.cos.photogram.domain.user.User;
import com.cos.photogram.domain.user.UserRepository;
import com.sun.istack.NotNull;
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
        log.info("======================== Map userInfo.toString => {}",userInfo.toString());

        //String username = "facebook_"+(String) userInfo.get("id"); // id = facebook id number
        String username="";
        if( (Map)userInfo.get("kakao_account") != null) {
            log.info("===================== if ===========================");
            username = "kakao_" + userInfo.get("id"); // id = facebook id number
        }else if((Map)userInfo.get("response") != null){
            log.info("================================= {}",userInfo.get("response").toString());
        }else if(userInfo.get("sub") != null){
            log.info("===================== else if 1 ===========================");
            username = "google_"+userInfo.get("sub"); // id = facebook id number
        }else if(userInfo.get("id") != null){
            log.info("===================== else if 2 ===========================");
            username = "facebook_"+userInfo.get("id"); // id = facebook id number
        }else{
            log.info("===================== else ===========================");
            username=null; // make error
        }

        String password = new BCryptPasswordEncoder().encode(UUID.randomUUID().toString());
        String email = (String) userInfo.get("email");
        String name = (String) userInfo.get("name");
        log.info("======================= password={},email={},name={}",password,email,name);

        if(userInfo.get("kakao_account") != null){
            log.info("========================== if userInfo.get('kakao_account') != null ================================");
            Map<String, Object> kakaoAccount = (Map<String, Object>)userInfo.get("kakao_account");
            log.info(" ###################  kakaoAccount={} ###################### ",kakaoAccount);

            // kakao_account안에 또 profile이라는 JSON객체가 있다. (nickname, profile_image)
            Map<String, Object> kakaoProfile = (Map<String, Object>)kakaoAccount.get("profile");
            log.info(" ###################  kakaoProfile={} ###################### ",kakaoProfile);

            name = (String) kakaoProfile.get("nickname");
            email = (String) ((Map)userInfo.get("kakao_account")).get("email");

        }
        if((Map)userInfo.get("response") != null){
            log.info("========================== if userInfo.get('response') != null ================================");
            Map<String, Object> attrb = (Map<String, Object>)userInfo.get("response");
            log.info(" ###################  attrb => {} ###################### ",attrb);

            // kakao_account안에 또 profile이라는 JSON객체가 있다. (nickname, profile_image)
            log.info(" ###################  => {} ###################### ");

            username = "naver_"+(String) attrb.get("id");
            name = (String) attrb.get("name");
            email = (String) attrb.get("email");
        }
        log.info(" ###################  username =>{},name =>{},email =>{} ###################### ",username,name,email);

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
