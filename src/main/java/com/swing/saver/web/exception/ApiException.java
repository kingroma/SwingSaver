package com.swing.saver.web.exception;

import java.io.Serializable;

/**
 * Created by mycom on 2019-05-14.
 */
public class ApiException extends Exception implements Serializable {
    private static final long serialVersionUID = -259924810544627522L;
    private String errorMessage;
    private String errorCode;

    public String getErrorMessage() {
        return errorMessage;
    }

    public ApiException(String errorMessage) {
        super(errorMessage);
        this.errorMessage = errorMessage;
    }

    public ApiException() {
        super();
    }

    public String getErrorCode() {
        return errorCode;
    }
}
