package com.cos.photogram.domain.comment.handler.ex;

import lombok.Getter;

@Getter
public class UsernameDuplicateException extends RuntimeException{

    private ErrorCode errorCode;
    public UsernameDuplicateException(String message, ErrorCode errorCode){
        super(message);
        this.errorCode = errorCode;
    }

}
