<%@ WebHandler Language="C#" Class="prcShangJiList" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;
using MediinfoCRM.EntityFramework;


public class prcShangJiList : IHttpHandler, IRequiresSessionState{

    private static JavaScriptSerializer ser = new JavaScriptSerializer();

    public void ProcessRequest(HttpContext context)
    {

        string rtn;
        string userid;

        if (String.IsNullOrEmpty(HttpContext.Current.Session["userid"].ToString()))
        {
            //context.Response.Write("用户未登陆");
            context.Response.Redirect("nologin.aspx");
            return;
        }
        userid = HttpContext.Current.Session["userid"].ToString();


        List<ShangJiMini> sj = new List<ShangJiMini>();
        sj = DataService.getMyShangJi("ecf", userid , 1, "");

        rtn = ser.Serialize(sj);

        context.Response.ContentType = "text/plain";
        context.Response.Write(rtn);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}