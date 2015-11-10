using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MediinfoCRM.EntityFramework
{
    public class ZhiGongXX
    {
        public string _xingmingpy;

        public ZhiGongXX()
        { }

        
        public string ZhiGongID { get; set; }
        public string XingMing { get; set; }
        public string XingMingPY
        {
            get { return _xingmingpy; }
            set {
                _xingmingpy = value;
                XingMingSZM = value.Substring(0, 1); 
            }
        }
        public string XingMingSZM { get; set; }
        public string SuoZaiKS { get; set; }
        public string KeShiMC { get; set; }
        public string PingYing { get; set; }
    }
}
