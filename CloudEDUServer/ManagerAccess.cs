using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

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
            //       System.Diagnostics.Debug.WriteLine(manager);
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

        public static bool AddManagerType(TYPE type)
        {
            int count = 0;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    ctx.TYPEs.Add(type);
                    count = ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return count == 1;
        }

        public static bool AddManager(MANAGER manager)
        {
            int count = 0;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    ctx.MANAGERs.Add(manager);
                    count = ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return count == 1;
        }

        public static bool AddPermission(PERMISSION permission)
        {
            int count = 0;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    ctx.PERMISSIONs.Add(permission);
                    count = ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return count == 1;
        }

        public static bool UpdateManager(MANAGER manager)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    ctx.Entry(manager).State = System.Data.EntityState.Modified;
                    ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return true;
        }

        public static bool UpdatePermission(PERMISSION permission)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    ctx.Entry(permission).State = System.Data.EntityState.Modified;
                    ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return true;
        }

        public static bool UpdateManagerType(TYPE type)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    ctx.Entry(type).State = System.Data.EntityState.Modified;
                    ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return true;
        }

        public static bool ChangeManagerManagerType(MANAGER manager, int type)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    manager.MNGR_TYPE = type;
                    ctx.Entry(manager).State = System.Data.EntityState.Modified;
                    ctx.SaveChanges();
                }
                catch (Exception e)
                {
                    System.Diagnostics.Debug.WriteLine(e.ToString());
                    return false;
                }
            }
            return true;
            //throw new Exception("Not Support Yet");
        }

        public static bool GrantPermissionToManager(int manager_id, int permission_id)
        {

            //throw new Exception("Not Support Yet");
        }

        public static bool RevokePermissionFromManager(MANAGER manager, PERMISSION permission)
        {
            throw new Exception("Not Support Yet");
        }

        public static bool RemoveManagerType(TYPE type)
        {
            throw new Exception("Not Support Yet");
        }

        public static bool RemoveManager(MANAGER manager)
        {
            throw new Exception("Not Support Yet");
        }

        public static bool RemovePermission(PERMISSION permission)
        {
            throw new Exception("Not Support Yet");
        }
    }
}