<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddGenZong.aspx.cs" Inherits="AddGenZong" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name = "viewport" content = "width=device-width, minimum-scale=1, maximum-scale=1"> 
<link rel="stylesheet" href="scripts/jquery.mobile-1.3.2.min.css">
<script src="scripts/jquery-1.11.1.min.js"></script>
<script src="scripts/jquery.mobile-1.3.2.min.js"></script>
<script src="Scripts/handlebars-v4.0.2.js"></script>
<title></title>
</head>
<body>
     <!----模板库-->     
     <script id="tmplZhiGongXX" type="text/x-handlebars-template">
     <h2>营销平台通讯录</h2>
        <ul data-role="listview" data-autodividers="true" data-inset="true" data-filter="true" data-filter-placeholder="搜索姓名 ...">
        {{#each this}}
        <li><a href="javascript:seldata('{{ZhiGongID}}','{{XingMing}}','{{SuoZaiKS}}','{{KeShiMC}}');">{{XingMing}}</a></li>        
        {{/each}}	
        </ul>       
    </script>

    <!----模板填充-->
    <!--填充数据-->
<script type="text/javascript">

    $(document).ready(function () {

        $.ajax({
            type: "get",
            url: "util.ashx?cmd=getzgxx",
            dataType: "json",
            success: function (data) {
                console.log("getzgxx data");
                
                var tmpl = Handlebars.compile($("#tmplZhiGongXX").html());
                $("#popupYuanGong").html(tmpl(data));
                $("#popupYuanGong").trigger("create");

            },
            error: function () {
                alert("异常！");
            }
        });
    })
</script>


   <div data-role="page" id="addGenZhongJL" data-theme="d">
			<form id="AddGenZong" action="prcAddGenZong.ashx" data-ajax="false">
				<div data-role="header" data-theme="d">
					<a href="genzhong.html" data-role="button" data-icon="back" >跟踪记录</a>
					<h5>新跟踪记录</h5>
					<a id="submit" href="#" data-role="button" data-icon="check" >保存</a>
				</div>

				<div data-role="content" data-theme="d">

					<div data-role="fieldcontain">
                        <input id="ipShangJiXH" name="ShangJiXH" type="hidden" value="" />
						<label for="GenZongFS">跟踪方式:</label>
						<select id="selGenZongFS" name="GenZongFS">
							<option value="1">内部协调</option>
							<option value="2">现场拜访</option>
							<option value="3">电话拜访</option>
							<option value="4">第三方资源</option>
							<option value="5">系统生成</option>							
						</select>
					</div>
                    <div data-role="fieldcontain">
						<label for="BaiFangRQ">拜访时间</label>
						<input type="date" name="BaiFangRQ" id="dtBaiFangRQ" value=""/>
					</div>
					<div data-role="fieldcontain">
						<label for="BaiFangDX">拜访对象:</label>
						<textarea name="BaiFangDX" id="txtBaiFangDX" data-mini="true" placeholder="拜访对象"></textarea>
					</div>
					
					<div data-role="fieldcontain">
						<label for="BaiFangNR">跟踪反馈:</label>
						<textarea name="BaiFangNR" id="txtBaiFangNR" data-mini="true" placeholder="拜访内容"></textarea>
					</div>
					
					<div data-role="fieldcontain">
						<label for="XieTongRY"><a href="#popupYuanGong" data-rel="popup" data-position-to="window">选择协同人员</a></label> 
						<input name="XieTongRYXM" id="ipXieTongRYXM" placeholder="协同人员" readonly="true" />
                        <input name="XieTongRYBMMC" id="ipXieTongRYBMMC" placeholder="协同人员科室" readonly="true" />
                        <input name="XieTongRYID" type="hidden" id="ipXieTongRYID" value="" />
                        <input name="XieTongRYBMID" type="hidden" id="ipXieTongRYBMID" value="" />
					</div>

                    <div data-role="popup" id="popupYuanGong" data-transition="flip">
                      
                    </div>
				</div>

			</form>		
        <script type="text/javascript">

            function IsValidDate(DateStr) {
                var sDate = DateStr.replace(/(^\s+|\s+$)/g, '');//去两边空格; 
                if (sDate == '') {
                    return true;
                }
                //如果格式满足YYYY-(/)MM-(/)DD或YYYY-(/)M-(/)DD或YYYY-(/)M-(/)D或YYYY-(/)MM-(/)D就替换为'' 
                //数据库中，合法日期可以是:YYYY-MM/DD(2003-3/21),数据库会自动转换为YYYY-MM-DD格式 
                var s = sDate.replace(/[\d]{ 4,4 }[\-/]{1}[\d]{1,2}[\-/]{1}[\d]{1,2}/g, '');
                if (s == '') {//说明格式满足YYYY-MM-DD或YYYY-M-DD或YYYY-M-D或YYYY-MM-D 
                    var t = new Date(sDate.replace(/\-/g, '/'));
                    var ar = sDate.split(/[-/:]/);
                    if (ar[0] != t.getYear() || ar[1] != t.getMonth() + 1 || ar[2] != t.getDate()) {//alert('错误的日期格式！格式为：YYYY-MM-DD或YYYY/MM/DD。注意闰年。'); 
                        return false;
                    }
                } else {//alert('错误的日期格式！格式为：YYYY-MM-DD或YYYY/MM/DD。注意闰年。'); 
                    return false;
                }
                return true;
            }
            //取URL参数

            $.extend({
                getUrlVars: function () {
                    var vars = [], hash;
                    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                    for (var i = 0; i < hashes.length; i++) {
                        hash = hashes[i].split('=');
                        vars.push(hash[0]);
                        vars[hash[0]] = hash[1];
                    }
                    return vars;
                },
                getUrlVar: function (name) {
                    return $.getUrlVars()[name];
                }
            });

            //保存跟踪信息
            function onSuccess(data, status) {
                data = $.trim(data);
                console.log(data, status);
                //redir to shangjimx
                var sjxh = $.getUrlVar('sjxh');
                window.location.replace("genzong.aspx?sjxh=" + sjxh);
            }

            function onError(data, status) {
                console.log(data, status);
                //window.location.href = "error.html";
            }

            $(document).ready(function () {
                $("#submit").click(function () {

                    console.log("submit click");

                    var sjxh = $.getUrlVar('sjxh');
                    $("#ipShangJiXH").val(sjxh);

                    //check date
                    if ($("#dtBaiFangRQ").val()== "" )
                    {                        
                        alert("请输入日期！");
                        $("#dtBaiFangRQ").focus().select();
                        return false;
                    }

                    $("#AddGenZong").submit();

                    return false;
                    //var formData = $("#AddGenZong").serialize();
                    //console.log(formData);

                    //var sjxh = $.getUrlVar('sjxh');

                    //$.ajax({
                    //    type: "POST",
                    //    url: "prcaddgenzong.ashx?sjxh=" & sjxh,
                    //    cache: false,
                    //    data: formData,
                    //    success: onSuccess,
                    //    error: onError
                    //});


                });
            });

            $("#popupYuanGong").on("popupafterclose", function (event, ui) {
                console.log("popupafterclose");
            });

            function seldata(zgid, zgmc, szks, ksmc) {
                console.log(zgid, zgmc, szks, ksmc);
                $("#ipXieTongRYXM").val(zgmc);
                $("#ipXieTongRYBMMC").val(ksmc);
                $("#ipXieTongRYID").val(zgid);
                $("#ipXieTongRYBMID").val(szks);

                $("#popupYuanGong").popup("close");
            }

            //

        </script>  
    </div>
</body>
</html>
