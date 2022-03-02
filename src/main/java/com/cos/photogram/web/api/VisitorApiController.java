package com.cos.photogram.web.api;

import com.cos.photogram.config.auth.PrincipalDetails;
import com.cos.photogram.domain.visitor.Visitor;
import com.cos.photogram.domain.visitor.VisitorRepository;
import com.cos.photogram.service.VisitorService;
import com.cos.photogram.web.dto.CMRespDto;
import com.cos.photogram.web.dto.visitor.VisitorDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RequiredArgsConstructor
@RestController
public class VisitorApiController {

    private final VisitorService visitorService;
    private final VisitorRepository visitorRepository;

    @PostMapping("/api/visitor")
    public ResponseEntity<?>visitorSave(@RequestBody VisitorDto visitorDto, BindingResult bindingResult, @AuthenticationPrincipal PrincipalDetails principalDetails){

        Visitor visitor =visitorService.방문기록(visitorDto.getIp(),visitorDto.getPageUrl(),visitorDto.getDevice(),principalDetails.getUser().getId());
        return new ResponseEntity<>(new CMRespDto<>(1,"방문기록 성공",visitor), HttpStatus.CREATED);
    }
    @GetMapping("/api/visitor")
    public ResponseEntity<?>getVisitor(@AuthenticationPrincipal PrincipalDetails principalDetails, @PageableDefault(size=20) Pageable pageable){
        Page<Visitor> visitors =visitorService.방문조회(principalDetails.getUser().getId(),pageable);
        if (visitors.isEmpty()) { // ############### 방문자가 없는 경우 에러
            return new ResponseEntity<>(new CMRespDto<>(-1,"List images 없음",null), HttpStatus.BAD_REQUEST);
        } else {
            return new ResponseEntity<>(new CMRespDto<>(1, "List images 담기 성공", visitors), HttpStatus.OK);
        }
    }

}
