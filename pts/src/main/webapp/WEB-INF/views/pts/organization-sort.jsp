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
<fieldset class="layui-elem-field layui-field-title" style="margin-top: 10px;">
    <legend>机构排序</legend>
</fieldset>

<span class="layui-breadcrumb" id="sort-nav" lay-separator="->"></span>

<table class="table table-border table-bordered table-hover table-bg table-sort">
    <colgroup>
        <col width="110">
        <col width="100">
        <col width="110">
        <col width="70">
        <col width="50">
        <col width="50">
        <col width="80">
    </colgroup>
    <thead>
        <tr class="layui-text text-c">
            <th>组织机构名</th>
            <th>组织机构简称</th>
            <th>父级机构</th>
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
            <td><a href="javascript:;" onclick="get_count_and_render_paged_data('{{ o.id }}','{{ o.level }}','{{ o.organizationName }}')">{{ o.organizationName }}</a></td>
            <td>{{ o.organizationShortName }}</td>
            <td>{{ o.parentName == null ? "":o.parentName }}</td>
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
                <a title="上移一位" id="ss" href="javascript:;" onclick="change_organization_sort_toup('{{ o.id }}','{{ o.level }}','{{ o.parentId }}','{{ o.sort }}')"><i class="Hui-iconfont">&#xe679;</i></a>
                <a title="下移一位" href="javascript:;" onclick="change_organization_sort_todown('{{ o.id }}','{{ o.level }}','{{ o.parentId }}','{{ o.sort }}')"><i class="Hui-iconfont">&#xe674;</i></a>
                <a title="移到最前" href="javascript:;" onclick="change_organization_sort_tofirstup('{{ o.id }}','{{ o.level }}','{{ o.parentId }}','{{ o.sort }}')"><i class="Hui-iconfont">&#xe699;</i></a>
                <a title="移到最后" href="javascript:;" onclick="change_organization_sort_tolastdown('{{ o.id }}','{{ o.level }}','{{ o.parentId }}','{{ o.sort }}')"><i class="Hui-iconfont">&#xe698;</i></a>
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

    layui.use('element',function () {
       var element = layui.element;
    });

    $("#organization-sort-table-tbody").on('tooltip','a',{
        show:{
            effect: "slideDown",
            delay: 250
        }
    });
    var current_page_id = "0";
    //定义导航栏数组和存储的参数 navParams{"id":当前点击元素的id,"level":当前点击元素level}
    var navList = new Array(),navParams;
    var get_count_and_render_paged_data = function(parentId,level,name){
        current_page_id = parentId;
        $.post("${ptsStatic}/organizations-count",{"parentId":parentId},function (data) {
            if(data.success){
                var count = data.result;
                var params={"parentId":parentId};
                renderPageData("organization-sort-table-tbody","organization-sort-table-demo","sort-page",params,count,"${ptsStatic}/organizations");

                navParams = {"id":parentId,"level":level,"name":name};
                //根据点击的元素level,操作navList
                var newNavList = new Array();
                switch(level) {
                    case '0'://点击首页
                        navList = [];
                        navList.push(navParams);
                        showNav(navList);
                        break;
                    case '1'://点击的元素level为1
                        newNavList = [];
                        newNavList[0] = navList[0];
                        newNavList.push(navParams);
                        showNav(newNavList);
                        break;
                    case '2'://点击元素level为2
                        newNavList = [];
                        newNavList[0] = navList[0];
                        newNavList[1] = navList[1];
                        newNavList.push(navParams);
                        showNav(newNavList);
                        break;
                }
            }else
                layer.msg("当前机构下没有子机构，不能进行排序",{icon:2,time:1500});
        })
    }

    get_count_and_render_paged_data(current_page_id,'0',"首页");

    var showNav = function (list) {
        var htmlStr = "";

        for(var i = 0 ; i < list.length ; i ++){
            alert(list[i].id+"-->"+list[i].name);
            htmlStr += "<a href='javascript:;' onclick='get_count_and_render_paged_data("+list[i].id+","+list[i].level+","+list[i].name+")>"+name+"</a><br/>";
        }
        $("#sort-nav").html(htmlStr);
    }

    var change_organization_sort_toup = function (id,level,parentId,sort) {
        change_organization_sort(id,sort,level,parentId,"up");
    }
    var change_organization_sort_todown = function (id,level,parentId,sort) {
        change_organization_sort(id,sort,level,parentId,"down");
    }
    var change_organization_sort_tofirstup = function (id,level,parentId,sort) {
        change_organization_sort(id,sort,level,parentId,"tofirst");
    }
    var change_organization_sort_tolastdown = function (id,level,parentId,sort) {
        change_organization_sort(id,sort,level,parentId,"tolast");
    }


    var change_organization_sort = function (id,sort,level,parentId,op) {
        //请求排序操作
        $.post("organization-sort-change",{"id":id,"sort":sort,"level":level,"parentId":parentId,"op":op},function (data) {
            layui.use('layer',function () {
                var layer = layui.layer;
                if(data.success){
                    layer.msg("操作成功",{icon:1,time:1500},function () {
                        get_count_and_render_paged_data(current_page_id);
                    });
                }else
                    layer.msg(data.message,{icon:2,time:1500});
            });

        });
    }



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