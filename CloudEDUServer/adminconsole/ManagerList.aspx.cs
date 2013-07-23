using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CloudEDUServer;
using System.Web.Services;

namespace CloudEDUServer.adminconsole
{
    public partial class ManagerList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string operate=Request.Params.Get("operate");
                MANAGER selfManage = (MANAGER)Session["manager"];

                if (operate.Equals("delete"))
                {
                    string deleteManagerAccount = Request.Params.Get("account");
                    MANAGER deleteManager = ManagerAccess.GetManagerByName(deleteManagerAccount);
                    //if (selfManage.PERMISSIONs <= deleteManager.PERMISSIONs)
                    //{
                    //    Response.Write("权限不足");
                    //    Response.End();
                        
                    //}
                }

                if (operate.Equals("edit"))
                {
                    string account=Request.Params.Get("account");
                   // MANAGER editManager = ManagerAccess.GetManagerByName(account);
                    MANAGER editManager = new MANAGER();
                    if (editManager == null)
                    {
                        Response.Write("该用户不存在");
                        Response.End();
                    }
                    //else if  permission
                    else
                    {
                        Session["editAccount"] = account;
                        Response.Write("success");
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