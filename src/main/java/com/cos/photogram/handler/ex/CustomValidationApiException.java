package com.cos.photogram.handler.ex;

import java.util.Map;

public class CustomValidationApiException extends RuntimeException {

    //serialVersionUID 객체구분할때 사용
    private static final long serialVersionUID = 1L;

    private Map<String,String> errorMap;

    public CustomValidationApiException(String message){
        super(message);
    }
    public CustomValidationApiException(String message, Map<String,String> errorMap){
        super(message);
        this.errorMap = errorMap;
    }
    public Map<String,String> getErrorMap(){
        return errorMap;
    }

}
