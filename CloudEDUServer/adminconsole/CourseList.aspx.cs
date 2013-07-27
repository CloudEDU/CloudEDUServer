using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CloudEDUServer.adminconsole
{
    public partial class CourseList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string operate = Request.Params.Get("operate");
            string value = Request.Params.Get("value");
            if (operate.Equals("select"))
            {
                Session["CourseListSelect"] = value;
            }
        }
    }
}