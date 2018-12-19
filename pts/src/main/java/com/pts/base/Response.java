package com.pts.base;

import java.io.Serializable;

/**
 * Description： 响应实体类
 * Author: 刘永红
 * Date: Created in 2018/11/30 10:07
 */
public class Response<T>  implements Serializable {
    //处理是否成功
    private boolean success;
    //返回结果有业务异常
    private boolean hasBusinessException;
    //业务异常错误代码
    private String errCode;
    //业务异常错误信息
    private String errMessage;
    //返回信息
    private String message;
    //正常返回的对象
    private T result;

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public boolean isHasBusinessException() {
        return hasBusinessException;
    }

    public void setHasBusinessException(boolean hasBusinessException) {
        this.hasBusinessException = hasBusinessException;
    }

    public String getErrCode() {
        return errCode;
    }

    public void setErrCode(String errCode) {
        this.errCode = errCode;
    }

    public String getErrMessage() {
        return errMessage;
    }

    public void setErrMessage(String errMessage) {
        this.errMessage = errMessage;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public T getResult() {
        return result;
    }

    public void setResult(T result) {
        this.result = result;
    }
}
