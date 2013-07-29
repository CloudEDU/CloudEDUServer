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
            }
            catch
            {
            }
        }
    }
}