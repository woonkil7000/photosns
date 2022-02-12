package com.cos.photogram.domain.comment.handler.ex;

import java.util.Map;

public class CustomValidationException extends RuntimeException {

    //serialVersionUID 객체구분할때 사용
    private static final long serialVersionUID = 1L;

    private Map<String,String> errorMap;

    public CustomValidationException(String message, Map<String,String> errorMap){
        super(message);
        this.errorMap = errorMap;
    }
    public Map<String,String> getErrorMap(){
        return errorMap;
    }

}
