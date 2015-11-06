<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GenZong.aspx.cs" Inherits="GenZong" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name = "viewport" content = "width=device-width, minimum-scale=1, maximum-scale=1"/> 
<meta http-equiv="Expires" content="0"/>   
<meta http-equiv="Cache-Control" content="no-store, must-revalidate"/>   
<meta http-equiv="Pragma" content="no-cache"/> 
<link rel="stylesheet" href="scripts/jquery.mobile-1.3.2.min.css"/>
<script src="scripts/jquery-1.11.1.min.js"></script>
<script src="scripts/jquery.mobile-1.3.2.min.js"></script>
<script src="Scripts/handlebars-v4.0.2.js"></script>
<title></title>
</head>
<body>
    <form id="form1" runat="server">
    
        <!--商机明细模板-->
    <script id="tmplShangJiMX" type="text/x-handlebars-template">
     <%--商机明细--%>
        <div data-role="collapsible" data-collapsed="true" data-collapsed-icon="arrow-d" data-expanded-icon="arrow-u">                 
            	<h1>{{LeiBieMC}}</h1>
			    <p>{{NeiRong}}</p>
        	    <p>当前进度:{{GenZongZTMC}}</p>
			    <p>预期: {{YuQi}}</p>
			    <p>采购方式：{{CaiGouFS}}</p>
			    <p>成单概率：{{ChengDanGL}}</p>
			    <div data-role="controlgroup" data-type="horizontal">
<%--				<a href="#" data-role="button" >修改</a>
				<a href="#" data-role="button" >中标</a>						
				<a href="#" data-role="button" >结单</a>--%>
			    </div>		             
        </div>   
    </script>

     <script id="tmplGenZongJL" type="text/x-handlebars-template">
         <%--跟踪记录明细--%>	
        {{#each this}}
        <li data-role="list-divider">{{BaiFangRQ}} <span class="ui-li-count">{{CiShu}}</span></li>
		<li>
			<h2>{{BaiFangDX}}</h2>
			<%--<p><b>跟踪方式：{{GenZhongFS}}</b></p>--%>
			<p><b>{{GenZongFKQK}}</b></p>
			<p class="ui-li-aside">{{XieTongRYMC}}</p>
		</li>
        {{/each}}		
     </script>		



<!--填充数据-->
<script type="text/javascript">

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


    $(document).ready(function () {
        console.log("genzong pageinit");

        var sjxh = $.getUrlVar('sjxh');

        $.ajax({
            type: "get",
            url: "prcGenZong.ashx?sjxh=" + sjxh + "&type=1",
            dataType: "json",
            success: function (data) {
                console.log("sjmx get data");
                console.log(data);
                var tmpl = Handlebars.compile($("#tmplShangJiMX").html());
                $("#ShangJiMX").html(tmpl(data));
                $("#ShangJiMX").trigger("create");
                $('#txtKeHuMC').text(data.KeHuMC);
            },
            error: function () {
                alert("异常！");
            }
        });


        $.ajax({
            type: "get",
            url: "prcGenZong.ashx?sjxh=" + sjxh + "&type=2",
            dataType: "json",
            success: function (data) {
                console.log("gzjl get data:");
                console.log(data);
                var tmpl = Handlebars.compile($("#tmplGenZongJL").html());
                $("#GenZongJL").html(tmpl(data));
                $("#GenZongJL").listview("refresh");
                $("#GenZongJL").trigger("create");
            },
            error: function () {
                alert("异常！");
            }
        });
    })
</script>



    <div data-role="page" id="pageGenZhongJL" data-theme="d">

			<div data-role="header" data-theme="d">
				<a id="backlink" href="javascript:goback2ShangJi()" data-role="button" data-icon="back"  >我的商机</a>
				<h5 id="txtKeHuMC"></h5>
				<a href="javascript:go2addgenzong()" data-role="button" data-icon="plus">跟踪记录</a>
			</div>

			<div id="ShangJiMX"  data-role="content">				
                <%--商机明细--%>
			</div>

			<div  data-role="content">				

                <ul id="GenZongJL" data-role="listview" data-inset="true">
                  
		        </ul>                 

			</div>
                        
			<div data-role="footer" data-position="fixed" data-theme="d">
				<div data-role="navbar">
					<ul>
						<li><a href="index.html" data-icon="grid" class="ui-btn-active">商机</a></li>
						<li><a href="#" data-icon="search">发现</a></li>
						<li><a href="#" data-icon="gear">我</a></li>
					</ul>
				</div>
			</div>

        <script type="text/javascript">

            function goback2ShangJi() {
                window.location.replace('shangjilist.aspx');

            }

            function go2addgenzong() {
                var sjxh = $.getUrlVar('sjxh');
                window.location.replace('addgenzong.aspx?sjxh=' + sjxh);
            }
        </script>
		</div>
</form>
</body>
</html>
