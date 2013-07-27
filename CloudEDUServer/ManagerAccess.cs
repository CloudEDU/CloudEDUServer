using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace CloudEDUServer
{
    /// <summary>
    /// ManagerAccess类用来获取Manager系列的信息，包括Manager的信息、Permission信息、Type信息等
    /// </summary>
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

        public static PERMISSION GetPermissionByPermissionName(string name)
        {
            PERMISSION perm = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                perm = ctx.PERMISSIONs.Where(p => p.NAME == name).FirstOrDefault();
            }
            return perm;
        }


        /*
         * 补充getpermissionByManager方法
         * 返回将permission[]转化为一个string，用于前台显示
         */
        public static string getPermissionStringByManager(MANAGER manager)
        {
            PERMISSION[] permissions = GetPermissionsByManager(manager);
            string permissionString="";
            for (int i = 0; i < permissions.Length; i++)
            {
                permissionString += permissions[i].NAME + ' ';
            }
            return permissionString;
        }

        public static PERMISSION[] GetPermissionsByManager(MANAGER manager)
        {
            PERMISSION[] permissions = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                MANAGER mngr = ctx.MANAGERs.Include("PERMISSIONs").Where(m => m.ID == manager.ID).FirstOrDefault();
                permissions = mngr.PERMISSIONs.ToArray();
                //permissions = ctx.PERMISSIONs.Include("MANAGERs")
                //    .Where(p => p.MANAGERs.Contains(manager))
                //    .ToArray<PERMISSION>();
            }
            return permissions;
        }

        public static MANAGER[] GetManagersByPermission(PERMISSION permission)
        {
            MANAGER[] managers = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                PERMISSION perm = ctx.PERMISSIONs.Include("MANAGERs").Where(p => p.ID == permission.ID).FirstOrDefault();
                managers = perm.MANAGERs.ToArray();
                //managers = (from mngr in ctx.MANAGERs
                //            where mngr.PERMISSIONs.Contains<PERMISSION>(permission)
                //            select mngr).ToArray<MANAGER>();
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

        public static MANAGER[] GetManagersByPermissions(PERMISSION[] perms)
        {
            MANAGER[] managers = null;
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                IQueryable<MANAGER> mgr = ctx.MANAGERs.Include("PERMISSIONs");
                foreach (PERMISSION p in perms)
                {
                    mgr = mgr.Where(m => m.PERMISSIONs.Contains(p));
                }
                managers = mgr.ToArray();
            }
            return managers;
        }

        /// <summary>
        /// 创建新的ManagerType，注意ManagerType和Type在当前语义下表示意义相同，均表示Manager的类型
        /// </summary>
        /// <param name="type">需要创建的Type，需要在函数外部创建实例，并且为DESCRIPTION属性赋值</param>
        /// <returns>true表示成功创建，false表示失败</returns>
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

        /// <summary>
        /// 创建新的Manager
        /// </summary>
        /// <param name="manager">需要创建的Manager，需要在函数外部创建实例，
        /// 并且为NAME PASSWORD属性赋值，可以选择为MNGR_TYPE属性赋值，但注意这个属性的类型为int，表示对应的TYPE的主键ID</param>
        /// <returns>true表示成功创建，false表示失败</returns>
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

        /// <summary>
        /// 创建新的Permission
        /// </summary>
        /// <param name="permission">需要创建的Manager，需要在函数外部创建实例，并且为NAME和TYPE属性赋值</param>
        /// <returns>true表示成功创建，false表示失败</returns>
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

        /// <summary>
        /// 用于更改Manager的一般信息，包括NAME和PASSWORD，不可用于更改PERMISSION和TYPE
        /// </summary>
        /// <param name="manager">更改后的Manager实例</param>
        /// <returns>true表示成功创建，false表示失败</returns>
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

        /// <summary>
        /// 用于更改Permission的一般信息，包括NAME和TYPE
        /// </summary>
        /// <param name="permission">更改后的Permission的实例</param>
        /// <returns>true表示成功创建，false表示失败</returns>
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

        /// <summary>
        /// 用于更改TYPE的一般信息，包括DESCRIPTION
        /// </summary>
        /// <param name="type">更改后的TYPE的实例</param>
        /// <returns>true表示成功创建，false表示失败</returns>
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

        /// <summary>
        /// 用于更改Manager的Type
        /// </summary>
        /// <param name="manager">需要更改的Manager的实例</param>
        /// <param name="type">需要改为的Type的ID</param>
        /// <returns>true表示成功创建，false表示失败</returns>
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

        /// <summary>
        /// 为Manager授予权限
        /// </summary>
        /// <param name="manager_id">被授予权限的Manager的ID</param>
        /// <param name="permission_id">被授予的权限的ID</param>
        /// <returns>true表示成功创建，false表示失败</returns>
        public static bool GrantPermissionToManager(int manager_id, int permission_id)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    var manager = ctx.MANAGERs.Include("PERMISSIONs").Where(mngr => mngr.ID == manager_id).FirstOrDefault<MANAGER>();
                    var perm = ctx.PERMISSIONs.Where(p => p.ID == permission_id).FirstOrDefault<PERMISSION>();
                    //System.Diagnostics.Debug.WriteLine(ctx.Entry(manager).State);
                    //System.Diagnostics.Debug.WriteLine(ctx.Entry(perm).State);
                    manager.PERMISSIONs.Add(perm);
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

        /// <summary>
        /// 回收授予某Manager的权限
        /// </summary>
        /// <param name="manager_id">被回收的Manager的ID</param>
        /// <param name="permission_id">被回收的Permission的ID</param>
        /// <returns>true表示成功创建，false表示失败</returns>
        public static bool RevokePermissionFromManager(int manager_id, int permission_id)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    var manager = ctx.MANAGERs.Include("PERMISSIONs").Where(mngr => mngr.ID == manager_id).FirstOrDefault<MANAGER>();
                    var perm = ctx.PERMISSIONs.Where(p => p.ID == permission_id).FirstOrDefault<PERMISSION>();
                    //System.Diagnostics.Debug.WriteLine(ctx.Entry(manager).State);
                    //System.Diagnostics.Debug.WriteLine(ctx.Entry(perm).State);
                    manager.PERMISSIONs.Remove(perm);
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

        /// <summary>
        /// 移除TYPE。如果有Manager与该TYPE相关联，则该Manager的MNGR_TYPE将会为NULL
        /// </summary>
        /// <param name="type_id">被删除的TYPE的id</param>
        /// <returns>true表示成功创建，false表示失败</returns>
        public static bool RemoveManagerType(int type_id)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    var type = ctx.TYPEs.Where(m => m.ID == type_id).FirstOrDefault<TYPE>();
                    ctx.Set<TYPE>().Remove(type);
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

        public static bool RemoveManager(int manager_id)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    var manager = ctx.MANAGERs.Where(m => m.ID == manager_id).FirstOrDefault<MANAGER>();
                    ctx.Set<MANAGER>().Remove(manager);
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

        public static bool RemovePermission(int permission_id)
        {
            using (CloudEDUEntities ctx = new CloudEDUEntities())
            {
                try
                {
                    var permission = ctx.PERMISSIONs.Where(m => m.ID == permission_id).FirstOrDefault<PERMISSION>();
                    ctx.Set<PERMISSION>().Remove(permission);
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
    }
}