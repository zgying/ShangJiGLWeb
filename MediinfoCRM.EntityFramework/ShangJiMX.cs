using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MediinfoCRM.EntityFramework
{
    public class ShangJiMX
    {
        public ShangJiMX()
        {}
        
        public string XuHao {get;set;}
        public string KeHuMC { get; set; }
        public string LeiBie { get; set; }  //类别ID
        public string LeiBieMC  {get;set;}
        public string NeiRong  {get;set;}
        public string XiangMuYS { get; set; }   //项目预算
        public string GenZongZTMC {get;set;}
        public string YuQi {get;set;}           
        public string CaiGouFS  {get;set;}      //采购方式  
        public string CaiGouFSMC { get; set; }      //采购方式  
        public string DangQianJD { get; set; }  //当前进度
        public string ChengDanGL  { get; set; } // 成单率
        public string BeiZhu { get; set; }      //备注
    }

}
