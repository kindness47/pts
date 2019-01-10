<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../public/head.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; utf-8" />
    <title>用户权限分配</title>
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/layui/css/layui.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/h-ui/css/H-ui.min.css" />
</head>
<body>
<div style="padding: 20px;">
    <form class="layui-form" id="permissionform">
        <div class="layui-input-block">
    <c:forEach items="${currentLoginUserMenus}" var="loginUserMenu">
        <c:if test="${loginUserMenu.level == '1'}">
            <c:set var="level1code" value="${loginUserMenu.menuCode}"></c:set>
            <div class="panel panel-default">
                <div class="panel-header">
                    ${loginUserMenu.menuName}
                    <span class="ml-20"><input type="checkbox" permission-group="${loginUserMenu.menuCode}" lay-skin="primary" lay-filter="all">全选</span>
                </div>
                <div class="panel-body">
                    <input type="checkbox" name="${loginUserMenu.menuCode}" title="${loginUserMenu.title}" permission-group="${loginUserMenu.menuCode}" lay-skin="primary"><br/>
                    <c:forEach items="${currentLoginUserMenus}" var="loginUserMenu1">
                        <c:if test="${loginUserMenu1.parentCode == level1code}">
                            <c:set var="level2code" value="${loginUserMenu1.menuCode}"></c:set>
                            <input type="checkbox" name="${loginUserMenu1.menuCode}" title="${loginUserMenu1.title}" permission-group="${loginUserMenu.menuCode}" lay-skin="primary">
                            <c:forEach items="${currentLoginUserMenus}" var="loginUserMenu2">
                                <c:if test="${loginUserMenu2.parentCode == level2code}">
                                    <input type="checkbox" name="${loginUserMenu2.menuCode}" title="${loginUserMenu2.title}" permission-group="${loginUserMenu.menuCode}" lay-skin="primary">
                                </c:if>
                            </c:forEach>
                            <br/>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </c:forEach>
        </div>
    </form>
</div>

<%@include file="../public/footer.jsp"%>

<!-- 请在下方写业务逻辑代码 -->
<script type="text/javascript" src="${ptsStatic}/static/layui/lay/modules/form.js"></script>
<script type="text/javascript">
    layui.use(['form','layer'],function () {
        var form = layui.form,
            layer = layui.layer;

        form.on('checkbox(all)',function (data) {
            //console.log(data.elem); //得到checkbox原始DOM对象
            //console.log(data.elem.checked); //是否被选中，true或者false
            //console.log(data.value); //复选框value值，也可以通过data.elem.value得到
            //console.log(data.othis); //得到美化后的DOM对象
            if(data.elem.checked){
                var permissiongroup = $(data.elem).attr("permission-group");
                $("#permissionform").find("input[permission-group="+permissiongroup+"]").prop("checked",true);
                form.render('checkbox');
            }else{
                var permissiongroup = $(data.elem).attr("permission-group");
                $("#permissionform").find("input[permission-group="+permissiongroup+"]").prop("checked",false);
                form.render('checkbox');
            }
        });
    });

</script>
</body>
</html>