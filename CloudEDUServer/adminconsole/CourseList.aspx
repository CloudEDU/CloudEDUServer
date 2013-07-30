<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseList.aspx.cs" Inherits="CloudEDUServer.adminconsole.CourseList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

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

    <script src="js/setup.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            setupLeftMenu();
            $('.datatable').dataTable({
                "sPaginationType": "full_numbers"
            });
            setSidebarHeight();
        });

        function showCourseInfo(courseID) {
            window.location.href = "CourseInfo.aspx?courseId="+courseID;
        }

        function courseListSelect() {
            jQuery.post("CourseList.aspx", { operate: "select", value: document.getElementById("CourseListSelect").value }, function () {
                window.location.href = "CourseList.aspx";
            })
        }

        function showComment(courseId) {
            jQuery.post("CourseComment.aspx", { course: courseId }, function () {
                window.location.href = "CourseComment.aspx";
            });
        }

        function editCourse(courseId) {
            jQuery.post("CourseList.aspx", { operate: "edit", courseId: courseId }, function (data) {
                if (data == "success") {

                    window.location.href = "EditCourse.aspx";
                }
                else {
                    alert(data);
                }
            });
        }
    </script>

</head>
<body id="Body1" runat="server">
    <div class="container_12">    
        <!--#include file="Navigation.aspx" -->
        <%
            if (!ManagerAccess.haveCourseViewPermission((MANAGER)Session["manager"]))
            {
                Response.Redirect("Default.aspx");
                Response.End();
            }
        %>
        <div class="grid_10">
            <div class="box round first grid">
                <h2>
                    <select id="CourseListSelect" onchange="courseListSelect()">
                        <option value="all">All Course</option>
                        <option value="pending">Pending Course</option>
                        <option value="ok">OK Course </option>
                        <option value="cancel">Cancel Course</option>
                    </select>
                    <%
                        if (Session["CourseListSelect"]==null)
                        {
                            Session["CourseListSelect"] = "all";
                        }; 
                    %>
                    <script>
                        document.getElementById('CourseListSelect').value = "<%=Session["CourseListSelect"]%>";
                    </script>
                </h2>
               
                <div class="block">
                    
					<table class="data display datatable">
					<thead>
						<tr>
				            <th style="text-align:center">Title</th>
							<th style="text-align:center">Price</th>
							
                            <th style="text-align:center">Teacher</th>
                            <th style="text-align:center">Category</th>
                            <th style="text-align:center">Status</th>
                            <th style="text-align:center">Pg</th>
                            <th style="text-align:center">Iconurl</th>
                            <th style="text-align:center">StartTime</th>
                            <th style="text-align:center">Download</th>
                            <th style="text-align:center">Infor</th>
                            <th style="text-align:center">Comment</th>
						</tr>
					</thead>
					<tbody>
                        <% 
                            COURSE[] course =null;
                    
                            if (Session["CourseListSelect"].Equals("pending"))
                            {
                                course = CourseAccess.GetAllPendingCourses();
                            }
                            else if (Session["CourseListSelect"].Equals("cancel"))
                            {
                                course = CourseAccess.GetAllCancelCourses();
                            }
                            else if (Session["CourseListSelect"].Equals("ok"))
                            {
                                course = CourseAccess.GetAllOKCourses();
                            }
                            else
                            {
                                course = CourseAccess.GetAllCourses();
                            }
                                          
                            for (int i=0; i<course.Length; i++)
                            {
                                if (ManagerAccess.haveCourseEditPermission((MANAGER)Session["manager"]))
                                {
                         %>
                            
						        <tr ondblclick="editCourse('<%=course[i].ID %>')">
                                <%}
                                  else
                                  {%>
                                <tr>
                                 <%}%>
							    <td style="text-align:center"><%=course[i].TITLE %></td>	
							    <td style="text-align:center"><%=course[i].PRICE.ToString().Substring(0,course[i].PRICE.ToString().Length-2) %></td>
                                <td style="text-align:center"><%=course[i].TEACHER %></td>						    
							    <td style="text-align:center"><%=CourseAccess.GetCategoryByID((int)course[i].CATEGORY).CATE_NAME %></td>
                                <td style="text-align:center"><%=course[i].COURSE_STATUS %></td>
							    <td style="text-align:center"><%=course[i].PG %></td>
							    <td style="text-align:center"><%=course[i].ICON_URL %></td>	
                                <td style="text-align:center"><%=course[i].START_TIME %></td>						    
							    <td style="text-align:center"><%=CourseAccess.GetDownloadTimeByCourseID(course[i].ID) %></td>
                                <td style="text-align:center"><a href="#" onclick="showCourseInfo(<%=course[i].ID%>)">more</a></td>
                                <td style="text-align:center"><a href="#" onclick="showComment('<%=course[i].ID %>')">评论</a></td>
						    </tr>	
                        <%  } %>	
					</tbody>
				    </table>                               
                </div>
            </div>
        </div>
        <div class="clear">
        </div>
    </div>
    <div class="clear">
    </div>
    <div id="site_info">
        <p>
            Copyright <a href="#">Cloud Edu</a>. All Rights Reserved.
        </p>
    </div>
</body>
</html>