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

        public static MANAGER[] GetAllManagers()
        {
            MANAGER[] managers = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                managers = ctx.MANAGERs.ToArray<MANAGER>();
            }
            return managers;
        }

        public static PERMISSION[] GetAllPermissions()
        {
            PERMISSION[] permissions = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                permissions = ctx.PERMISSIONs.ToArray<PERMISSION>();
            }
            return permissions;
        }

        public static MANAGER[] GetManagersByPermission(PERMISSION permission)
        {
            MANAGER[] managers = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                managers = (from mngr in ctx.MANAGERs
                            where mngr.PERMISSIONs.Contains<PERMISSION>(permission)
                            select mngr).ToArray<MANAGER>();
            }
            return managers;
        }

        public static TYPE[] GetAllManagerTypes()
        {
            TYPE[] types = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                types = ctx.TYPEs.ToArray<TYPE>();
            }
            return types;
        }

        public static MANAGER[] GetManagersByManagerType(TYPE type)
        {
            MANAGER[] managers = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                managers = (from mngr in ctx.MANAGERs
                            where mngr.TYPE.Equals(type)
                            select mngr).ToArray<MANAGER>();
            }
            return managers;
        }
    }
}