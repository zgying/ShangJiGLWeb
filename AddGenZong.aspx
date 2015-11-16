<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddGenZong.aspx.cs" Inherits="AddGenZong" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name = "viewport" content = "width=device-width, minimum-scale=1, maximum-scale=1"> 
<link rel="stylesheet" href="scripts/jquery.mobile-1.3.2.min.css">
    <link href="Scripts/mycss.css" rel="stylesheet" />
<link href="Scripts/mycss.css" rel="stylesheet" />
<script src="scripts/jquery-1.11.1.min.js"></script>
<script src="scripts/jquery.mobile-1.3.2.min.js"></script>
<script src="Scripts/handlebars-v4.0.2.js"></script>
<title></title>
</head>
<body>
     <!----模板库-->     
     <script id="tmplZhiGongXX" type="text/x-handlebars-template">
     <h2>营销平台通讯录</h2>      
        <ul id="ulYuanGong" data-role="listview" data-filter-reveal="true" data-inset="true" data-filter="true" data-filter-placeholder="输入首字母或汉字......">
        {{#each this}}
        <li data-filtertext="{{XingMingPY}}" ><a href="javascript:seldata('{{ZhiGongID}}','{{XingMing}}','{{SuoZaiKS}}','{{KeShiMC}}');">{{XingMingSZM}} {{XingMing}}  {{KeShiMC}}</a></li>        
        {{/each}}	
        </ul>       
    </script>

    <!----模板填充-->
    <!--填充数据-->
<script type="text/javascript">

    $(document).ready(function () {

        //获取职工信息
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
					<a href="javascript:go2GenZong()" data-role="button" data-icon="back" >跟踪记录</a>
					<h5>新跟踪记录</h5>
					<a id="submit" href="#" data-role="button" data-icon="check" >保存</a>
				</div>

                 
                <div data-role="content" data-theme="d">
                    <%--商机类别--%>
                    <div data-role="fieldcontain">                        
						<label for="GenZongFS">商机类别:</label>
						<select id="selShangJiLB" name="ShangJiLB">
							<option value="033007">临床电子病历（版本升级）</option>
                            <option value="033002">HIS(新增)</option>
                            <option value="033005">数据安全管理</option>
                            <option value="033006">临床电子病历（新客户）</option>
                            <option value="033001">HIS（新客户）</option>
                            <option value="033008">临床无线医护</option>
                            <option value="033004">先诊疗后付费（银联）</option>
                            <option value="033009">临床路径</option>
                            <option value="033010">健康体检</option>
                            <option value="033011">后勤物流管理平台</option>
                            <option value="033003">HIS（版本升级）</option>
                            <option value="033012">综合服务平台</option>
                            <option value="033013">经济运营管理平台</option>
                            <option value="033014">集成平台&数据中心&BI</option>
                            <option value="033018">区域基层医疗业务平台</option>
                            <option value="033019">区域医疗信息交换平台</option>
                            <option value="033020">第三方代理产品</option>
                            <option value="33021">运维托管</option>
                            <option value="33022">售后新增</option>
                            <option value="33023">临床检验LIS</option>							
						</select>
					</div>

                    <%--商机内容--%>
                    <div data-role="fieldcontain">
						<label for="ShangJiNR">商机内容</label>
						<textarea name="ShangJiNR" id="txtShangJiNR" data-mini="true" placeholder="商机内容"></textarea>
					</div>

                    <%--项目预算--%>
                    <div data-role="fieldcontain">
                        <label for="XiangMuYS">项目预算（万元）</label>
                        <input type="number" data-clear-btn="false" name="XiangMuYS" pattern="[0-9]*" id="ipXiangMuYS" value=""/>       
                    </div>

                    <%--预计结单时间--%>
                    <div data-role="fieldcontain">
						<label for="JieDanSJ">结单时间</label>
						<input type="date" name="JieDanSJ" id="dtJieDanSJ" value=""/>
					</div>

                    <%--采购方式--%>
                    <div data-role="fieldcontain">
                        <label for="CaiGouFS">采购方式:</label>
						<select id="selCaiGouFS" name="CaiGouFS">
							<option value="1">政府协议采购</option>
                            <option value="2">公开招标</option>
                            <option value="3">邀请招标</option>
                            <option value="4">竞争性谈判</option>
                            <option value="5">单一来源采购</option>
                            <option value="6">询价采购</option>
                            <option value="7">自行采购</option>
                        </select>
					</div>

                    <%--当前进度--%>
                    <div data-role="fieldcontain">
                        <label for="DangQianJD">当前进度:</label>
						<select id="selDangQianJD" name="DangQianJD">
							<option value="1">发现商机</option>
                            <option value="2">客户拜访</option>
                            <option value="3">技术认可</option>
                            <option value="4">商务报价</option>
                            <option value="5">获得承诺</option>
                            <option value="6">项目成单</option>
                            <option value="7">项目失败</option>
                        </select>
					</div>

                    <%--成单概率--%>
                    <div data-role="fieldcontain">
                        <label for="ChengDanGL">成单概率:</label>
                        <input type="range" name="ChengDanGL" id="ragChengDanGL" data-highlight="true" min="0" max="100" value="50"/>
                    </div>

                    
                     <div data-role="fieldcontain">
						<label for="ShangJiBZ">备注</label>
						<textarea name="ShangJiBZ" id="txtShangJiBZ" data-mini="true" placeholder="商机备注"></textarea>
					</div>
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
						<%--<label for="XieTongRY"><a href="#popupYuanGong" data-rel="popup" data-position-to="window">选择协同人员</a></label>--%> 
                        <label for="XieTongRY">协同人员</label>
						<input name="XieTongRYXM" id="ipXieTongRYXM" placeholder="协同人员" readonly="true" />
                        <input name="XieTongRYBMMC" id="ipXieTongRYBMMC" placeholder="协同人员科室" readonly="true" />
                        <input name="XieTongRYID" type="hidden" id="ipXieTongRYID" value="" />
                        <input name="XieTongRYBMID" type="hidden" id="ipXieTongRYBMID" value="" />
					</div>

                    <div data-role="popup" id="popupYuanGong" data-transition="flip" data-overlay-theme="a" data-theme="e" class="ui-content" data-position-to="#position-header">
                      
                    </div>

				</div>

			</form>		
        <script type="text/javascript">
            //公用函数
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

            function $isEmpty(Variables) {
                var TypeName = $.type(Variables);
                return TypeName == 'undefined' || TypeName == null || Variables == '' ? true : false;
            }

            function in_array(s, arr) {
                if ($.type(arr) == 'array') {
                    for (var ai = 0; ai < arr.length; ai++) {
                        if (arr[ai] == s) return true;
                    }
                }
                return false;
            }

            function inputDefault(obj, val) {
                var type = $.type(obj) == 'string' ? $(obj) : obj;
                if (type.length == 0 || $isEmpty(val)) return;
                var tagName = type[0].tagName.toLocaleLowerCase() == 'input' ? type.attr('type').toLocaleLowerCase() : type[0].tagName.toLocaleLowerCase();
                switch (tagName) {
                    case 'textarea':
                        type = type.get(0);
                        type.defaultValue = val;
                        type.value = val;
                        break;
                    case 'select':
                        type.find('option').each(function () { this.removeAttribute('selected'); })
                        type.find('option[value="' + val + '"]').get(0).setAttribute('selected', 'selected');
                        break;
                    case 'radio':
                        type.each(function () {
                            var checked = this.value == val ? true : false;
                            this.defaultChecked = checked;
                            this.checked = checked;
                        })
                        break;
                    case 'checkbox':
                        if ($.type(val) == 'string') val = val.split(',');
                        type.each(function () {
                            var checked = in_array(this.value, val);
                            this.defaultChecked = checked;
                            this.checked = checked;
                        })
                        break;
                    default:
                        type = type.get(0);
                        type.defaultValue = val;
                        type.value = val;
                }
            }
          
            //表单是否已修改
            //function IsModified() {
            //    var result = false;
            //    //初始化返回值
            //    var colInput = document.getElementsByTagName("input");
            //    //获取输入框控件
            //    for (var i = 0; i < colInput.length; i++)
            //        //逐个判断页面中的input控件
            //    {
            //        if (colInput[i].value != colInput[i].defaultValue)
            //            //判断输入的值是否等于初始值
            //        {
            //            result = true;
            //            //如果不相等，返回true，表示已经修改
            //            colInput[i].style.backgroundColor = "#ff9000";
            //            //改变被修改控件的背景色
            //        }
            //    }

            //    var colSel = document.getElementsByTagName("select")
            //    for (var j = 0; j < colSel.length; j++) {
            //        if (colSel[j].value != colSel[j].defaultValue)
            //        {
            //            result = true;
            //            colSel[j].style.backgroundColor = "#ff9000";
            //        }
            //    }

            //    //var coltxt = document.getElementsByTagName("textarea");
            //    //for (var k = 0 ; k < coltxt.length ; k++) {
            //    //    if (coltxt[k].value != coltxt.defaultValue) {
            //    //        result = true;
            //    //        coltxt[k].style.backgroundColor = "#ff9000";
            //    //    }
            //    //}

            //    return result;
            //}

        </script>

        <%--加载商机信息--%>
        <script type="text/javascript">
            $(document).ready(function () {
                var sjxh = $.getUrlVar('sjxh');
                console.log("get shangjixx",sjxh);

                //获取商机信息
                $.ajax({
                    type: "get",
                    url: "util.ashx?cmd=getsjxxbyxh&sjxh=" + sjxh,
                    dataType: "json",
                    success: function (data) {
                        console.log("getsjbyid data", data);
                        var sjmx = data;
                        //填充商机数据
                        $("#selShangJiLB").val(sjmx.LeiBie);
                        $("#selShangJiLB").val(sjmx.LeiBie).attr('selected', true).siblings('option').removeAttr('selected');
                        $("#selShangJiLB").selectmenu('refresh', true);
                        inputDefault("#selShangJiLB", sjmx.LeiBie);

                        $("#txtShangJiNR").text(sjmx.NeiRong);
                        inputDefault("#txtShangJiNR", sjmx.NeiRong);

                        $("#ipXiangMuYS").val(sjmx.XiangMuYS / 10000);
                        inputDefault("#ipXiangMuYS", sjmx.XiangMuYS / 10000);

                        $("#dtJieDanSJ").val(sjmx.YuQi);
                        inputDefault("#dtJieDanSJ", sjmx.YuQi );

                        $("#selCaiGouFS").val(sjmx.CaiGouFS);
                        $("#selCaiGouFS").val(sjmx.CaiGouFS).attr('selected', true).siblings('option').removeAttr('selected');
                        $("#selCaiGouFS").selectmenu('refresh', true);
                        inputDefault("#selCaiGouFS", sjmx.CaiGouFS);

                        $("#selDangQianJD").val(sjmx.DangQianJD);
                        $("#selDangQianJD").val(sjmx.DangQianJD).attr('selected', true).siblings('option').removeAttr('selected');
                        $("#selDangQianJD").selectmenu('refresh', true);
                        inputDefault("#selDangQianJD",sjmx.DangQianJD);

                        var cdl = sjmx.ChengDanGL.substring(0, sjmx.ChengDanGL.length - 1);
                        $("#ragChengDanGL").val(cdl).slider("refresh");
                        inputDefault("#ragChengDanGL",cdl);

                        $("#txtShangJiBZ").val(sjmx.BeiZhu);
                        inputDefault("#txtShangJiBZ", sjmx.BeiZhu);

                    },
                    error: function () {
                        alert("获取商机信息异常！");
                    }
                });
            });
        </script> 

        <script type="text/javascript">
            //转向链接
            function go2GenZong() {
                var sjxh = $.getUrlVar('sjxh');
                window.location.replace('genzong.aspx?sjxh=' + sjxh);
            }

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
                //获取商机信息，绑定到现有页面


                //获得焦点时弹出选择列表                
                $("#ipXieTongRYXM").focus(function () {
                    $("#popupYuanGong").popup("open");
                });

                //绑定表单提交事件
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

            $("#popupYuanGong").on("popupafteropen", function (event, ui) {
                console.log("popupafteropen");
                //$(".ui-input-text ui-body-c").focus().select();
            });

            //选中协调人员后赋值
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
