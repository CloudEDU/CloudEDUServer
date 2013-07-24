using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CloudEDUServer.adminconsole
{
    public partial class EditManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string account = Request.Params.Get("account");
                string password = Request.Params.Get("password");
                int permissionNum =int.Parse( Request.Params.Get("permission"));
                if (account == null || password == null)
                {
                    return;
                }

                MANAGER manager = ManagerAccess.GetManagerByName(account);
                if (manager == null)
                {
                    Response.Write("改用户不存在");
                    Response.End();
                    return;
                }

                try
                {
                    manager.NAME = account;
                    manager.PASSWORD = password;

                    PERMISSION[] permission = ManagerAccess.GetPermissionsByManager(manager);
                    for (int i = 0; i < permission.Length; i++)
                    {
                        ManagerAccess.RevokePermissionFromManager(manager.ID, permission[i].ID);
                    }
                    PERMISSION[] allPermission = ManagerAccess.GetAllPermissions();
                    for (int i = 0; permissionNum != 0; i++)
                    {
                        if ((permissionNum & (1 << i)) != 0)
                        {
                            ManagerAccess.GrantPermissionToManager(manager.ID, allPermission[i].ID);
                            permissionNum -= (1 << i);
                        }
                    }
                    ManagerAccess.UpdateManager(manager);
                }
                catch
                {
                    Response.Write("修改错误，请重试");
                    Response.End();
                }
                finally //成功
                {
                    Response.Write("success");
                    Response.End();
                }
            }
            catch
            {
            }
        }
    }
}