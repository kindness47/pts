package com.pts.model;
/**
 * Description： 菜单实体类
 * Author: 刘永红
 * Date: Created in 2019/1/10 10:02
 */
public class Menu extends BaseModel{
    //菜单编码
    private String menuCode;
    //菜单名称
    private String menuName;
    //父级编码
    private String parentCode;
    //菜单url
    private String url;
    //菜单等级
    private Integer level;
    //图标class
    private String menuClass;
    //功能类型
    private Integer functionType;
    //排序
    private Integer sort;
    //菜单标题
    private String title;

    public String getMenuCode() {
        return menuCode;
    }

    public void setMenuCode(String menuCode) {
        this.menuCode = menuCode;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public String getParentCode() {
        return parentCode;
    }

    public void setParentCode(String parentCode) {
        this.parentCode = parentCode;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public String getMenuClass() {
        return menuClass;
    }

    public void setMenuClass(String menuClass) {
        this.menuClass = menuClass;
    }

    public Integer getFunctionType() {
        return functionType;
    }

    public void setFunctionType(Integer functionType) {
        this.functionType = functionType;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
