package com.pts.util;

import java.util.UUID;

/**
 * Description： UUID生成器
 * Author: 刘永红
 * Date: Created in 2019/1/10 8:52
 */
public class UUIDUtil {
    public static String getUUIDString(){
        return UUID.randomUUID().toString().replace("-","");
    }
}
