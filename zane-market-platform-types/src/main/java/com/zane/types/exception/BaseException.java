package com.zane.types.exception;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class BaseException extends RuntimeException {

    private static final long serialVersionUID = 5317680961212299217L;

    /** 异常码 */
    private String code;

    /** 异常信息 */
    private String info;

    public BaseException(String code) {
        this.code = code;
    }

    public BaseException(String code, Throwable cause) {
        this.code = code;
        super.initCause(cause);
    }

    public BaseException(String code, String message) {
        this.code = code;
        this.info = message;
    }

    public BaseException(String code, String message, Throwable cause) {
        this.code = code;
        this.info = message;
        super.initCause(cause);
    }

    @Override
    public String toString() {
        return "com.zane.x.api.types.exception.XApiException{" +
                "code='" + code + '\'' +
                ", info='" + info + '\'' +
                '}';
    }

}
