<%@ WebHandler Language="C#" Class="prcAddGenZong" %>

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;
using MediinfoCRM.EntityFramework;


public class prcAddGenZong : IHttpHandler, IRequiresSessionState {
    
        
    public void ProcessRequest (HttpContext context) {


        if (String.IsNullOrEmpty(HttpContext.Current.Session["userid"].ToString()))
        {
            //context.Response.Write("用户未登陆");
            context.Response.Redirect("nologin.aspx");
            return;
        }

        string useid = HttpContext.Current.Session["userid"].ToString();
        
        //获取参数
        if (String.IsNullOrEmpty(context.Request.QueryString["ShangJiXH"]))
        {
            context.Response.Write("参数错误！");
            return;
        }

        string sjxh = context.Request.QueryString["ShangJiXH"].ToString();

        GenZongJL gzjl = new GenZongJL();
        gzjl.ShangJiXH = sjxh;
        gzjl.GenZhongFS = context.Request.QueryString["GenZongFS"].ToString();
        gzjl.BaiFangRQ = context.Request.QueryString["BaiFangRQ"].ToString();
        gzjl.BaiFangDX = context.Request.QueryString["BaiFangDX"].ToString();
        gzjl.GenZongFKQK = context.Request.QueryString["BaiFangNR"].ToString();
        gzjl.XieTongRYID = context.Request.QueryString["XieTongRYID"].ToString();
        gzjl.XieTongRYMC = context.Request.QueryString["XieTongRYXM"].ToString();
        gzjl.XieTongRYBMID = context.Request.QueryString["XieTongRYBMID"].ToString();
        gzjl.XieTongRYBMMC = context.Request.QueryString["XieTongRYBMMC"].ToString();
        gzjl.ChuangJianRID = useid;
        
        string rtn = DataService.AddGenZongJL(gzjl);

        //string rtn = "rtn from prcAddGenZong.ashx";
        if (rtn != "-1")
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(rtn);
        }
        else
        {
            context.Response.Redirect("genzong.aspx?sjxh=" + sjxh); 
        }
        
        //保存跟踪记录
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}