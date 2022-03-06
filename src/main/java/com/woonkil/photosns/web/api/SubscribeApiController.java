package com.woonkil.photosns.web.api;

import com.woonkil.photosns.config.auth.PrincipalDetails;
import com.woonkil.photosns.service.SubscribeService;
import com.woonkil.photosns.web.dto.CMRespDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
public class SubscribeApiController {

    private final SubscribeService subscribeService;

    // 구독하기
    @PostMapping("/api/subscribe/{toUserId}")
    public ResponseEntity<?>subscribe(@AuthenticationPrincipal PrincipalDetails principalDetails, @PathVariable int toUserId){
        int result = subscribeService.구독하기(principalDetails.getUser().getId(),toUserId);
        return new ResponseEntity<>(new CMRespDto<>(result,"구독하기 성공",null), HttpStatus.OK);
    }
    // 구독 취소
    @DeleteMapping("/api/subscribe/{toUserId}")
    public ResponseEntity<?>unSubscribe(@AuthenticationPrincipal PrincipalDetails principalDetails, @PathVariable int toUserId){
        int result = subscribeService.구독취소(principalDetails.getUser().getId(),toUserId);
        return new ResponseEntity<>(new CMRespDto<>(result,"구독취소 성공",null),HttpStatus.OK);
    }

}
