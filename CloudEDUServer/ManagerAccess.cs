using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CloudEDUServer
{
    public class ManagerAccess
    {
        public static MANAGER GetManagerByName(string name)
        {
            MANAGER manager = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                var returnValue = from mngr in ctx.MANAGERs
                                  where mngr.NAME == name
                                  select mngr;
                manager = returnValue.FirstOrDefault<MANAGER>();
            }
            return manager;
        }

    }
}