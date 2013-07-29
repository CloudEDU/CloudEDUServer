using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CloudEDUServer.adminconsole
{
    public partial class PermissionList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string operate = Request.Params.Get("operate");
              

         


                if (operate!=null && operate.Equals("search"))
                {
                    try
                    {
                        int result = int.Parse(Request.Params.Get("result"));
                        
                        PERMISSION[] allPermission = ManagerAccess.GetAllPermissions();
                        PERMISSION[] perm;
                        int searchCount=0;
                        for (int i = 0; i < allPermission.Length; i++)
                        {
                            if (  (result & (1 << i)) != 0) 
                            {
                                searchCount++;
                            }
                        }
                        perm = new PERMISSION[searchCount];

                        for (int i = 0; result != 0; i++)
                        {
                            if ((result & (1 << i)) != 0)
                            {
                                perm[--searchCount] = allPermission[i];
                                result -= (1 << i);
                            }
                        }
                        Session["permission_name"] = perm;
                        
                    }
                    catch
                    {
                        Response.Write("数据传输错误");
                        Response.End();
                    }
                    Response.Write("success");
                    Response.End();
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