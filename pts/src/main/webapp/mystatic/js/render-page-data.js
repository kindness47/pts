/**
 * Description： 分页封装
 * Params:viewID:需要渲染的视图ID;demoID:模板ID;layPageID:分页插件ID;page:页码;limit:每页数量;count:数据总量;
*                getItemsURL:获取展示项url;isvalid:获取的item状态
 * Author: 刘永红
 * Date: Created in 2018/12/11 17:21
 */
function renderPageData(viewID,demoID,layPageID,page,limit,count,getItemsURL,isvalid){
    if(page == 0 && limit == 0){
        page = 1;
        limit = 4;
    }
    var data;

    var data= isvalid == null ?{'page':page,'limit':limit}:{'page':page,'limit':limit,'status':isvalid};
    //获取第page页列表
    $.ajax({
        type:"post",
        url: getItemsURL,
        data:data,
        contentType:"application/x-www-form-urlencoded;charset=UTF-8",
        dataType:"json",
        success:function (data) {
            //数据视图渲染
            renderTemplate(viewID,demoID,data.result);
            //初始化分页插件
            layui.use('laypage',function () {
                var laypage = layui.laypage;
                laypage.render({
                    elem : layPageID,
                    count:count,
                    curr:page,
                    first: '首页',
                    last: '尾页',
                    limit:limit,
                    jump: function(obj, first){//obj是一个object类型。包括了分页的所有配置信息。first一个Boolean类，检测页面是否初始加载。非常有用，可避免无限刷新。
                        page = obj.curr;
                        limit = obj.limit;
                        if(!first){
                            renderPageData(viewID,demoID,layPageID,page,limit,count,getItemsURL,isvalid)
                        }
                    }
                });
            });
        }

    });
}
/**
 * Description： 渲染模板
 * Params:viewID:需要渲染的视图ID;demoID:模板ID;data:渲染的数据(List);
 * Author: 刘永红
 * Date: Created in 2018/12/11 17:35
 */
function renderTemplate(viewID,demoID,data){
    layui.use('laytpl',function () {
        var laytpl = layui.laytpl;
        var view = document.getElementById(viewID),
            getTpl = $("#"+demoID).html();
        laytpl(getTpl).render(data,function (html) {
            view.innerHTML = html;
        });
    });
}