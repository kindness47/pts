<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../public/head.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8">
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<link rel="stylesheet" type="text/css" href="${ptsStatic}/static/layui/css/layui.css" />
	<link rel="stylesheet" type="text/css" href="${ptsStatic}/static/h-ui/css/H-ui.min.css" />
	<link rel="stylesheet" type="text/css" href="${ptsStatic}/static/h-ui.admin/css/H-ui.admin.css" />
	<link rel="stylesheet" type="text/css" href="${ptsStatic}/static/lib/Hui-iconfont/1.0.8/iconfont.css" />
	<link rel="stylesheet" type="text/css" href="${ptsStatic}/static/lib/zTree/v3/css/zTreeStyle/zTreeStyle.css">
	<title>新增菜单</title>
	<style>
		#select2-roleName-results {max-height: 80px;}
		.select{height: 30px !important;}
	</style>
</head>
<body>

<article class="page-container">
	<form class="form form-horizontal" id="form-user-add">
		<input type="hidden" id="id" name="id" value="${menu.id}">
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3" style="text-align: right"><span class="c-red">*</span>菜单名称：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" placeholder="请输入菜单名称" value="${menu.menuName}" id="menuName" name="menuName">
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3" style="text-align: right"><span class="c-red">*</span>菜单层级：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<select id="level" class="form-control select" name="level" onchange="changeLevel()">
					<option value="1" <c:if test="${menu.level == 1}"> selected </c:if>>一级目录</option>
					<option value="2" <c:if test="${menu.level == 2}"> selected </c:if>>二级目录</option>
					<option value="3" <c:if test="${menu.level == 3}"> selected </c:if>>页面级</option>
				</select>
			</div>
		</div>
		<div class="row cl menu-title-div">
			<label class="form-label col-xs-4 col-sm-3" style="text-align: right">显示标题：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" value="${menu.title}" placeholder="请输入显示标题" id="title" name="title">
			</div>
		</div>
		<div class="row cl parent-code-select hidden">
			<label class="form-label col-xs-4 col-sm-3" style="text-align: right"><span class="c-red">*</span>父级目录：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<select id="parentCode" class="form-control select" name="parentCode" onchange="changeLevel()">
					<option value="0">--- 非一级目录必选 ---</option>
					<c:forEach items="${menus}" var="menu1">
						<c:if test="${menu1.level != '3'}">
							<option value="${menu1.menuCode}" level="${menu1.level}" <c:if test="${menu.parentCode == menu1.menuCode}"> selected</c:if> >${menu1.menuName}</option>
						</c:if>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3" style="text-align: right"><span class="c-red">*</span>菜单编码：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" placeholder="请输入菜单编码" id="menuCode" name="menuCode" value="${menu.menuCode}">
			</div>
		</div>
		<div class="row cl menu-class-icon">
			<label class="form-label col-xs-4 col-sm-3" style="text-align: right">菜单图标：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<select id="menuClass" class="form-control select" name="menuClass">
					<option value="">--- 一级目录选择(内置图标) ---</option>
					<option value="&-#xe62d;" class="Hui-iconfont" <c:if test="${menu.menuClass == '&#xe62d;'}"> selected</c:if> >&#xe62d;</option>
					<option value="&-#xe613;" class="Hui-iconfont" <c:if test="${menu.menuClass == '&#xe613;'}"> selected</c:if> >&#xe613;</option>
					<option value="&-#xe61a;" class="Hui-iconfont" <c:if test="${menu.menuClass == '&#xe61a;'}"> selected</c:if> >&#xe61a;</option>
					<option value="&-#xe62e;" class="Hui-iconfont" <c:if test="${menu.menuClass == '&#xe62e;'}"> selected</c:if> >&#xe62e;</option>
					<option value="&-#xe617;" class="Hui-iconfont" <c:if test="${menu.menuClass == '&#xe617;'}"> selected</c:if> >&#xe617;</option>
					<option value="&-#xe720;" class="Hui-iconfont" <c:if test="${menu.menuClass == '&#xe720;'}"> selected</c:if> >&#xe720;</option>
					<option value="&-#xe6bd;" class="Hui-iconfont" <c:if test="${menu.menuClass == '&#xe6bd;'}"> selected</c:if> >&#xe6bd;</option>
					<option value="&-#xe641;" class="Hui-iconfont" <c:if test="${menu.menuClass == '&#xe641;'}"> selected</c:if> >&#xe641;</option>
				</select>
			</div>
		</div>
		<div class="row cl menu-url hidden ">
			<label class="form-label col-xs-4 col-sm-3" style="text-align: right">菜单url：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" placeholder="二级菜单必填" id="url" name="url" value="${menu.url}">
			</div>
		</div>
		<div class="row cl hidden function-type-select">
			<label class="form-label col-xs-4 col-sm-3" style="text-align: right">按钮功能：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<select id="functionType" class="form-control select" name="functionType">
					<option value="0" <c:if test="${menu.functionType == 0}">selected</c:if> >通用控制</option>
					<option value="1" <c:if test="${menu.functionType == 1}">selected</c:if> >按钮</option>
					<option value="2" <c:if test="${menu.functionType == 2}">selected</c:if> >图标按钮</option>
				</select>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-3" style="text-align: right">排序：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" class="input-text" placeholder="请输入菜单排序,非必需,默认0" id="sort" name="sort" value="${menu.sort}">
			</div>
		</div>
		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
				<input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;保存&nbsp;&nbsp;">
				<input id="delBtn" class="btn btn-primary radius" type="button" value="&nbsp;&nbsp;关闭&nbsp;&nbsp;">
			</div>
		</div>
	</form>
