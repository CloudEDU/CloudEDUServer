<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowRecommendationCourse.aspx.cs" Inherits="CloudEDUServer.adminconsole.ShowRecommendationCourse" %>
<%@ Import Namespace="CloudEDUServer" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>Cloud Edu</title>

    <meta http-equiv="content-type" content="text/html; charset=utf-8" />

    <link rel="stylesheet" type="text/css" href="css/reset.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/text.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/grid.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/layout.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/nav.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/usercss.css" media="screen" />
    <!--[if IE 6]><link rel="stylesheet" type="text/css" href="css/ie6.css" media="screen" /><![endif]-->
    <!--[if IE 7]><link rel="stylesheet" type="text/css" href="css/ie.css" media="screen" /><![endif]-->
    <link href="css/table/demo_page.css" rel="stylesheet" type="text/css" />
    <!-- BEGIN: load jquery -->
    <script src="js/jquery-1.6.4.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/jquery-ui/jquery.ui.core.min.js"></script>
    <script src="js/jquery-ui/jquery.ui.widget.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.accordion.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.core.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.slide.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.mouse.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.sortable.min.js" type="text/javascript"></script>
    <script src="js/table/jquery.dataTables.min.js" type="text/javascript"></script>
    <!-- END: load jquery -->

    <!-- BEGIN: load jqplot -->
    <link rel="stylesheet" type="text/css" href="css/jquery.jqplot.min.css" />
    <!--[if lt IE 9]><script language="javascript" type="text/javascript" src="js/jqPlot/excanvas.min.js"></script><![endif]-->
    <script language="javascript" type="text/javascript" src="js/jqPlot/jquery.jqplot.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/jqPlot/plugins/jqplot.barRenderer.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/jqPlot/plugins/jqplot.pieRenderer.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/jqPlot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/jqPlot/plugins/jqplot.highlighter.min.js"></script>
    <script language="javascript" type="text/javascript" src="js/jqPlot/plugins/jqplot.pointLabels.min.js"></script>
    <!-- END: load jqplot -->

    <!--jQuery Date Picker-->
    <script src="js/jquery-ui/jquery.ui.widget.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.datepicker.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.progressbar.min.js" type="text/javascript"></script>
    <!-- jQuery dialog related-->
    <script src="js/jquery-ui/external/jquery.bgiframe-2.1.2.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.mouse.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.draggable.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.position.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.resizable.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.dialog.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.core.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.blind.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.explode.min.js" type="text/javascript"></script>
    <!-- jQuery dialog end here-->
    <script src="js/jquery-ui/jquery.ui.accordion.min.js" type="text/javascript"></script>

    <!--Fancy Button-->
    <script src="js/fancy-button/fancy-button.js" type="text/javascript"></script>
    <script src="js/setup.js" type="text/javascript"></script>
    <!-- Load TinyMCE -->
    <script src="js/tiny-mce/jquery.tinymce.js" type="text/javascript"></script>

    <script type="text/javascript" src="js/table/table.js"></script>
    <script src="js/setup.js" type="text/javascript"></script>

    <script type="text/javascript">

        $(document).ready(function () {
            setupLeftMenu();
            $('.datatable').dataTable({
                "sPaginationType": "full_numbers"
            });
            setSidebarHeight();
        });


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
        <table class="data display datatable">
            <thead>
				<tr>
	                <th style="text-align:center">Title</th>
				    <th style="text-align:center">Price</th>							
                    <th style="text-align:center">Check</th>
				</tr>
			</thead>
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
                    if (allCourse[i].COURSE_STATUS.ToLower().Trim().Equals("ok"))
                    {
            %>      <tr>
                        <td style="text-align:center"><%=allCourse[i].TITLE %></td>
                        <td style="text-align:center"><%=allCourse[i].PRICE %></td>
                        <td style="text-align:center">
                        <input type="checkbox" id="course<%=allCourse[i].ID%>" onchange="changeState('<%=allCourse[i].ID%>','<%=recommendation.ID %>')" />          
                        </td>
                    </tr>       
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
                    }
                }
            }
            catch
            {
                Response.Redirect("Default.aspx");
            }
        %>
        </table>
    </div>
    </form>
</body>
</html>
