<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../public/head.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; utf-8" />
    <title>paixu</title>
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/layui/css/layui.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/mystatic/css/jquery-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <style type="text/css">
        .ui-tooltip{padding: 1px 8px;}
        .ui-widget{font-size: 0.7em;}
    </style>
</head>
<body class="layui-container">
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>机构排序</legend>
</fieldset>

<table class="table table-border table-bordered table-hover table-bg table-sort mt-20">
    <colgroup>
        <col width="150">
        <col width="100">
        <col width="70">
        <col width="50">
        <col width="50">
        <col width="80">
    </colgroup>
    <thead>
        <tr class="layui-text text-c">
            <th>组织机构名</th>
            <th>组织机构简称</th>
            <th>组织机构层级</th>
            <th>sort</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
    </thead>
    <tbody id="organization-sort-table-tbody"></tbody>
</table>

<%--分页插件--%>
<div id="sort-page"></div>

<script type="text/html" id="organization-sort-table-demo">
    {{# layui.each(d,function(index,o){ }}
        <tr class="text-c">
            <td>{{ o.organizationName }}</td>
            <td>{{ o.organizationShortName }}</td>
            <td>{{ o.level }}</td>
            <td>{{ o.sort }}</td>
            <td>
                {{# if(o.status == 1){  }}
                    <a href="javascript:;" style="color: green">√</a>
                {{# }else{  }}
                    <a href="javascipt:;" title="{{ o.exceptionDesc }}" style="color: red">×</a>
                {{# } }}
            </td>
            <td>
                <a title="上移一位" id="ss" href="javascript:;" onclick="change_organization_sort_toup('{{ o.id }}','{{ o.level }}','{{ o.sort }}')"><i class="Hui-iconfont">&#xe679;</i></a>
                <a title="下移一位" href="javascript:;" onclick="change_organization_sort_todown('{{ o.id }}','{{ o.level }}','{{ o.sort }}')"><i class="Hui-iconfont">&#xe674;</i></a>
                <a title="移到最前" href="javascript:;" onclick="change_organization_sort_tofirstup('{{ o.id }}','{{ o.level }}','{{ o.sort }}')"><i class="Hui-iconfont">&#xe699;</i></a>
                <a title="移到最后" href="javascript:;" onclick="change_organization_sort_tolastdown('{{ o.id }}','{{ o.level }}','{{ o.sort }}')"><i class="Hui-iconfont">&#xe698;</i></a>
            </td>
        </tr>
    {{# }); }}
</script>

<%@include file="../public/footer.jsp"%>

<!-- 请在下方写业务逻辑代码 -->
<script type="text/javascript" src="${ptsStatic}/static/layui/lay/modules/laytpl.js"></script>
<script type="text/javascript" src="${ptsStatic}/static/layui/lay/modules/laypage.js"></script>
<script type="text/javascript" src="${ptsStatic}/mystatic/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${ptsStatic}/mystatic/js/render-page-data.js"></script>

<script type="text/javascript">

    var size = 10;

    $("#organization-sort-table-tbody").on('tooltip','a',{
        show:{
            effect: "slideDown",
            delay: 250
        }
    });


    //渲染分页、表格的函数
    var renderPageTable = function(data){
        renderPageData("organization-sort-table-tbody","organization-sort-table-demo","sort-page",1,size,count,"${ptsStatic}/organizations",null);
    }

    //记录count
    var count;
    //获取count
    $.post("${ptsStatic}/organizations-count",function (data) {
        if(data.success){
            count = data.result;
            renderPageTable(data);
        }else
            layer.msg("数量获取失败",{icon:2,time:1500});
    })

    var change_organization_sort_toup = function (id,level,sort) {
        change_organization_sort(id,sort,level,"up");
    }
    var change_organization_sort_todown = function (id,level,sort) {
        change_organization_sort(id,sort,level,"down");
    }
    var change_organization_sort_tofirstup = function (id,level,sort) {
        change_organization_sort(id,sort,level,"tofirst");
    }
    var change_organization_sort_tolastdown = function (id,level,sort) {
        change_organization_sort(id,sort,level,"tolast");
    }
    var change_organization_sort = function (id,sort,level,op) {
        //请求排序操作
        $.post("organization-sort-change",{"id":id,"sort":sort,"level":level,"op":op},function (data) {
            layui.use('layer',function () {
                var layer = layui.layer;
                if(data.success){
                    layer.msg("操作成功",{icon:1,time:1500},function () {
                        renderPageTable(data);
                    });
                }else
                    layer.msg(data.message,{icon:2,time:1500});
            });

        });
    }

    $("#organization-sort-table-tbody ").find("a").click(function () {
        alert("sdsadsadsadsa");
    });
    $(document).tooltip({
        show: {
            effect: "slideDown",
            delay: 10
        }
    });

    $("body").on("click",$("div[role='tooltip']"),function () {
       $("div[role='tooltip']").remove();
    })
</script>
</body>
</html>