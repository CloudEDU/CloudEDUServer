<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowRecommendationCourse.aspx.cs" Inherits="CloudEDUServer.adminconsole.ShowRecommendationCourse" %>
<%@ Import Namespace="CloudEDUServer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

    <script src="js/jquery-1.6.4.min.js" type="text/javascript"></script>

    <title></title>

    <script>
        function changeState(id,recId){
            if (document.getElementById('course'+id).checked == true) {
                jQuery.post("ShowRecommendationCourse.asxp", { operate: "yes", id: ele.id,recId:recId });
            }
        }
    </script>

</head>

<body>
    <form id="form1" runat="server">
    <div>
        <%
            try
            {
                // RECOMMENDATION recommendation = CourseAccess.GetRecommendationById(int.Parse(Request.Params.Get("recommendationId")));
                RECOMMENDATION recommendation = CourseAccess.GetAllRecommendations()[0];
                COURSE[] recommendationCourse = CourseAccess.GetCoursesByRecommendation(recommendation);
                COURSE[] allCourse = CourseAccess.GetAllCourses();
                for (int i = 0; i < allCourse.Length; i++)
                {
            %>
                    <input type="checkbox" id="course<%=allCourse[i].ID%>" onchange="changeState(<%=allCourse[i].ID%>)"  style="margin-left:20px;"/><%=allCourse[i].TITLE%>
                    
                    <script>
                        document.getElementById('course<%=allCourse[i].ID%>','<%=recommendation.ID %>').checked=false;
                    </script>
            <%
                    for (int j = 0; j < recommendationCourse.Length; j++)
                    {
                        if (allCourse[i].ID == recommendationCourse[j].ID)
                        {
                            %>
                                <script>
                                    document.getElementById('course<%=allCourse[i].ID%>').checked = true;
                                </script>
                    
                            <%
                            break;
                        }
                    }
                    if (i % 3 == 2)
                    {
                        %>
                            <br />
                        <%
                    }
                }
            }
            catch
            {
                Response.Redirect("Default.aspx");
            }
        %>
    </div>
    </form>
</body>
</html>
