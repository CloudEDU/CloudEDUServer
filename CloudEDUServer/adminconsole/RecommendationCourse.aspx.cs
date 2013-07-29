using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CloudEDUServer.adminconsole
{
    public partial class RecommendationCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string operate = Request.Params.Get("operate");
                if (operate == null || operate.Equals(""))
                {
                    return ;
                }
                if (operate.Equals("editRecommendation"))
                {
                    Session["recommendationId"] = Request.Params.Get("id");
                }
                else if (operate.Equals("deleteRecommendation"))
                {
                    try
                    {
                        int id = int.Parse(Request.Params.Get("id"));
                        CourseAccess.RemoveRecommendation(CourseAccess.GetRecommendationByID(id));
                    }
                    catch
                    {
                        Response.Write("删除出错，请确认该项是否存在，可以刷新网页重试");
                        Response.End();
                    }
                    Response.Write("success");
                    Response.End();
                }
                else if (operate.Equals("new"))
                {
                    string title = Request.Params.Get("title");
                    string des = Request.Params.Get("description");
                    try
                    {
                        RECOMMENDATION rec = new RECOMMENDATION();
                        rec.TITLE = title;
                        rec.DESCRIPTION = des;
                        CourseAccess.AddRecommendation(rec);
                    }
                    catch
                    {
                        Response.Write("提交错误，请重试");
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