<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../public/head.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; utf-8" />
<title>Insert title here</title>
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/layui/css/layui.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="${ptsStatic}/static/lib/zTree/v3/css/zTreeStyle/zTreeStyle.css">
    <style type="text/css">
        .Hui-aside{position: absolute;top:0px;bottom:0;left:0;padding-top:30px;padding-left:15px;width:199px;z-index:99;overflow:auto; background-color:rgba(238,238,238,0.5);border-right: 1px solid #e5e5e5;border-radius: 1%;}
        .Hui-article-box{position: absolute;top:0px;right:0;bottom: 0;left:205px; overflow:hidden; z-index:1; background-color:#fff;padding: 0px 20px;}
    </style>
</head>
<body>
    <aside class="Hui-aside">
        <ul id="OrganizationTree" class="ztree"></ul>
    </aside>

    <div class="Hui-article-box">

        <div><a class="btn btn-default radius r" style="line-height:0.8em;margin-top:1px;margin-right:1px;padding-left: 3px;padding-right: 3px;height: 22px;" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></div>

        <div class="c1 bg-1 pd-5 mt-30">
            <a href="javascript:;" class="btn btn-secondary radius" onclick="organization_add()"><i class="Hui-iconfont">&#xe600;</i>新增</a>

        </div>

        <!-- 表格 -->
        <table class="table table-border table-bordered table-hover table-bg table-sort mt-20">
            <thead>
                <tr class="text-c">
                    <th>操作</th>
                    <th>组织机构名</th>
                    <th>组织机构简称</th>
                    <th>父级组织机构名</th>
                    <th>创建时间</th>
                    <th>创建人</th>
                    <th>状态</th>
                </tr>
            </thead>
            <tbody id="tbody-view">
                <%--<c:forEach items="${organizationList}" var="o">
                    <tr class="text-c">
                        <td>
                            <a title="修改" href="javascript:;" onclick="organization_add('${o.id}')"><i class="Hui-iconfont">&#xe6df;</i></a>
                        </td>
                        <td>${o.organizationName}</td>
                        <td>${o.organizationShortName}</td>
                        <td>${o.parentName}</td>
                        <td><f:formatDate value="${o.createTime}" pattern="yyyy-MM-dd HH:mm:ss"></f:formatDate></td>
                        <td>${o.createBy}</td>
                        <td>
                            <c:if test="${o.status == 1}">
                                √
                            </c:if>
                            <c:if test="${o.status == 0}">
                                <a href="javascript:;" class="c-red" data-toggle="tooltip" data-placement="left" title="${o.exceptionDesc}">×</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>--%>
            </tbody>
        </table>

        <div id="table-page"></div>

    </div>

    <%--  表格渲染模板引擎  --%>
    <script id="demo" type="text/html">
        {{# for(var i = 0,len = d.length;i < len; i++){   }}
        {{#      var o = d[i]; }}
            <tr class="text-c">
                <td>
                    <a title="修改" href="javascript:;" onclick="organization_add('{{ o.id }}')"><i class="Hui-iconfont">&#xe6df;</i></a>
                </td>
                <td>{{ o.organizationName }}</td>
                <td>{{ o.organizationShortName }}</td>
                <td>{{ o.parentName == null?"":o.parentName }}</td>
                <%--<td><f:formatDate value="{{ o.createTime }}"  pattern="yyyy-MM-dd HH:mm:ss"></f:formatDate></td>--%>
                <td>
                    {{# var date = timestampToTime(o.createTime) }}
                    {{ date }}
                </td>
                <td>{{o.createBy }}</td>
                <td>
                    {{# if(o.status === 1){     }}
                        √
                    {{# }else{ }}
                        <a href="javascript:;" id="show-option" class="c-red" title='{{ o.exceptionDesc }}'>×</a>
                    {{# } }}
                </td>
            </tr>
        {{# } }}
    </script>

<%@include file="../public/footer.jsp"%>

<!-- 请在下方写业务逻辑代码 -->
<script type="text/javascript" src="${ptsStatic}/static/lib/zTree/v3/js/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="${ptsStatic}/static/layui/lay/modules/laypage.js"></script>
<script type="text/javascript" src="${ptsStatic}/static/layui/lay/modules/laytpl.js"></script>
<script type="text/javascript" src="${ptsStatic}/static/layui/lay/modules/form.js"></script>
<script type="text/javascript" src="${ptsStatic}/static/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${ptsStatic}/mystatic/js/time-convert.js"></script>
<script type="text/javascript" src="${ptsStatic}/mystatic/js/render-page-data.js"></script>

<script type="text/javascript">

    var size = 10;

    var layer;
    layui.use('layer',function () {
        layer = layui.layer;
    });

    var setting = {
        view: {
            //双击节点时，是否自动展开父节点的标识,默认true
            dblClickExpand: false,
            //设置 zTree 是否显示节点之间的连线,默认true
            showLine: false,
            //设置是否允许同时选中多个节点,默认true
            selectedMulti: false
        },
        data: {
            simpleData: {
                //是否采用简单数据模式,默认 false
                enable:true,
                //节点数据中保存唯一标识的属性名称, 默认值 id
                idKey: "id",
                //节点数据中保存其父节点唯一标识的属性名称,默认值 pId
                pIdKey: "parentId",
                //用于修正根节点父节点数据，即 pIdKey 指定的属性值,默认值 null
                rootPId: ""
            },
            key: {
                //zTree 节点数据保存节点名称的属性名称, 默认值 name
                name: "organizationName"
            }
        },
        callback: {
            //用于捕获单击节点之前的事件回调函数，并且根据返回值确定是否允许单击操作,默认值 null
            beforeClick: function(treeId, treeNode) {
                var zTree = $.fn.zTree.getZTreeObj("OrganizationTree");
                if (treeNode.isParent) {
                    zTree.expandNode(treeNode);
                    return false;
                } else {
                    //demoIframe.attr("src",treeNode.file + ".html");
                    return true;
                }
            }
        }
    };

    var zNodes =[
        { id:1, pId:0, name:"一级分类", open:true},
        { id:11, pId:1, name:"二级分类"},
        { id:111, pId:11, name:"三级分类"},
        { id:112, pId:11, name:"三级分类"},
        { id:113, pId:11, name:"三级分类"},
        { id:114, pId:11, name:"三级分类"},
        { id:115, pId:11, name:"三级分类"},
        { id:12, pId:1, name:"二级分类 1-2"},
        { id:121, pId:12, name:"三级分类 1-2-1"},
        { id:122, pId:12, name:"三级分类 1-2-2"},
    ];

    $(document).ready(function(){
        $.ajax({
            type:"get",
            contentType:"application/json",
            data:{status:1},
            dataType:"json",
            url:"${ptsStatic}/organization-tree-list",
            async:false,
            success:function (data) {
                zNodes = data.result;
            },
            error:function () {
                layer.open({
                    type:1
                    ,title:"结果"
                    ,content:"机构树加载失败"
                });
            }
        });
        var t = $("#OrganizationTree");
        t = $.fn.zTree.init(t, setting, zNodes);
        //demoIframe = $("#testIframe");
        //demoIframe.on("load", loadReady);

        //自动展开节点
        var zTree = $.fn.zTree.getZTreeObj("OrganizationTree");
        //默认返回所有根节点信息
        var nodeList = zTree.getNodes();
        for(var i = 0 ; i < nodeList.length ; i ++) {
            if(nodeList[i].level == 0)
                zTree.expandNode(nodeList[i], true);
        }
        //zTree.selectNode(zTree.getNodeByParam("id",'11'));
    });

    var organization_add = function(id){
        layer.open({
            type: 2,
            area: ['400px', '300px'],
            fix: false, //不固定
            maxmin: true,
            title: "修改机构",
            scrollbar: false,
            content: id==null?"organization-add":("organization-add?id="+id)
        });
    }

    $.ajax({
        type:"post",
        data:{"status":1},
        url:"${ptsStatic}/organizations-count",
        dataType:"json",
        success:function (data) {
            renderPageData("tbody-view","demo","table-page",1,size,data.result,"${ptsStatic}/organizations","1");
        },
        error:function(data){
            alert("数量获取失败");
        }
    });

    $( "#show-option" ).tooltip({
        show: {
            effect: "slideDown",
            delay: 250
        }
    });
</script>
</body>
</html>