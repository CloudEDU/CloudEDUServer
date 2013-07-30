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
            try
            {
                string operate = Request.Params.Get("operate");
                string value = Request.Params.Get("value");
                if (operate != null && operate.Equals("select"))
                {
                    Session["CourseListSelect"] = value;
                }
                else if (operate != null && operate.Equals("edit"))
                {
                    try
                    {
                        COURSE course = CourseAccess.GetCourseById(int.Parse(Request.Params.Get("courseId")));
                        Session["editCourse"] = course;
                    }
                    catch
                    {
                        Response.Write("编辑错误");
                        Response.End();
                    }
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