//------------------------------------------------------------------------------
// <auto-generated>
//    此代码是根据模板生成的。
//
//    手动更改此文件可能会导致应用程序中发生异常行为。
//    如果重新生成代码，则将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

namespace CloudEDUServer
{
    using System;
    using System.Collections.Generic;
    
    public partial class MANAGER
    {
        public MANAGER()
        {
            this.PERMISSIONs = new HashSet<PERMISSION>();
        }
    
        public int ID { get; set; }
        public string NAME { get; set; }
        public string PASSWORD { get; set; }
        public Nullable<int> MNGR_TYPE { get; set; }
    
        public virtual TYPE TYPE { get; set; }
        public virtual ICollection<PERMISSION> PERMISSIONs { get; set; }
    }
}
