<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../public/head.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; utf-8" />
    <title>新增用户</title>
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/layui/css/layui.css" />
</head>
<body>
<div style="padding: 20px">
    <fieldset class="layui-elem-field layui-field-title">
        <legend>新增用户</legend>
    </fieldset>
    <form class="layui-form" action="/user-save" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label col-xs-4 col-md-2">用户名</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input layui-hide" name="id" value="${currentUser.id}">
                <input type="text" class="layui-input col-xs-7 col-md-9" name="userName" id="userName" lay-verify="required" placeholder="请输入用户名" value="${currentUser.userName}">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label col-xs-4 col-md-2">账户名</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input col-xs-7 col-md-9" name="account" id="account" lay-verify="required" placeholder="请输入账户名" value="${currentUser.account}">
            </div>
        </div>
        <c:if test="${currentUser.id == null}">
            <div class="layui-form-item">
                <label class="layui-form-label col-xs-4 col-md-2">密码</label>
                <div class="layui-input-block">
                    <input type="text" class="layui-input col-xs-7 col-md-9" name="passWord" id="passWord" lay-verify="required" placeholder="请输入密码">
                </div>
            </div>
        </c:if>
        <%--<div class="layui-form-item">
            <label class="layui-form-label col-xs-4 col-md-2">确认密码</label>
            <div class="layui-input-block">
                <input type="text" class="layui-input col-xs-7 col-md-9" id="confirmPassWord" lay-verify="required" placeholder="请再次输入密码">
            </div>
        </div>--%>
        <div class="layui-form-item">
            <label class="layui-form-label col-xs-4 col-md-2">角色</label>
            <div class="layui-input-block">
                <select name="roleName">
                    <option value="管理员" <c:if test="${currentUser.roleName == '管理员'}">selected</c:if> >管理员</option>
                    <option value="普通用户" <c:if test="${currentUser.roleName == '普通用户'}">selected</c:if> >普通用户</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button lay-submit class="layui-btn" >立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary" onclick="layer_close()">关闭</button>
            </div>
        </div>
    </form>
</div>

<%@include file="../public/footer.jsp"%>

<!-- 请在下方写业务逻辑代码 -->
<script type="text/javascript"src="${ptsStatic}/static/layui/lay/modules/form.js"></script>
<script type="text/javascript">
    layui.use(['form','layer'],function () {
        var form = layui.form,
            layer = layui.layer;
    })

</script>
</body>
</html>