using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MediinfoCRM.EntityFramework
{
    public class ShangJiMini
    {
        public ShangJiMini()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //
            Random ran=new Random();
        
            this.SuiJiShu = ran.Next(0,10000);

        }

        public string ShangJiXH { get; set; }
        public string KeHuMC { get; set; }
        public string XiangMuMC { get; set; }
        public string ZuiHouGX { get; set; }
        public int SuiJiShu { get; set; }
        public int GengZongCS { get; set; }
    }
}
