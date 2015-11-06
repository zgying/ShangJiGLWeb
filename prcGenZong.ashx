<%@ WebHandler Language="C#" Class="prcGenZong" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.SessionState;
using System.Web.Script.Serialization;
using MediinfoCRM.EntityFramework;

public class prcGenZong : IHttpHandler, IRequiresSessionState{


    private static JavaScriptSerializer ser = new JavaScriptSerializer();

    public void ProcessRequest(HttpContext context)
    {

        if (String.IsNullOrEmpty(HttpContext.Current.Session["userid"].ToString()))
        {
            //context.Response.Write("用户未登陆");
            context.Response.Redirect("nologin.aspx");
            return;
        }
        
        string rtn;
        string type = "1";

        //从session获取

        //if (String.IsNullOrEmpty(context.Request.QueryString["token"]))
        //{
        //    context.Response.Write("参数错误！");
        //    return;
        //}

        //token = context.Request.QueryString["token"].ToString();

        //if (token == "ecf")
        //    rtn = "hello word!";
        //else
        //    rtn = token;

        if (String.IsNullOrEmpty(context.Request.QueryString["sjxh"]))
        {
            context.Response.Write("参数错误！");
            return;
        }

        string sjxh = context.Request.QueryString["sjxh"].ToString();

        if (String.IsNullOrEmpty(context.Request.QueryString["type"]))
        {
            type = "1";
            return;
        }

        type = context.Request.QueryString["type"].ToString();
        if (type == "1")
        {
            ShangJiMX sjmx = new ShangJiMX();

            sjmx = DataService.getShangJiMX(sjxh);

            rtn = ser.Serialize(sjmx);
        }
        else
        {
            List<GenZongJL> gzjl = new List<GenZongJL>();
            gzjl = DataService.getGenZongJL(sjxh, 1, string.Empty);
            rtn = ser.Serialize(gzjl);
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