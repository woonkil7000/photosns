package com.cos.photogram.domain.comment.handler;

import com.cos.photogram.domain.comment.handler.ex.CustomApiException;
import com.cos.photogram.domain.comment.handler.ex.CustomException;
import com.cos.photogram.domain.comment.handler.ex.CustomValidationApiException;
import com.cos.photogram.domain.comment.handler.ex.CustomValidationException;
import com.cos.photogram.utils.Script;
import com.cos.photogram.web.dto.CMRespDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@ControllerAdvice
public class ControllerExceptionHandler {

    @ExceptionHandler(CustomValidationException.class)
    public String validationException(CustomValidationException e) {
        //////////////////////////////// CMRespDto, Script 비교 ////////////////////////////////
        /////////////////////// 사람: 클라이언트에게 응답할때는 Script가 좋음 /////////////////////////
        /////////////////////// 기기, Device: Ajax, Android 통신할때는 CMRespDto가 좋음 ////////////
        log.info("===================  (String) validation Exception 실행됨 =============================");

        if(e.getErrorMap() == null) {
            return Script.back(e.getMessage());
        }else{
            return Script.back(e.getErrorMap().toString());
        }
    }

    @ExceptionHandler(CustomException.class)
    public String Exception(CustomException e) {
        //////////////////////////////// CMRespDto, Script 비교 ////////////////////////////////
        /////////////////////// 사람: 클라이언트에게 응답할때는 Script가 좋음 /////////////////////////
        /////////////////////// 기기, Device: Ajax, Android 통신할때는 CMRespDto가 좋음 ////////////
        log.info("===================  (String) Exception 실행됨 =============================");
        return Script.back(e.getMessage());
    }

    @ExceptionHandler(CustomValidationApiException.class)
    public ResponseEntity<?> validationApiException(CustomValidationApiException e) {
        //////////////////////////////// CMRespDto, Script 비교 ////////////////////////////////
        /////////////////////// 사람: 클라이언트에게 응답할때는 Script가 좋음 /////////////////////////
        /////////////////////// 기기, Device: Ajax, Android 통신할때는 CMRespDto가 좋음 ////////////
        log.info("=================== (ResponseEntity) validation ApiException 실행됨 =============================");
        return new ResponseEntity<>(new CMRespDto<>(-1, e.getMessage(), e.getErrorMap()), HttpStatus.BAD_REQUEST);

    }

    //    public CMRespDto<?> validationApiException(CustomValidationApiException e){
    //////////////////////////////// CMRespDto, Script 비교 ////////////////////////////////
    /////////////////////// 사람: 클라이언트에게 응답할때는 Script가 좋음 /////////////////////////
    /////////////////////// 기기, Device: Ajax, Android 통신할때는 CMRespDto가 좋음 ////////////
    //        return new CMRespDto<>(-1,e.getMessage(),e.getErrorMap());
    //    }
    @ExceptionHandler(CustomApiException.class)
    public ResponseEntity<?> apiException(CustomApiException e) {
        log.info("===================  (ResponseEntity) api Exception 실행됨 =============================");
        return new ResponseEntity<>(new CMRespDto<>(-1, e.getMessage(), null), HttpStatus.BAD_REQUEST);
    }

}
