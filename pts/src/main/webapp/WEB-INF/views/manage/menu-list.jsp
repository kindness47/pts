<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../public/head.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; utf-8" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/layui/css/layui.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/mystatic/css/my-defined.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/mystatic/css/my-table-style.css" />

    <title>菜单管理</title>
</head>
<body>
<div><a class="btn btn-default radius r" style="line-height:0.8em;margin-top:2px;margin-right:20px;padding-left: 3px;padding-right: 3px;height: 22px;" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></div>
<div class="pd-20">
    <form>
    <div class="text-c">
        日期范围：
        <input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}'})" id="datemin" class="input-text Wdate" style="width:120px;">
        -
        <input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'datemin\')}',maxDate:'%y-%M-%d'})" id="datemax" class="input-text Wdate" style="width:120px;">
        <input type="text" class="input-text" style="width:250px" placeholder="请输入菜单名进行查找" id="menuName" name="menuName">
        <%--<a href="javascript:;" style="font-size: 0.3em;color: #3150a9c7" title="点击展开更多筛选条件" onclick="change_status()"><i class="Hui-iconfont">&#xe6d7;</i>点击展开更多筛选条件</a>
            <div class="row">
                <input type="text" class="input-text" style="width:250px" placeholder="请选择菜单等级进行查找" id="level" name="level">
                <select class="layui-select">
                    <option value=""
                </select>
            </div>
        --%>
            <button type="button" class="btn btn-success" id="submit-search" onclick="search_menu()" name=""><i class="icon-search"></i> 搜菜单</button>

    </div>
    </form>

    <div class="c1 bg-1 pd-5 mt-20">
            <a href="javascript:;" class="btn btn-secondary radius" onclick="menu_add()">
                <i class="Hui-iconfont">&#xe600;</i>新增
            </a>
            <a href="javascript:;" class="btn btn-secondary radius" onclick="menu_sort()">
                <i class="Hui-iconfont">&#xe600;</i>排序
            </a>
    </div>

    <table class="table table-border table-bordered table-striped table-hover mt-20" style="width: 900px">

        <thead>
            <tr class="text-c">
                <th>菜单编码</th>
                <th>菜单名称</th>
                <th>父级菜单</th>
                <th>url</th>
                <th>level</th>
                <th>图标</th>
                <th>功能类型</th>
                <th>sort</th>
                <th>创建时间</th>
                <th>创建人</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody id="menu-list-tbody"></tbody>
    </table>

    <div id="menu-list-page"></div>

</div>

