package com.cos.photogram.web.api;

import com.cos.photogram.config.auth.PrincipalDetails;
import com.cos.photogram.domain.user.User;
import com.cos.photogram.service.SubscribeService;
import com.cos.photogram.service.UserService;
import com.cos.photogram.web.dto.CMRespDto;
import com.cos.photogram.web.dto.subscribe.SubscribeDto;
import com.cos.photogram.web.dto.user.UserUpdateDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.util.List;

//@MultipartConfig(
//        fileSizeThreshold = 1024 * 1024 * 2, // 2mb
//        maxFileSize = 1024 * 1024 * 10, // 10mb
//        maxRequestSize = 1024 * 1024 * 50, //50mb
//        location = "c:/upload" //파일저장위치
//)
@Slf4j
@RequiredArgsConstructor
@RestController
public class UserApiController {

    private final UserService userService;
    private final SubscribeService subscribeService;

    @PostMapping("/api/user/{principalId}/profileImageUrl")
    public ResponseEntity<?>profileImageUrlUpdate(@PathVariable int principalId, MultipartFile profileImageFile,
                                                  @AuthenticationPrincipal PrincipalDetails principalDetails){

        // MultipartFile profileImageFile 변수 <== <input> tag의 name=과 동일해야함.
        System.out.println("############### public ResponseEntity<?>profileImageUrlUpdate() #####################");
        System.out.println("############### principalID =>"+principalId+" #####################");
        System.out.println("############### profileImageFile => "+profileImageFile+" #####################");
        System.out.println("############### principalDetails =>"+principalDetails+" #####################");
        User userEntity = userService.회원프로필사진변경(principalId,profileImageFile); // 세션 변경을 위해 userEntity 로 받음.
        principalDetails.setUser(userEntity); //변경된 세션 값에도 변경내용 반영
        return new ResponseEntity<>(new CMRespDto<>(1,"프로필사진변경 성공",null),HttpStatus.OK);
    }

    @GetMapping("/api/user/{pageUserId}/subscribe")
    public ResponseEntity<?> subscribeList(@AuthenticationPrincipal PrincipalDetails principalDetails,@PathVariable int pageUserId){

        System.out.println("########################### principalDetails.getUser().getId()  =>"+principalDetails.getUser().getId());
        System.out.println("######################## pageUserId =>"+pageUserId);
        List<SubscribeDto> subscribeDto = subscribeService.구독리스트(principalDetails.getUser().getId(),pageUserId);

        System.out.println(" ######################## List<SubscribeDto> subscribeDto = subscribeService.구독리스트() ###########################");
        return new ResponseEntity<>(new CMRespDto<>(1,"구독자 정보리스트 가져오기 성공",subscribeDto),HttpStatus.OK);
    }



    @PutMapping("/api/user/{id}") // update.js에서 redirect?
    public CMRespDto<?> update(
            @PathVariable int id,
            @Valid UserUpdateDto userUpdateDto,
            BindingResult bindingResult, // 꼭 Valid 다음 파라미터에 있어야함.
            @AuthenticationPrincipal PrincipalDetails principalDetails){

 /*       if(bindingResult.hasFieldErrors()){
            Map<String, String> errorMap = new HashMap<>();

            for(FieldError error:bindingResult.getFieldErrors()){
                errorMap.put(error.getField(),error.getDefaultMessage());
                System.out.println("=====================================");
                System.out.println(error.getDefaultMessage());
                System.out.println("=====================================");
            }
            throw new CustomValidationApiException("유효성 검사 실패함.",errorMap);

        }*/

            User userEntity = userService.회원수정(id, userUpdateDto.toEntity());
            log.info("============= UserApiController : userUpdateDto.toEntity() =============");
            //log.info("userUpdateDto=" + userUpdateDto.toEntity()); // 무한참조 에러
            //log.info("print userEntity = " + userEntity); // 무한참조 에러
            principalDetails.setUser(userEntity); //현재의 세션정보 변경 반영.
            return new CMRespDto<>(1, "회원수정완료", userEntity);
            // 응답시에 userEntity의 모든 getter함수가 호출되고 JSON으로 파싱하여 응답
        }


}
