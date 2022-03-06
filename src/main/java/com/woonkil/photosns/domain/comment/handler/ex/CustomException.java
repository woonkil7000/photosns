package com.woonkil.photosns.domain.comment.handler.ex;

import java.util.Map;

public class CustomException extends RuntimeException {

    //serialVersionUID 객체구분할때 사용
    private static final long serialVersionUID = 1L;

    public CustomException(String message){
        super(message);
    }

}
