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
            if (document.getElementById('course' + id).checked == true) {
                jQuery.post("ShowRecommendationCourse.aspx", { operate: "yes", id: id, recId: recId });
            }
            else if (document.getElementById('course' + id).checked == false) {
                jQuery.post("ShowRecommendationCourse.aspx", { operate: "no", id: id, recId: recId });
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
                if (Session["recommendationId"] == null) throw new Exception();
                RECOMMENDATION recommendation = CourseAccess.GetRecommendationByID(int.Parse((string)Session["recommendationId"]));
                Session["recommendationId"] = null;
                COURSE[] recommendationCourse = CourseAccess.GetCoursesByRecommendation(recommendation);
                COURSE[] allCourse = CourseAccess.GetAllCourses();
                for (int i = 0; i < allCourse.Length; i++)
                {
            %>
                    <input type="checkbox" id="course<%=allCourse[i].ID%>" onchange="changeState('<%=allCourse[i].ID%>','<%=recommendation.ID %>')"  style="margin-left:30px;"/><%=allCourse[i].TITLE%>
                    
                    <script>
                        document.getElementById('course<%=allCourse[i].ID%>').checked=false;
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
                    if (i % 2 == 1)
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
