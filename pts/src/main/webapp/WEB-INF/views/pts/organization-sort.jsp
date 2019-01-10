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
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/mystatic/css/my-table-style.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/mystatic/css/my-defined.css" />
    <style type="text/css">
        .ui-tooltip{padding: 1px 8px;}
        .ui-widget{font-size: 0.7em;}
        legend{margin-bottom:0px !important;}
    </style>
</head>
<body class="layui-container">
    <fieldset class="layui-elem-field layui-field-title">
        <legend>机构排序</legend>
    </fieldset>

    <div id="sort-nav" class="ml-10"></div>

    <table class="table table-border table-bordered table-hover table-bg mt-10">
        <%--<colgroup>
            <col width="110">
            <col width="100">
            <col width="110">
            <col width="70">
            <col width="50">
            <col width="50">
            <col width="80">
        </colgroup>--%>
        <thead>
            <tr class="text-c">
                <th >组织机构名</th>
                <th>组织机构简称</th>
                <th>父级机构</th>
                <th>层级</th>
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
            <td><span class="long-text-hidden w-200"><a href="javascript:;" onclick="get_count_and_render_paged_data('{{ o.id }}','{{ o.level }}','{{ o.organizationName }}')">{{ o.organizationName }}</a></span></td>
            <td><span class="long-text-hidden w-200"><a href="javascript:;" onclick="get_count_and_render_paged_data('{{ o.id }}','{{ o.level }}','{{ o.organizationName }}')">{{ o.organizationShortName }}</a></span></td>
            <td><span class="long-text-hidden w-200">{{ o.parentName == null ? "":o.parentName }}</span></td>
            <td><span class="w-min-40 block">{{ o.level }}</span></td>
            <td><span class="w-min-40 block">{{ o.sort }}</span></td>
            <td><span class="w-min-40 block">
                {{# if(o.status == 1){  }}
                    <a href="javascript:;" style="color: green">√</a>
                {{# }else{  }}
                    <a href="javascipt:;" title="{{ o.exceptionDesc }}" style="color: red">×</a>
                {{# } }}
                </span>
            </td>
            <td><span class="w-min-70  w-max-150 block">
                    <a title="上移一位" id="ss" href="javascript:;" onclick="change_organization_sort_toup('{{ o.id }}','{{ o.level }}','{{ o.parentId }}','{{ o.sort }}')"><i class="Hui-iconfont">&#xe679;</i></a>
                    <a title="下移一位" href="javascript:;" onclick="change_organization_sort_todown('{{ o.id }}','{{ o.level }}','{{ o.parentId }}','{{ o.sort }}')"><i class="Hui-iconfont">&#xe674;</i></a>
                    <a title="移到最前" href="javascript:;" onclick="change_organization_sort_tofirstup('{{ o.id }}','{{ o.level }}','{{ o.parentId }}','{{ o.sort }}')"><i class="Hui-iconfont">&#xe699;</i></a>
                    <a title="移到最后" href="javascript:;" onclick="change_organization_sort_tolastdown('{{ o.id }}','{{ o.level }}','{{ o.parentId }}','{{ o.sort }}')"><i class="Hui-iconfont">&#xe698;</i></a>
                </span>
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
    //记录当前操作的对象id
    var current_params = {"id":0,"level":0,"name":"首页"};
    // navList用于记录导航栏数组
    var navList = new Array();
    //定义导航栏数组和存储的参数 navParams{"id":当前点击元素的id,"level":当前点击元素level}
    var navParams;

    var showNav = function (list) {
        var htmlStr = "<span class=\"layui-breadcrumb\" lay-separator=\"-->\">";

        for(var i = 0 ; i < list.length ; i ++){
            var info = list[i];
            htmlStr += "<a href='javascript:;' onclick=get_count_and_render_paged_data('"+info.id+"','"+info.level+"','"+info.name+"')>"+info.name+"</a>";
        }
        htmlStr += "</span>";
        $("#sort-nav").html(htmlStr);
        layui.use('element',function () {
           var element = layui.element;
           element.render('breadcrumb');
        });
    }

    var sort_organization_nav = function (id,level,organizationname) {
        navParams = {"id":id,"level":level,"name":organizationname};
        //newNavList用于操作展示导航栏数据
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
                //记录点击的节点
                navList.push(navParams);
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
    }


    var get_count_and_render_paged_data = function(parentId,level,organizationName){
        $.post("${ptsStatic}/organizations-count",{"parentId":parentId},function (data) {
            if(data.success){
                var count = data.result;
                var params={"parentId":parentId};
                renderPageData("organization-sort-table-tbody","organization-sort-table-demo","sort-page",params,count,"${ptsStatic}/organizations",null,null);
                sort_organization_nav(parentId.toString(),level.toString(),organizationName.toString());
            }else
                layer.msg("当前机构下没有子机构",{icon:2,time:1500});
        });
        current_params.id = parentId;
        current_params.level = level;
        current_params.name = organizationName;
    }

    get_count_and_render_paged_data(current_params.id,current_params.level,current_params.name);



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
                        get_count_and_render_paged_data(current_params.id,current_params.level,current_params.name);
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
    });
</script>
</body>
</html>