<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="ShangJiList" %>

	<!DOCTYPE html>

	<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, minimum-scale=1, maximum-scale=1" />
	
		<link rel="stylesheet" href="scripts/jquery.mobile-1.3.2.min.css" />
        <link href="Scripts/mycss.css" rel="stylesheet" />
		<script src="scripts/jquery-1.11.1.min.js"></script>
		<script src="scripts/jquery.mobile-1.3.2.min.js"></script>
		<script src="Scripts/handlebars-v4.0.2.js"></script>
		<title>我的商机</title>

	</head>

	<body>
		<form id="form1" runat="server">
		</form>

		<!--商机模板-->
		<script id="tmplShangJi" type="text/x-handlebars-template">
			<ul data-role="listview" data-inset="true">
				{{#each this}}
				<li>
					<a href="javascript:window.location.replace('genzong.aspx?sjxh={{ShangJiXH}}');"><img src="images/hospital80.png" class="ui-li-icon" />
						<h1>{{KeHuMC}}</h1>
						<p>{{XiangMuMC}}</p>
						<p class="ui-li-aside">{{ZuiHouGX}}</p>
						<span class="ui-li-count">{{GengZongCS}}</span>
					</a>
				</li>
				{{/each}}
			</ul>
		</script>

		<!--填充数据-->
		<script type="text/javascript">
		    $(document).ready(function () {

		        console.log("default.aspx pageinit");

		        $.ajax({
		            type: "get",
		            url: "prcShangJiList.ashx",
		            dataType: "json",
		            success: function (data) {
		                console.log(data);
		                var tmpl = Handlebars.compile($("#tmplShangJi").html());
		                $("#ShangJiList").html(tmpl(data));
		                $("#ShangJiList").trigger("create");
		            },
		            error: function () {
		                alert("异常！");
		            }
		        });

		        console.log("after");
		    })


            $(document).on('hashchange', "#pageone", function () {
                console.log("shangjilist hashchange");
            });

            $(document).on('navigate', "#pageone", function () {
                console.log("shangjilist navigate");
            });

            $(document).on('pageshow', "#pageone", function () {
                console.log("shangjilist navigate");
            });
		</script>

		<div data-role="page" id="pageone" data-theme="d">
			<div data-role="header" data-theme="d">
				<a href="#" data-role="button" data-icon="grid">我的商机</a>
				<h5>我的商机</h5>
				<%--<a href="addshangji.aspx" data-role="button" data-icon="plus">新商机</a>--%>
			</div>

			<div data-role="content" data-theme="d" id="ShangJiList">

			</div>

			<div data-role="footer" data-position="fixed" data-theme="d">
				<div data-role="navbar">
					<ul>
						<li><a href="default.aspx" data-icon="grid" class="ui-btn-active">商机</a></li>
						<li><a href="#" data-icon="search">发现</a></li>
						<li><a href="#" data-icon="gear">我</a></li>
					</ul>
				</div>
			</div>
			<script type="text/javascript">
			    function go2mx(sjxh) {
			        window.location.replace('genzong.aspx?sjxh=' + sjxh);

			    }
			</script>
		</div>
	</body>

	</html>