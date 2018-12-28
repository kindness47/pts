package com.pts.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Comparator;

/**
 * Description： 排序工具类----通过传入的字段对list进行快速排序
 * Author: 刘永红
 * Date: Created in 2018/12/28 10:25
 */
public class SortListUtil<T> implements Comparator<T> {

    //进行排序的属性名
    private String propertyName;
    //进行排序的方式(true:升序;false:降序)
    private boolean isAsc;

    private static final Logger logger = LoggerFactory.getLogger(SortListUtil.class);

    public SortListUtil(String propertyName, boolean isAsc){
        this.propertyName = propertyName;
        this.isAsc = isAsc;
    }
    /** 根据类中的字段对对象进行排序
     * Description： TODO
     * Author: 刘永红
     * Date: Created in 2018/12/28 10:25
     */
    @SuppressWarnings({"unchecked","rawtypes"})
    @Override
    public int compare(T o1, T o2) {
        Class clazz = o1.getClass();
        Method method = getPropertyMethod(clazz,propertyName);

        try {
            Object object1 = method.invoke(o1);
            Object object2 = method.invoke(o2);
            if(object1 == null || object2 == null)
                return 0;
            Comparable value1 = (Comparable) object1;
            Comparable value2 = (Comparable) object2;
            if(isAsc)
                return value1.compareTo(value2);
            else
                return value2.compareTo(value1);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /** 获取传入的propertyName所对应的方法
     * Description： TODO
     * Author: 刘永红
     * Date: Created in 2018/12/28 10:25
     */
    @SuppressWarnings({"unchecked","rawtypes"})
    private Method getPropertyMethod(Class clazz,String propertyName){
        Method method = null;
        try {
            method = clazz.getMethod("get"+firstToUpperCase(propertyName));
        } catch (NoSuchMethodException e) {
            logger.warn("未找到propertyName(java.lang.String),请检查"+clazz.getName()+"是否存在方法get"+propertyName);
            e.printStackTrace();
        }
        return method;
    }
    /**
     * Description： 确保propertyName的首字母是大写
     * Author: 刘永红
     * Date: Created in 2018/12/28 10:25
     */
    private String firstToUpperCase(String propertyName){
        if(Character.isUpperCase(propertyName.charAt(0)))
            return propertyName;
        else
            return (new StringBuffer()).append(Character.toUpperCase(propertyName.charAt(0))).append(propertyName.substring(1)).toString();
    }

    public String getPropertyName() {
        return propertyName;
    }

    public void setPropertyName(String propertyName) {
        this.propertyName = propertyName;
    }

    public boolean isAsc() {
        return isAsc;
    }

    public void setAsc(boolean asc) {
        isAsc = asc;
    }
}
