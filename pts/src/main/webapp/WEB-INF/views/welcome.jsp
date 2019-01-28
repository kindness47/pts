<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="public/head.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta charset="utf-8">
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<meta http-equiv="Cache-Control" content="no-siteapp" />
	<!--[if lt IE 9]>
	<script type="text/javascript" src="${ptsStatic}/static/lib/html5shiv.js"></script>
	<script type="text/javascript" src="${ptsStatic}/static/lib/respond.min.js"></script>
	<![endif]-->
	<link rel="stylesheet" type="text/css" href="${ptsStatic}/static/layui/css/layui.css" />
	<link rel="stylesheet" type="text/css" href="${ptsStatic}/static/layui/css/modules/layer/default/layer.css" />
	<link rel="stylesheet" type="text/css" href="${ptsStatic}/static/h-ui/css/H-ui.min.css" />
	<link rel="stylesheet" type="text/css" href="${ptsStatic}/static/h-ui.admin/css/H-ui.admin.css" />
	<link rel="stylesheet" type="text/css" href="${ptsStatic}/static/lib/Hui-iconfont/1.0.8/iconfont.css" />
	<link rel="stylesheet" type="text/css" href="${ptsStatic}/static/h-ui.admin/skin/default/skin.css" id="skin" />
	<link rel="stylesheet" type="text/css" href="${ptsStatic}/static/h-ui.admin/css/style.css" />
	<!--[if IE 6]>
	<script type="text/javascript" src="${ptsStatic}/static/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
	<script>DD_belatedPNG.fix('*');</script>
	<![endif]-->
	<title>welcome</title>
</head>
<body>

	<div class="label">
		<label class="layui-form-label ml-5">欢迎您</label>
		<label class="layui-form-label" disabled="true">${user.userName}</label>
	</div>

	<div class="layui-btn" onclick="chulaibaPiKaQu()">专用绿帽弹窗</div>



	<script type="text/javascript" src="${ptsStatic}/static/lib/jquery/1.9.1/jquery.min.js"></script>
	<script type="text/javascript" src="${ptsStatic}/static/layui/layui.js"></script>
	<script type="text/javascript" src="${ptsStatic}/static/layui/lay/modules/layer.js"></script>

	<script type="text/javascript">
		chulaibaPiKaQu = function () {
			layui.use('layer',function () {
				layer = layui.layer;
				layer.open({
					title:"这是标题"
					,content:"请收好你的绿帽"
				});
			});
        }
	</script>
</body>
</html>