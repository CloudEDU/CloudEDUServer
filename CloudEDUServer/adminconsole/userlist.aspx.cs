using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CloudEDUServer.adminconsole
{
    public partial class UserList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                int id = int.Parse(Request.Params.Get("userId"));
                string stateStr = Request.Params.Get("userState");
                CUSTOMER user = CustomerAccess.GetCustomerByID(id);
                if (user == null) return;  
                if (stateStr.Equals("YES"))
                {
                    user.ALLOW = true;
                   
                }
                else if (stateStr.Equals("NO"))
                {
                    user.ALLOW = false;
                }

                CustomerAccess.UpdateCustomer(user);

            }
            catch
            {
            }
        }
    }
}