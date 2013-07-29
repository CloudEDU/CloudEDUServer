using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CloudEDUServer.adminconsole
{
    public partial class ShowRecommendationCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string operate=Request.Params.Get("operate");

                if (operate == null || operate == "")
                {
                    return;
                }

                int courseId = int.Parse(Request.Params.Get("id"));
                int recId=int.Parse(Request.Params.Get("recId"));
                if (operate.Equals("yes"))
                {
                    CourseAccess.AddCourseToRecommendation(CourseAccess.GetCourseById(courseId), CourseAccess.GetRecommendationByID(recId));
                }
                else
                {
                   
                }
            }
            catch
            {
            }
        }
    }
}