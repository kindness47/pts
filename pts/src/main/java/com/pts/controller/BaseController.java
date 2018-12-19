package com.pts.controller;

import com.pts.base.Response;

/**
 * Description： 基础控制返回
 * Author: 刘永红
 * Date: Created in 2018/11/30 10:24
 */
public class BaseController {
    public Response returnSuccess(){
        return returnSuccess(null);
    }

    public Response returnSuccess(String successMsg){
        return returnSuccess(null,successMsg);
    }

    public Response returnSuccess(Object object){
        return returnSuccess(object,null);
    }

    public Response returnSuccess(Object object,String successMsg){
        Response response = new Response();
        response.setSuccess(true);
        response.setHasBusinessException(false);
        response.setResult(object);
        response.setMessage(successMsg);
        return response;
    }

    public Response returnValidateError(String errorCode,String errorMsg){
        Response response = new Response();
        response.setSuccess(false);
        response.setHasBusinessException(true);
        response.setErrCode(errorCode);
        response.setMessage(errorMsg);
        response.setErrMessage(errorMsg);
        return response;
    }
    public Response returnValidateError(String errorMsg){
        return returnValidateError(null,errorMsg);
    }
}
