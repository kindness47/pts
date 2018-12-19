<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../public/head.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; utf-8" />
    <title>Insert title here</title>
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <style type="text/css" >
        body{height: 90% !important;}
        .text-r{text-align: right !important}
        .row{box-sizing:border-box;margin-left:0px;margin-right:0px}
    </style>
</head>

<body>
<article class="page-container mt-10">
<form class="form form-horizontal" id="organization-add-form" method="post">
    <input type="hidden" name="id" value="${organization.id}">
    <div class="row clearfix">
        <label class="form-label col-xs-4 col-sm-2 text-r"><span class="c-red">*</span>机构名</label>
        <div class="formControls col-xs-7 col-sm-9">
            <input type="text" class="input-text" id="organizationName" name="organizationName" value="${organization.organizationName}">
        </div>
    </div>
    <div class="row clearfix">
        <label class="form-label col-xs-4 col-sm-2 text-r"><span class="c-red">*</span>机构简称</label>
        <div class="formControls col-xs-7 col-sm-9">
            <input type="text" class="input-text" id="organizationShortName" name="organizationShortName" value="${organization.organizationShortName}">
        </div>
    </div>
    <div class="row clearfix">
        <label class="form-label col-xs-4 col-sm-2 text-r">父机构名称</label>
        <div class="formControls col-xs-7 col-sm-9">
            <span class="select-box">
                <select id="parentId" name="parentId" class="select">
                    <option value="">-----请选择----</option>
                    <c:forEach items="${organizations}" var="o">
                        <option value="${o.id}" <c:if test="${o.id == organization.parentId}">selected</c:if> >${o.organizationName}</option>
                    </c:forEach>
                </select>
            </span>
        </div>
</div>
<div class="row clearfix">
    <div class="col-xs-7 col-sm-9 col-xs-offset-4 col-sm-offset-2">
        <button class="btn btn-default radius" type="submit"><i class="Hui-iconfont">&#xe632;</i>保存</button>
        <button class="btn btn-default radius" type="button" onclick="layer_close()"><i class="Hui-iconfont">&#xe6a6;</i>取消</button>
    </div>
</div>
</form>
</article>


<%@include file="../public/footer.jsp"%>

<script type="text/javascript"src="${ptsStatic}/static/lib/jquery.validation/1.14.0/jquery.validate.js"></script>
<script type="text/javascript"src="${ptsStatic}/static/lib/jquery.validation/1.14.0/messages_zh.js"></script>

<!-- 请在下方写业务逻辑代码 -->
<script type="text/javascript">

    $("#organization-add-form").validate({
        rules:{
            organizationName:{
                required:true
            },
            organizationShortName:{
                required:true
            }
        },
        message:{
            organizationName:"请输入组织机构",
            organizationShortName:"请输入组织机构简称"
        },
        onkeyup:false,
        focusCleanup:true,
        success:"valid",
        submitHandler:function (form) {
            $(form).ajaxSubmit({
                url:"organization-save",
                async:false,
                type:"post",
                success:function (data) {
                    if(data.success)
                        layer.msg(data.message,{icon:1,time:1500},function () {
                            layer_close();
                        });
                    else
                        layer.msg(data.message,{icon:2,time:1500});
                },
                end:function () {
                    location.reload();
                }
            });
        }
    });

</script>
</body>
</html>