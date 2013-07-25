using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CloudEDUServer.adminconsole
{
    public partial class Permission : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string operate = Request.Params.Get("operate");


                if (operate.Equals("viewPermissionManager"))
                {
                    int id =int.Parse(Request.Params.Get("id"));

                }
                
                
                
                //MANAGER selfManage = (MANAGER)Session["manager"];





               



            }
            catch (Exception ee)
            {

            }
        }
    }
}