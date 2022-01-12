package com.cos.photogram.handler.ex;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public enum ErrorCode {
    NOT_FOUND(404,"COMMON-ERR-404","PAGE NOT FOUND"),
    INTER_SERVER_ERROR(500,"COMMON-ERR-500","INTER SERVER ERROR"),
    USERNAME_DUPLICATION(400,"MEMBER-ERR-400","USERNAME DUPLICATED"),
    ;

    private int status;
    private String errorCode;
    private String message;

    public int getStatus() {
        return status;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public String getMessage() {
        return message;
    }
}
