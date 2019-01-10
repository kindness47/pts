<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../public/head.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; utf-8" />
    <title>用户管理</title>
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/layui/css/layui.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/mystatic/css/jquery-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/mystatic/css/my-defined.css" />
    <style type="text/css">
        .ui-tooltip{padding: 1px 5px;}
        .ui-widget{font-size: 0.7em;}
    </style>
</head>
<body>
<div><a class="btn btn-default radius r" style="line-height:0.8em;margin-top:2px;margin-right:20px;padding-left: 3px;padding-right: 3px;height: 22px;" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></div>
<div class="pd-20">
    <div class="text-c"> 日期范围：
        <input type="text" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}'})" id="datemin" class="input-text Wdate" style="width:120px;">
        -
        <input type="text" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'datemin\')}',maxDate:'%y-%M-%d'})" id="datemax" class="input-text Wdate" style="width:120px;">
        <input type="text" class="input-text" style="width:250px" placeholder="请输入用户名进行查找" id="searchName" name="userName">
        <button type="button" class="btn btn-success" id="submit-search" onclick="search_user()" name=""><i class="icon-search"></i> 搜用户</button>
    </div>

    <div class="c1 bg-1 pd-5 mt-20">
        <a href="javascript:;" class="btn btn-secondary radius" onclick="user_add()">
            <i class="Hui-iconfont">&#xe600;</i>新增
        </a>
    </div>

    <table class="table table-border table-bordered table-striped table-hover mt-20">
        <%--<colgroup>
            <col width="">
        </colgroup>--%>
        <thead>
            <tr class="text-c">
                <th>用户名称</th>
                <th>用户账号</th>
                <th>角色</th>
                <th>创建时间</th>
                <th>创建人</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody id="user-list-tbody"></tbody>
    </table>

    <div id="user-list-page"></div>

</div>

<script type="text/html" id="user-list-tbody-demo">
    {{# layui.each(d,function(index,user){ }}
        <tr class="text-c">
            <td>{{ user.userName }}</td>
            <td>{{ user.account }}</td>
            <td>{{ user.roleName }}</td>
            <td>{{ timestampToTime(user.createTime) }}</td>
            <td>{{ user.createBy }}</td>
            <td>
                {{# if(user.status == 1){ }}
                    <span class="label label-success radius">已启用</span>
                {{# }else{ }}
                    <span class="label label-warning radius">已禁用</span>
                {{# } }}
            </td>
            <td><span class="w-min-100 block">
                {{# if(user.status == 1){ }}
                    <a title="停用" href="javascript:;" onclick="user_setStatus('{{ user.id }}',0)"><i class="Hui-iconfont">&#xe631;</i></a>
                {{# }else{ }}
                    <a title="启用" href="javascript:;" onclick="user_setStatus('{{ user.id }}',1)"><i class="Hui-iconfont">&#xe6e6;</i></a>
                {{# } }}
                    <a title="修改" href="javascript:;" onclick="user_edit('{{ user.id }}')"><i class="Hui-iconfont">&#xe6df;</i></a>
                    <a title="删除" href="javascript:;" onclick="user_delete('{{ user.id }}')"><i class="Hui-iconfont">&#xe609;</i></a>
                    <a title="权限管理" href="javascript:;" onclick="user_permission('{{ user.id }}')"><i class="Hui-iconfont">&#xe61d;</i></a>
                    <a title="重置密码" href="javascript:;" onclick="user_reset_password('{{ user.id }}','{{ user.userName }}')"><i class="Hui-iconfont">&#xe605;</i></a>
                </span>
            </td>
        </tr>
    {{# }); }}
</script>

<%@include file="../public/footer.jsp"%>

<!-- 请在下方写业务逻辑代码 -->
<script type="text/javascript" src="${ptsStatic}/static/lib/My97DatePicker/4.8/WdatePicker.js"></script>
<script type="text/javascript" src="${ptsStatic}/mystatic/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${ptsStatic}/mystatic/js/render-page-data.js"></script>
<script type="text/javascript" src="${ptsStatic}/mystatic/js/time-convert.js"></script>
<script type="text/javascript">
    var layer;
    layui.use("layer",function () {
       layer = layui.layer;
    });

    var user_setStatus = function (id,status) {
        var optitle = status == "1"?"启用":"停用";
        var htmlStr = status =="1"?"确认启用吗":"<label class=\"layui-form-label\" style=\"text-align:left\">操作缘由</label><textarea placeholder=\"请输入内容\" id=\"exceptionDesc\" class=\"layui-textarea\"></textarea>";
        layer.open({
            title:optitle+"操作"
            ,content:htmlStr
            ,yes:function (index,layero) {
                var exceptionDesc = $("#exceptionDesc").val();
                var changeData = status =="1"?{"id":id,"status":status}:{"id":id,"status":status,"exceptionDesc":exceptionDesc};
                $.post("${ptsStatic}/changeUserStatus",changeData,function (data) {
                    if(data.success)
                        layer.msg(data.message,{icon:1,time:1500},function(){
                            location.reload();
                        });
                    else
                        layer.msg(data.message,{icon:2,time:1500});
                });
            }
        });
    }

    var user_edit = function (id) {
        layer.open({
            type:2,
            title:"修改用户",
            area:['500px','410px'],
            content:"user-edit/"+id,
            maxmin:true,
            resize:true
        });
    }

    var user_delete = function (id) {
        layer.open({
            title:"确认操作",
            content:"确定删除吗?",
            yes:function (index,layero) {
                $.post("${ptsStatic}/user-delete/"+id,function (data) {
                    if(data.success)
                        layer.msg(data.message,{icon:1,time:1500},function(){
                            location.reload();
                        });
                    else
                        layer.msg(data.message,{icon:2,time:1500});
                });
                layer.close(index);
            }
        });
    }
    var user_reset_password = function(id,name){
        layer.open({
            title:"确认操作",
            content:"确定要重置"+name+"密码吗?",
            yes:function (index,layero) {
                $.post("${ptsStatic}/user-reset-password/"+id,function (data) {
                    if(data.success)
                        layer.msg(data.message,{icon:1,time:1500},function(){
                            location.reload();
                        });
                    else
                        layer.msg(data.message,{icon:2,time:1500});
                });
                layer.close(index);
            }
        });
    }

    var user_permission = function (id) {
        var index = layer.open({
            type:2,
            title:"用户权限分配",
            content:"user-permission/"+id,
        });
        layer.full(index);
    }

    var search_user = function () {
        var mindate = $("#datemin").val(),
            maxdate = $("#datemax").val(),
            username = $("#searchName").val();
        $.post("list-user-by-selective",{"startDate":mindate,"endDate":maxdate,"userName":username},function(data){
            if(data.success){//查询成功--->展示
                renderPageData("user-list-tbody","user-list-tbody-demo","user-list-page",null,data.result.count,null,data.result.resultdata,{"color":"#FF5722"});
            }else{
                layer.msg("查询数据失败",{icon:2,time:1500});
            }
        });
    }
    search_user();

    var user_add = function(){
        layer.open({
            type:2,
            title:"新增用户",
            area:['500px','410px'],
            content:"user-add",
            maxmin:true,
            resize:true
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