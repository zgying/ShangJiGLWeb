<%@ WebHandler Language="C#" Class="util" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;
using MediinfoCRM.EntityFramework;


public class util : IHttpHandler, IRequiresSessionState{

    private static JavaScriptSerializer ser = new JavaScriptSerializer();

    public void ProcessRequest(HttpContext context)
    {

        //验证用户权限

        //获取职工信息
        string cmd;

        if (String.IsNullOrEmpty(context.Request.QueryString["cmd"]))
        {
            context.Response.Write("参数错误！");
            return;
        }
        cmd = context.Request.QueryString["cmd"].ToString();

        string rtn;

        switch (cmd.ToUpper())
        {
            case "GETZGXX":
                List<ZhiGongXX> zgxx = new List<ZhiGongXX>();
                zgxx = DataService.getZhiGongXX(string.Empty);

                rtn = ser.Serialize(zgxx);
                break;

            case "GETSJXXBYXH":

                string sjxh;
                if (String.IsNullOrEmpty(context.Request.QueryString["sjxh"]))
                {
                    context.Response.Write("参数错误！");
                    return;
                }
                sjxh = context.Request.QueryString["sjxh"].ToString();

                ShangJiMX sjmx = new ShangJiMX();
                sjmx = DataService.getShangJiMX(sjxh );

                rtn = ser.Serialize(sjmx);
                break;
                
            case "ELSE":
                rtn = string.Empty;
                break;

            default:
                rtn = string.Empty;
                break;
        }

        context.Response.ContentType = "text/plain";
        context.Response.Write(rtn);

    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}