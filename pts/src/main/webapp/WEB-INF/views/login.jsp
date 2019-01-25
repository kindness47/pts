<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="public/head.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; utf-8" />
<title>登录</title>
	<link rel="stylesheet" type="text/css" href="${ptsStatic}/static/layui/css/layui.css" />
	<style type="text/css">
		.my-animal{
			width: 900px;
			height: 600px;
			margin: 0 auto;
		}
		.login-div{
			width: 400px;
			height: 250px;
			background-color:rgba(246,248,250,0.3);
			border-radius:2%;
			position:fixed;
			top:160px;
			left:0px;
			right:0px;
			margin-left:auto;
			margin-right:auto;
		}
		.form-div{
			padding:0 30px;
		}
		.layui-form-label{
			font-family: SF Pro Display,Roboto,Noto,Arial,PingFang SC,Hiragino Sans GB,Microsoft YaHei,sans-serif;
			width: 60px;
			color: #3d3d3d;
		}
		.layui-input-block {
			margin-left: 90px;
		}
		.layui-input-block input{
			background: rgba(255,255,255,0.6);
		}
		.layui-btn {
			font-family: SF Pro Display,Roboto,Noto,Arial,PingFang SC,Hiragino Sans GB,Microsoft YaHei,sans-serif;
			background-color: rgba(245,245,245,0.6) !important;
			color: #3d3d3d;
		}
		.layui-btn:hover {
			opacity: 1;
			color: #3d3d3d;
			background-color: rgba(210, 210, 210,0.8) !important;
		}
		.login-title{
			font-family: SF Pro Display,Roboto,Noto,Arial,PingFang SC,Hiragino Sans GB,Microsoft YaHei,sans-serif;
			font-size: 24px;
			color: #3d3d3d;
			text-align: center;
		}
	</style>
</head>
<body style="height: 100%">
<div id="my-animal" class="my-animal"></div>

<div class="login-div">
	<div class="form-div">
		<form class="layui-form" action="login" method="post">
			<div class="layui-form-item">
				<label class="layui-input-block">
					<div class="login-title">用户登录</div>
				</label>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">用户名</label>
				<div class="layui-input-block">
					<input type="text" name="account" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">密码</label>
				<div class="layui-input-block">
					<input type="password" name="passWord" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block">
					<input type="submit" class="layui-btn" value="登录">
				</div>
			</div>
		</form>
	</div>
</div>

<%@include file="public/footer.jsp"%>

<script type="text/javascript" src="${ptsStatic}/static/echarts.js"></script>
<script type="text/javascript" src="${ptsStatic}/mystatic/js/login/login-animal.js"></script>
<script type="text/javascript">
	layui.use("form",function () {
		var form = layui.form;
    });


    var body_click = function (params) {
        option.series[0].symbolSize = 6;
        if (params.name == 'btn-right') {
            if (index == animals.length - 1) {
                index = 0;
            } else {
                index++
            }
        } else {
            if (index == 0) {
                index = animals.length - 1;
            } else {
                index--
            }
        }
        option.series[0].data = animals[index].nodes;
        //两种过渡效果
        if (Math.random() > .5) {
            option.series[0].links = animals[index].links;
            myChart.setOption(option);
            setTimeout(function () {
                option.series[0].symbolSize = 2;
                myChart.setOption(option);
            }, 1000)
        } else {
            option.series[0].links = [];
            myChart.setOption(option);
            setTimeout(function () {
                option.series[0].links = animals[index].links;
                option.series[0].symbolSize = 2;
                myChart.setOption(option);
            }, 1000)
        }
    }

	$("body").off('click').on('click',function () {
	    var e = event||window.event;
        //alert(e.clientX+"--->"+e.clientY);
		//获取浏览器宽度和body点击的坐标
		var screenWidth = document.body.clientWidth,
			clickX = e.clientX;
		//需要进行的操作
		var op = clickX >= (screenWidth/2) ? "next" : "prev";
		var params = "";
		switch (op) {
			case "next":		//下一张
                params = {dataIndex: 1};
                body_click(params);
                break;
			case "prev":
                params = {dataIndex: 0};
                body_click(params);
                break;
        }

    });
</script>
</body>
</html>