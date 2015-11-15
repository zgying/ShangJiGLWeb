using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using Oracle.DataAccess;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using MediinfoCRM.EntityFramework;

namespace MediinfoCRM.EntityFramework
{
    public class DataService
    {        
        //public static string ConnectionString = "Data Source=ORCL;User Id=mmis;Password=MediOAdb13528;";
        public static string ConnectionString = string.Empty;
        
        private static OracleConnection GetOraConnection()
        {
            try
            {
                ConnectionString = ConfigurationManager.ConnectionStrings["MediinfoOA"].ConnectionString;
                return new OracleConnection(ConnectionString);
            }
            catch
            {
                throw new Exception("Oracle Connection String is invalid.");
            }
        }

        //获取商机列表
        public static List<ShangJiMini> getMyShangJi(string token, string userid, int pageindex, string orderby)
        {
            List<ShangJiMini> rtn = new List<ShangJiMini>();

            using (OracleConnection conn = GetOraConnection())
            {
                conn.Open();

                OracleCommand cmd = new OracleCommand();
                cmd.Connection = conn;
                cmd.CommandText = "select * from v_sjgl_e_shangjimini a where xsryid = '" + userid + "'"; //"0283"
                cmd.CommandType = CommandType.Text;

                OracleDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    ShangJiMini item = new ShangJiMini();
                    item.ShangJiXH = dr["xh"].ToString();
                    item.KeHuMC = dr["khmc"].ToString();
                    item.XiangMuMC = dr["lbmc"].ToString();
                    item.ZuiHouGX = dr["zhgx"].ToString();
                    item.GengZongCS = int.Parse(dr["gxcs"].ToString());

                    rtn.Add(item);
                }
            }

            return rtn;
        }

        //获取商机明细
        public static ShangJiMX getShangJiMX(string shangjixh)
        {
            ShangJiMX rtn = new ShangJiMX();

            using (OracleConnection conn = GetOraConnection())
            {
                conn.Open();

                OracleCommand cmd = new OracleCommand();
                cmd.Connection = conn;
                cmd.CommandText = "select * from V_SJGL_E_SHANGJIMX a where XUHAO = '" + shangjixh + "'"; //"0283"
                cmd.CommandType = CommandType.Text;

                OracleDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    rtn.XuHao = dr["XUHAO"].ToString();             //序号
                    rtn.KeHuMC = dr["KEHUMC"].ToString();               //客户名称
                    rtn.LeiBieMC = dr["LEIBIEMC"].ToString();           //类别名称
                    rtn.NeiRong = dr["NEIRONG"].ToString();             //商机内容
                    rtn.GenZongZTMC = dr["GENZONGZTMC"].ToString();     //跟踪状态名称
                    rtn.YuQi = Convert.ToDateTime(dr["YUQI"].ToString()).ToString("yyyy-MM-dd");                   //预期
                    rtn.CaiGouFS = dr["CAIGOUFSDM"].ToString();           //采购方式
                    rtn.CaiGouFSMC = dr["CAIGOUFS"].ToString();           //采购方式

                    rtn.ChengDanGL = dr["CHENGDANGL"].ToString();       //成单概率 dr[""].ToString();
                    rtn.LeiBie = dr["LEIBIE"].ToString();               //商机类别
                    rtn.XiangMuYS = dr["XIANGMUYS"].ToString();         //项目预算
                    rtn.DangQianJD = dr["GenZongZT"].ToString();        //当前进度 即 跟踪状态                    
                }
            }

