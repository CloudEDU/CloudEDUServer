<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseComment.aspx.cs" Inherits="CloudEDUServer.adminconsole.CourseComment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
            $('.datatable').dataTable({
                "sPaginationType": "full_numbers"
            });
            setupLeftMenu();
            setSidebarHeight();
        });

        function deleteComment(id) {
            if (confirm("确认删除该评论吗")) {
                jQuery.post("CourseComment.aspx", { operate: "delete", id: id }, function (data) {
                    if (data=="successs")
                    {
                        window.location.href = "CourseComment.aspx";
                    }
                });
            }
        }
    </script>

</head>
<body id="Body1" runat="server">
    <div class="container_12">
        <!--#include file="Navigation.aspx" -->

        <div class="grid_10">
            <div class="box round first grid">
                <h2>User List</h2>
                <div class="block">

                    <table class="data display datatable">
                        <thead>
                            <tr>
                                <th style="text-align: center">Course Title</th>
                                <th style="text-align: center">Title</th>
                                <th style="text-align: center">User Name</th>
                                <th style="text-align: center">Content</th>
                                <%--     <th style="text-align:center">Rate</th>--%>
                                <th style="text-align: center">Time</th>
                                <th style="text-align:center">Delete</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                            COURSE course = (COURSE)Session["courseComment"];
                            CUSTOMER user=(CUSTOMER)Session["userComment"];
                            COMMENT[] comment=null;
                            
                            if (course!=null || user!=null)
                            {
                                if (course!=null)
                                {
                                    comment=CourseAccess.GetCommentsByCourse(course);
                                    Session["courseComment"]=null;
                                }
                                else if (user!=null)
                                {
                                    comment=CourseAccess.GetCommentsByCustomer(user);
                                    Session["userComment"]=null;
                                }
                            
                                ////////////////////show comment
                                for (int i=0; i<comment.Length; i++)
                                {
                                %>
                                <tr>
                                    <td style="text-align: center"><%=CourseAccess.GetCourseById(comment[i].COURSE_ID).TITLE %></td>
                                    <td style="text-align: center"><%=comment[i].TITLE %></td>
                                    <td style="text-align: center"><%=CustomerAccess.GetCustomerByID( comment[i].CUSTOMER_ID).NAME %></td>
                                    <td style="text-align: center"><%=comment[i].CONTENT %></td>
                                    <td style="text-align: center"><%=comment[i].TIME %></td>
                                    <td style="text-align:center" onclick="deleteComment(<%=comment[i].ID %>)">删除</td>
                                </tr>
                                <%
                                }
                            }
                            else
                            {
                                COURSE[] allCourse = CourseAccess.GetAllCourses();
                                for (int j=0; j<allCourse.Length; j++)
                                {
                                    COMMENT[] allComment = CourseAccess.GetCommentsByCourse(allCourse[j]);
                                    for (int i = 0; i < allComment.Length; i++)
                                    {
                                    %>
                                        <tr>
                                            <td style="text-align: center"><%=allCourse[j].TITLE %></td>
                                            <td style="text-align: center"><%=allComment[i].TITLE %></td>
                                            <td style="text-align: center"><%=CustomerAccess.GetCustomerByID( allComment[i].CUSTOMER_ID).NAME %></td>
                                            <td style="text-align: center"><%=allComment[i].CONTENT %></td>
                                            <td style="text-align: center"><%=allComment[i].TIME %></td>
                                        </tr>
                                    <%
                                    }
                                }
                            }
                            %>
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