</article>

<%@include file="../public/footer.jsp"%>
<!--请在下方写此页面业务相关的脚本--> 
<script type="text/javascript" src="${ptsStatic}/static/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="${ptsStatic}/static/lib/jquery.validation/1.14.0/jquery.validate.js"></script>
<script type="text/javascript" src="${ptsStatic}/static/lib/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="${ptsStatic}/static/lib/jquery.validation/1.14.0/messages_zh.js"></script>

<!-- END PAGE LEVEL PLUGINS -->

<script type="text/javascript">

$(function(){

    $("#delBtn").on("click",function () {
        layer_close();
    });
	
	$("#form-user-add").validate({
		rules:{
            menuName:{
				required:true,
				minlength:1,
				maxlength:60
			},
            level:{
                required:true
			},
            menuCode:{
                required:true
			}
		},
		onkeyup:false,
		focusCleanup:true,
		success:"valid",
		submitHandler:function(form){
            $(form).ajaxSubmit({
                url: "${ptsStatic}/menu-save",
                type:"post",
                async:false,
                success: function (data) {
                    if (data.success) {
                        parent.layer.msg(data.message, {icon: 6, time: 2000}, function () {
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.location.reload();
                            parent.layer.close(index);
                        });
                    } else {
                        switch (data.errCode) {
							case "050101":
							    layer.msg(data.message,{icon:5,time:1500});
							    break;
							case "050102":
                                var index = layer.open({
                                    title:"提示",
                                    content:data.message+",是否设置为当前目录下的最大排序？",
                                    yes:function () {
                                        var params={"parentCode":$("#parentCode").val(),"level":$("#level").val()};
                                        $.post("${ptsStatic}/get-max-sort",params,function (data) {
                                            $("#sort").val(data.result+1);
                                            layer.close(index);
                                            layer.msg("已设置为当前层级的最大排序",{icon:1,time:1500});
                                        })
                                    }
                                });
                                break;
                        }
                    }
                },
				error:function () {
                    parent.layer.msg("系统错误", {icon: 5, time: 2000});
                }
            });
            return false;
		}
	});
});
function changeLevel(){
    var level = $("#level").val();

    //LEVEL1菜单目录(一级目录);LEVEL2功能菜单(二级目录);LEVEL3菜单功能(页面级)
    var LEVEL1 = '1',LEVEL2 = '2',LEVEL3 = '3';

    if(level != LEVEL1){
        $(".menu-class-icon").removeClass("block").addClass("hidden");
        $(".parent-code-select").removeClass("hidden").addClass("block");
	}else {
        $(".menu-class-icon").removeClass("hidden").addClass("block");
        $(".parent-code-select").removeClass("block").addClass("hidden");
    }
    if(level == LEVEL2){
        $(".menu-url").removeClass("hidden").addClass("block");
        $("option[level="+LEVEL1+"]").removeClass("hidden");
        $("option[level="+LEVEL2+"]").addClass("hidden");
    }else
        $(".menu-url").removeClass("block").addClass("hidden");
    if(level == LEVEL3){
        $(".menu-title-div").removeClass("block").addClass("hidden");
    	$(".function-type-select").removeClass("hidden").addClass("block");
        $("option[level="+LEVEL1+"]").addClass("hidden");
        $("option[level="+LEVEL2+"]").removeClass("hidden");
    }else {
        $(".menu-title-div").removeClass("hidden").addClass("block");
        $(".function-type-select").removeClass("block").addClass("hidden");
    }
}

changeLevel();
</script>
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>