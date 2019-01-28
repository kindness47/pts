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
			background: rgb(255,255,255);
            opacity: 0.7 !important;
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
        /*设置文字不能被选中*/
        .no-select{
            -webkit-user-select:none;
            -moz-user-select:none;
            -ms-user-select:none;
            user-select:none;
        }
        /*解决input自动选中背景变黄问题*/
        input:-webkit-autofill {
            box-shadow: 0 0 0 1000px rgb(254,254,254) inset !important;
			opacity: 0.7 !important;
            color: #3d3d3d !important;
        }
    </style>
</head>
<body style="height: 1000px;overflow-y: hidden">
<div id="my-animal" class="my-animal"></div>

<div class="login-div" id="login-div">
	<div class="form-div">
		<form class="layui-form" action="login" method="post">
			<div class="layui-form-item">
				<label class="layui-input-block">
					<div class="login-title no-select">用户登录</div>
				</label>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label no-select" autocomplete="off">用户名</label>
				<div class="layui-input-block">
					<input type="text" name="account" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label no-select">密码</label>
				<div class="layui-input-block">
					<input type="password" name="passWord" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-input-block no-select">
					<input type="submit" class="layui-btn" value="登录">
				</div>
			</div>
		</form>
	</div>
</div>

<%@include file="public/footer.jsp"%>

<script type="text/javascript" src="${ptsStatic}/static/echarts.min.js"></script>
<script type="text/javascript" src="${ptsStatic}/mystatic/js/login/login-animal.js"></script>
<script type="text/javascript">
	layui.use("form",function () {
		var form = layui.form;
    });


    var body_click = function (params) {
        option.series[0].symbolSize = 6;
        if (params.name == 'next') {
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
                params = {dataIndex: 1,name:"next"};
                body_click(params);
                break;
			case "prev":
                params = {dataIndex: 0,name:"prev"};
                body_click(params);
                break;
        }

    });

    //login_div宽高为400,250,左右居中,top:160px;
    var screenWidth = document.body.clientWidth,	//浏览器窗口宽度
		screenHeight = document.body.clientHeight,	//浏览器窗口高度
		INIT_MARGIN_LEFT = 0,							//div距离左边距离初始长度
		INIT_MARGIN_TOP = 160,						//div距离顶部初始长度
		CLICK_COUNT = 0,								//记录的x,y次数
		FIRST_X = 0,									//第一次有记录的mous x
		FIRST_Y = 0;									//第一次有记录的mous y

    $("#login-div").mousedown(function () {

        $("#login-div").on("mousemove",function () {
            var e = event||window.event;

            CLICK_COUNT ++;
            if(CLICK_COUNT == 1){
                FIRST_X = e.clientX;
                FIRST_Y = e.clientY;
                //console.log("first:"+FIRST_X+","+FIRST_Y);
                //console.log("first-left-top:"+INIT_MARGIN_LEFT+","+INIT_MARGIN_TOP);
            }else {
                //获取鼠标新的x,y
                var NEW_MOUSE_X = e.clientX,
                    NEW_MOUSE_Y = e.clientY;
                //console.log('('+NEW_MOUSE_X+','+NEW_MOUSE_Y+')');
                //移动距离
                var MOVE_X = NEW_MOUSE_X - FIRST_X,
                    MOVE_Y = NEW_MOUSE_Y - FIRST_Y;
                //console.log('move:'+MOVE_X+','+MOVE_Y+'-');
                //设置新的left,top
				var left = INIT_MARGIN_LEFT + MOVE_X*2,
					top = INIT_MARGIN_TOP +MOVE_Y;
                //console.log('distace'+left+','+top+'----');
				//$("#login-div").attr("style","left:"+left+"px;top:"+top+"px");
                $("#login-div").css("left",left+"px");
                $("#login-div").css("top",top+"px");
            }
        });
    });
    $("#login-div").on("mouseup",function () {
        $("#login-div").off("mousemove");
    });
    $("input").focus(function () {
        $("#login-div").off("mousemove");
        $("#login-div").off("mousedown");
        CLICK_COUNT = 0;
    });
    $("#login-div").dblclick(function () {
        var leftStr = $("#login-div").css("left"),
            topStr = $("#login-div").css("top");

        INIT_MARGIN_LEFT = Number(leftStr.substr(0,leftStr.indexOf("p"))); // $("#login-div").css("left")获取后是  比如 111px 得字符串
        INIT_MARGIN_TOP = Number(topStr.substr(0,topStr.indexOf("p")));

        $("#login-div").on("mousedown",function () {
            $("#login-div").on("mousemove",function () {

                var e = event || window.event;

                CLICK_COUNT++;
                if (CLICK_COUNT == 1) {
                    FIRST_X = e.clientX;
                    FIRST_Y = e.clientY;
                    //console.log("first:" + FIRST_X + "," + FIRST_Y);
                    //console.log("first-left-top:"+INIT_MARGIN_LEFT+","+INIT_MARGIN_TOP);
                } else {
                    //获取鼠标新的x,y
                    var NEW_MOUSE_X = e.clientX,
                        NEW_MOUSE_Y = e.clientY;
                    //console.log('(' + NEW_MOUSE_X + ',' + NEW_MOUSE_Y + ')');
                    //移动距离
                    var MOVE_X = NEW_MOUSE_X - FIRST_X,
                        MOVE_Y = NEW_MOUSE_Y - FIRST_Y;
                    //console.log('move:' + MOVE_X + ',' + MOVE_Y + '-');
                    //设置新的left,top
                    var left = INIT_MARGIN_LEFT + MOVE_X * 2,
                        top = INIT_MARGIN_TOP + MOVE_Y;
                    //console.log('distace' + left + ',' + top + '----');
                    //$("#login-div").attr("style","");
                    $("#login-div").css("left", left + "px");
                    $("#login-div").css("top", top + "px");
                }
            });
        });
    });
</script>
</body>
</html>