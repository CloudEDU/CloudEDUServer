using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CloudEDUServer;
using System.Web.Services;
using System.Reflection;

namespace cloudEdu
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string account = Request.Params.Get("account");
                string password = Request.Params.Get("password");
                
                if (account == null || password == null)
                {
                    return;
                }
                else
                {
                    MANAGER manager;
                    try
                    {
                        manager = ManagerAccess.GetManagerByName(account);
                    }
                    catch
                    {
                       Response.Write("连接错误，请重新试");
                       Response.End();
                       return;
                    }
                    if (manager == null)
                    {
                        Response.Write("用户不存在");
                        Response.End();
                    }
                    else if (manager.PASSWORD.Equals(password))
                    {
                        Session["manager"] = manager;
                        Response.Write("success");
                        Response.End();
                    }
                    else
                    {
                        Response.Write("密码错误");
                        Response.End();
                    }
                }
            }
            catch
            {
            }

        }
    }
}