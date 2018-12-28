var timestampToTime = function(timestamp) {
    //时间戳为10位需*1000，时间戳为13位的话不需乘1000
    var date = new Date(timestamp);
    //部位填数
    var Y = date.getFullYear(),
    M = (date.getMonth()+1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1),
    D = date.getDate() < 10 ? "0" + date.getDate() : date.getDate(),
    h = date.getHours() < 10 ? "0" + date.getHours() : date.getHours(),
    m = date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes(),
    s = date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds();

    return Y+"-"+M+"-"+D+" "+h+":"+m+":"+s;
}