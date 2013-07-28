using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CloudEDUServer.adminconsole
{
    public partial class CourseComment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string userId = Request.Params.Get("user");
                if (userId != null)
                {
                    Session["userComment"] = CustomerAccess.GetCustomerByID(int.Parse(userId));
                    Response.End();
                }
                string course = Request.Params.Get("course");
                if (course != null)
                {
                    Session["courseComment"] = CourseAccess.GetCourseById(int.Parse(course));
                    Response.End();
                }
            }
            catch
            {
            }
         
        }
    }
}