/**
 * Description： 分页封装
 * Params:viewID:需要渲染的视图ID;demoID:模板ID;layPageID:分页插件ID;
 * params:数据[page,limit必需,如果为undefined将会初始化为page:1,limit:10   其它VO对象参数任选~~~];
 * getItemsURL:获取展示项url;
 * Author: 刘永红
 * Date: Created in 2018/12/11 17:21
 */
function renderPageData(viewID,demoID,layPageID,params,count,getItemsURL){
    //初始化page limit
    if(params == null)
        var params = {"page":1,"limit":10};
    if(params.page == undefined)
        params.page = 1;
    if(params.limit == undefined)
        params.limit = 10;

    //var data= isvalid == null ?{'page':page,'limit':limit}:{'page':page,'limit':limit,'status':isvalid};
    //获取第page页列表
    $.ajax({
        type:"post",
        url: getItemsURL,
        data:params,
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
                    curr:params.page,
                    first: '首页',
                    last: '尾页',
                    limit:params.limit,
                    jump: function(obj, first){//obj是一个object类型。包括了分页的所有配置信息。first一个Boolean类，检测页面是否初始加载。非常有用，可避免无限刷新。
                        params.page = obj.curr;
                        params.limit = obj.limit;
                        if(!first){
                            renderPageData(viewID,demoID,layPageID,params,count,getItemsURL);
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