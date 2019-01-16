<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../public/head.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; utf-8" />
    <title>用户权限分配</title>
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/layui/css/layui.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <style type="text/css">
        .layui-input-block {margin-left: 60px;min-height: 36px;}
        .layui-form-checkbox span {margin-left: -12px;}
        .layui-form-checkbox[lay-skin=primary] i {width: 12px;height: 12px;top: 2px;}
        .mt-3{margin-top: 3px;}
    </style>
</head>
<body>
<div style="padding: 15px;">
    <form class="layui-form" id="permissionform">
        <div class="layui-input-block">
            <c:forEach items="${currentLoginUserMenus}" var="loginUserMenu">
                <c:if test="${loginUserMenu.level == '1'}">
                    <c:set var="level1code" value="${loginUserMenu.menuCode}"></c:set>
                    <div class="panel panel-default mt-10">
                        <div class="panel-header">
                            ${loginUserMenu.menuName}
                            <span class="ml-20"><input type="checkbox" permission-group="${loginUserMenu.menuCode}" lay-skin="primary" lay-filter="all" value="">全选</span>
                        </div>
                        <div class="panel-body">
                            <input type="checkbox" name="${loginUserMenu.menuCode}" value="${loginUserMenu.menuCode}" title="${loginUserMenu.title}" permission-group="${loginUserMenu.menuCode}" lay-skin="primary" identify-permission="permission"
                                <c:forEach items="${opUserMenus}" var="opUserMenu">
                                    <c:if test="${opUserMenu.level == '1' && opUserMenu.menuCode == level1code}">
                                        checked = "true"
                                    </c:if>
                                </c:forEach>
                            ><br/>
                            <div class="ml-20 mt-3">
                                <c:forEach items="${currentLoginUserMenus}" var="loginUserMenu1">
                                    <c:if test="${loginUserMenu1.parentCode == level1code}">
                                        <c:set var="level2code" value="${loginUserMenu1.menuCode}"></c:set>
                                        <div class="mt-3">
                                            <input type="checkbox" name="${loginUserMenu1.menuCode}" value="${loginUserMenu1.menuCode}" title="${loginUserMenu1.title}" permission-group="${loginUserMenu.menuCode}" lay-skin="primary" identify-permission="permission"
                                                <c:forEach items="${opUserMenus}" var="opUserMenu">
                                                    <c:if test="${opUserMenu.level == '2' && opUserMenu.menuCode == level2code}">
                                                           checked = "true"
                                                    </c:if>
                                                </c:forEach>
                                            >
                                            <c:forEach items="${currentLoginUserMenus}" var="loginUserMenu2">
                                                <c:if test="${loginUserMenu2.parentCode == level2code}">
                                                    <c:set var="level3code" value="${loginUserMenu2.menuCode}"></c:set>
                                                    <input type="checkbox" name="${loginUserMenu2.menuCode}" value="${loginUserMenu2.menuCode}" title="${loginUserMenu2.title}" permission-group="${loginUserMenu.menuCode}" lay-skin="primary" identify-permission="permission"
                                                    <c:forEach items="${opUserMenus}" var="opUserMenu">
                                                        <c:if test="${opUserMenu.level == '3' && opUserMenu.menuCode == level3code}">
                                                               checked = "true"
                                                        </c:if>
                                                    </c:forEach>
                                                    >
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
        <div  class="layui-input-block mt-10">
            <button class="btn btn-default radius" type="button" onclick="confirm_save('${opUserId}');"><i class="Hui-iconfont">&#xe632;</i>保存</button>
            <button class="btn btn-default radius" type="button" onclick="layer_close()"><i class="Hui-iconfont">&#xe6a6;</i>取消</button>
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
    var confirm_save = function (userId) {
        var objdata = $("input[type=checkbox]:checked");
        var jsonStr = "";
        if(objdata.length > 0){
            for(var i = 0 ; i < objdata.length ; i ++){
                if(objdata[i].value != "" && objdata[i].value != undefined){
                    if(i == objdata.length - 1)
                        jsonStr += objdata[i].value;
                    else
                        jsonStr += objdata[i].value+',';
                }
            }
            $.post("${ptsStatic}/save-user-permission",{"dataStr":jsonStr,"opUserId":userId},function (data) {
                if(data.success){
                    layer.msg(data.message,{icon:1,time:1500},function(){
                       layer_close();
                       parent.location.reload();
                    });
                }else{
                    layer.msg(data.message,{icon:2,time:1500});
                }
            })
        }
    }

</script>
</body>
</html>