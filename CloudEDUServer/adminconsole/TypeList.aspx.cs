using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CloudEDUServer.adminconsole
{
    public partial class TypeList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string operate = Request.Params.Get("operate");
                MANAGER selfManage = (MANAGER)Session["manager"];

                if (operate.Equals("viewPermissionManager"))
                {
                    string permission_name = Request.Params.Get("permission");
                    PERMISSION p = ManagerAccess.GetPermissionByPermissionName(permission_name);
                    MANAGER[] managers = ManagerAccess.GetManagersByPermission(p);
                    Session["viewPermissionManagers"] = managers;
                    Response.Write("success");
                    Response.End();

                }


                if (operate.Equals("delete"))
                {
                    string deleteManagerAccount = Request.Params.Get("account");
                    MANAGER deleteManager = ManagerAccess.GetManagerByName(deleteManagerAccount);
                    //if (selfManage.PERMISSIONs <= deleteManager.PERMISSIONs)
                    //{
                    //    Response.Write("权限不足");
                    //    Response.End();

                    //}
                    if (deleteManager == null)
                    {
                        Response.Write("管理员不存在");
                        Response.End();
                    }
                    if (ManagerAccess.RemoveManager(deleteManager.ID))
                    {
                        Response.Write("success");
                        Response.End();
                    }
                    else
                    {
                        Response.Write("删除错误，请重试");
                        Response.End();
                    }
                }

                if (operate.Equals("edit"))
                {
                    string account = Request.Params.Get("account");


                    MANAGER editManager = null;
                    try
                    {
                        editManager = ManagerAccess.GetManagerByName(account);
                    }
                    catch
                    {
                        Response.Write("连接错误");
                        Response.End();
                    }
                    if (editManager == null)
                    {
                        Response.Write("该用户不存在");
                        Response.End();
                    }
                    else
                    {
                        
                        Session["type"] = editManager;
                        Response.Write("success");
                        Response.End();
                    }
                }



            }
            catch (Exception ee)
            {

            }
        }
    }
}