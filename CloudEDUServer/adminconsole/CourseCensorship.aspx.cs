using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CloudEDUServer.adminconsole
{
    public partial class CourseCensorship : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
             try
            {
                int id=int.Parse(Request.Params.Get("courseId"));
                string stateStr=Request.Params.Get("courseState");
                if (stateStr.Equals("OK"))
                {
                    CourseAccess.UpdateCourseStatus(id, CourseStatus.OK);
                }
                else if (stateStr.Equals("Pending"))
                {
                    CourseAccess.UpdateCourseStatus(id, CourseStatus.PENDING);
                }
                else if (stateStr.Equals("Cancel"))
                {
                    CourseAccess.UpdateCourseStatus(id, CourseStatus.CANCEL);
                }
                
            }
            catch
            {
            }
        }
    }
}