            return rtn;
        }


        //获取跟踪记录列表
        //获取商机列表
        public static List<GenZongJL> getGenZongJL(string shangjixh, int pageindex, string orderby)
        {
            List<GenZongJL> rtn = new List<GenZongJL>();

            using (OracleConnection conn = GetOraConnection())
            {
                conn.Open();

                OracleCommand cmd = new OracleCommand();
                cmd.Connection = conn;
                cmd.CommandText = "select * from v_sjgl_e_genzongjl a where SHANGJIXH = '" + shangjixh + "' order by baifangrq desc "; //"0283"
                cmd.CommandType = CommandType.Text;

                OracleDataReader dr = cmd.ExecuteReader();

                int i = 0;
                while (dr.Read())
                {
                    GenZongJL item = new GenZongJL();
                    item.BaiFangRQ = dr["BaiFangRQ"].ToString().Substring(0, 10);
                    item.ShiJianDuan = dr["ShiJianDuan"].ToString();
                    item.BaiFangDX = dr["BaiFangDX"].ToString();
                    item.GenZhongFS = dr["GenZhongFS"].ToString();
                    item.GenZongFKQK = dr["GenZongFKQK"].ToString();
                    item.XieTongRYMC = dr["XieTongRYMC"].ToString();
                    i++;

                    rtn.Add(item);

                    for (int k = 0; k < i; k++)
                    {
                        rtn[k].CiShu = (i - k).ToString();
                    }

                }
            }

            return rtn;
        }


        //获取职工信息
        public static List<ZhiGongXX> getZhiGongXX(string leixing)
        {
            List<ZhiGongXX> rtn = new List<ZhiGongXX>();

            using (OracleConnection conn = GetOraConnection())
            {
                conn.Open();

                OracleCommand cmd = new OracleCommand();
                cmd.Connection = conn;
                cmd.CommandText = "select zhigongid,xingming,xingmingpy,suozaiks,keshimc from v_sjgl_zhigongxx a where zhuxiaobz <> 1 order by xingming "; //"0283"
                cmd.CommandType = CommandType.Text;

                OracleDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    ZhiGongXX item = new ZhiGongXX();
                    item.ZhiGongID = dr["zhigongid"].ToString();
                    item.XingMing = dr["xingming"].ToString();
                    item.XingMingPY = dr["xingmingpy"].ToString();
                    item.SuoZaiKS = dr["suozaiks"].ToString();
                    item.KeShiMC = dr["keshimc"].ToString();

                    rtn.Add(item);

                }
            }

            return rtn;
        }

        public static string AddGenZongJL(GenZongJL gzjl)
        {
            string rtn = string.Empty;

            using (OracleConnection conn = GetOraConnection())
            {
                conn.Open();

                OracleCommand cmd = new OracleCommand();
                cmd.Connection = conn;
                cmd.CommandText = "PKG_SJGL.PRC_AddShangJiGXJR";
                cmd.CommandType = CommandType.StoredProcedure;


                cmd.Parameters.Add("prm_ShangJiXH", OracleDbType.Int32).Value = int.Parse(gzjl.ShangJiXH);
                cmd.Parameters.Add("prm_GenZongFS", OracleDbType.Varchar2, 10).Value = gzjl.GenZhongFS ;
                cmd.Parameters.Add("prm_BaiFangRQ", OracleDbType.Date ).Value = Convert.ToDateTime(gzjl.BaiFangRQ).Date ;
                cmd.Parameters.Add("prm_BaiFangDX", OracleDbType.Varchar2, 10).Value = gzjl.BaiFangDX;
                cmd.Parameters.Add("prm_GenZongFK", OracleDbType.Varchar2, 10).Value = gzjl.GenZongFKQK;
                cmd.Parameters.Add("prm_XieTongRYID", OracleDbType.Varchar2, 10).Value = gzjl.XieTongRYID ;
                cmd.Parameters.Add("prm_XieTongRYMC", OracleDbType.Varchar2, 10).Value = gzjl.XieTongRYMC;
                cmd.Parameters.Add("prm_XieTongRYBMID", OracleDbType.Varchar2, 10).Value = gzjl.XieTongRYBMID;
                cmd.Parameters.Add("prm_XieTongRYBMMC", OracleDbType.Varchar2, 10).Value = gzjl.XieTongRYBMMC;
                cmd.Parameters.Add("prm_ZhiGongID", OracleDbType.Varchar2, 500).Value = gzjl.ChuangJianRID;

                try
                {
                    int i = cmd.ExecuteNonQuery();
                    rtn = i.ToString();
                }
                catch (Exception ex)
                {
                    rtn = ex.Message;
                }
            }


            return rtn;
        }
    
    }
}
