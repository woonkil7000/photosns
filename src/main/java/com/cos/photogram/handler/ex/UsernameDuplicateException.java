package com.cos.photogram.handler.ex;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;

@Getter
public class UsernameDuplicateException extends RuntimeException{

    private ErrorCode errorCode;
    public UsernameDuplicateException(String message, ErrorCode errorCode){
        super(message);
        this.errorCode = errorCode;
    }

}