<script type="text/html" id="menu-list-tbody-demo">
    {{# layui.each(d,function(index,menu){ }}
    <tr class="text-c">
        <td><span class="w-90 long-text-hidden">{{ menu.menuCode }}</span></td>
        <td><span class="w-90 long-text-hidden">{{ menu.menuName }}</span></td>
        <td><span class="w-90 long-text-hidden">{{ menu.parentName == null ? "":menu.parentName}}</span></td>
        <td><span class="w-100 long-text-hidden">{{ menu.url }}</span></td>
        <td><span class="w-40 long-text-hidden">{{ menu.level }}</span></td>
        <td><span class="w-50 long-text-hidden"><i class="Hui-iconfont">{{ menu.menuClass }}</i></span></td>
        <td><span class="w-50 long-text-hidden">{{ menu.functionType }}</span></td>
        <td><span class="w-40 long-text-hidden">{{ menu.sort }}</span></td>
        <td><span class="w-120 long-text-hidden">{{ timestampToTime(menu.createTime) }}</span></td>
        <td><span class="w-60 long-text-hidden">{{ menu.createBy == null ? "":menu.createBy }}</span></td>
        <td><span class="w-50 long-text-hidden">
            {{# if(menu.status == 1){ }}
            <span class="label label-success radius"><a>已启用</a></span>
            {{# }else{ }}
            <span class="label label-warning radius"><a title='{{ menu.exceptionDesc }}'>已禁用</a></span>
            {{# } }}
            </span>
        </td>
        <td><span class="w-min-70 w-max-100 block">
                {{# if(menu.status == 1){ }}
                <a title="停用" href="javascript:;" onclick="menu_setStatus('{{ menu.id }}',0)"><i class="Hui-iconfont">&#xe631;</i></a>
                {{# }else{ }}
                <a title="启用" href="javascript:;" onclick="menu_setStatus('{{ menu.id }}',1)"><i class="Hui-iconfont">&#xe6e6;</i></a>
                {{# } }}
                <a title="修改" href="javascript:;" onclick="menu_edit('{{ menu.id }}')"><i class="Hui-iconfont">&#xe6df;</i></a>

                <a title="删除" href="javascript:;" onclick="menu_delete('{{ menu.id }}')"><i class="Hui-iconfont">&#xe609;</i></a>

            </span>
        </td>
    </tr>
    {{# }); }}
</script>


<%@include file="../public/footer.jsp"%>

<!-- 请在下方写业务逻辑代码 -->
<script type="text/javascript" src="${ptsStatic}/static/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="${ptsStatic}/mystatic/js/time-convert.js"></script>
<script type="text/javascript" src="${ptsStatic}/mystatic/js/render-page-data.js"></script>

<script type="text/javascript">

    layui.use(['layer','element'],function () {
         var layer = layui.layer,
             element = layui.element;
    });

    /*var init_table = function () {
        $.post("\${ptsStatic}/get-menu-count",null,function (data) {
            renderPageData("menu-list-tbody","menu-list-tbody-demo","menu-list-page",null,data.result,"\${ptsStatic}/getmenus",null,{"color":"#FF5722"})
        });
    }*/
    var search_menu = function(){
        var mindate = $("#datemin").val(),
            maxdate = $("#datemax").val(),
            menuName = $("#menuName").val(),
            parmas = {"startTime":mindate,"endTime":maxdate,"menuName":menuName,"page":1,"limit":10};
        $.post("${ptsStatic}/get-menu-count",parmas,function(data){
            if(data.success){//查询成功--->展示
                renderPageData("menu-list-tbody","menu-list-tbody-demo","menu-list-page",parmas,data.result,"${ptsStatic}/getmenus",null,{"color":"#FF5722"})
            }else{
                layer.msg("查询数据失败",{icon:2,time:1500});
            }
        });
    }
    search_menu();

    var to_menu_add = function(width,height,title,content){
        layer.open({
            type:2,
            title:title,
            area:[width+'px',height+'px'],
            content:content,
            maxmin:true,
            resize:true
        });
    }

    var menu_add = function () {
        to_menu_add(500,410,"新增菜单","${ptsStatic}/menu-add");
    }

    var menu_setStatus = function (id,status) {
        var op_title = status == "1" ? "启用" : "停用";
        var htmlStr = status == "1"?"确认启用吗":"<label class=\"layui-form-label\" style=\"text-align:left\">操作缘由</label><textarea placeholder=\"请输入内容\" id=\"exceptionDesc\" class=\"layui-textarea\"></textarea>";
        layer.open({
            title:"确认操作",
            content:htmlStr,
            yes:function (index,layero) {
                var change_date = status == "1" ? {"id":id,"status":status} :{"id":id,"status":status,"exceptionDesc":$("#exceptionDesc").val()};
                $.post("${ptsStatic}/change-menustatus",change_date,function (data) {
                    if(data.success){
                        layer.msg(data.message,{icon:1,time:1500},function () {
                            location.reload();
                        });
                    }else
                        layer.msg(data.message,{icon:2,time:1500});
                })
            }
        });
    }

    var menu_edit = function (id) {
        to_menu_add(500,410,"修改菜单","${ptsStatic}/menu/"+id);
    }

    var menu_delete = function (id) {
        layer.open({
            title:"确认操作",
            content:"确认删除吗?",
            yes:function (index,layero) {
                $.post("${ptsStatic}/delete/"+id,function (data) {
                    if(data.success)
                        layer.msg(data.message,{icon:1,time:1500},function () {
                            location.reload();
                        })
                    else
                        layer.msg(data.message,{icon:2,time:1500});
                });
            }
        });
    }

</script>
</body>
</html>