﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseInfo.aspx.cs" Inherits="CloudEDUServer.CourseInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>Cloud Edu</title>
    
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

        function showResource(lessonId) {
            window.location.href = "Resource.aspx?lessonId="+lessonId;
        }

        function showDocument(lessonId) {
            window.location.href = "Document.aspx?lessonId=" + lessonId;
        }

        function showNote(lessonId) {
            window.location.href = "UserNote.aspx?lessonId=" + lessonId;
        }
     </script>

</head>
<body>
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
            <div class="box round first">
                <h2>
                    Course Information</h2>
                <div class="block">
                    <!-- paragraphs -->
                    <%
                        COURSE course=null;
                        try
                        {
                            course = CourseAccess.GetCourseById(int.Parse(Request.Params.Get("courseId")));
                        }
                        catch
                        {
                        }
                        if (course == null)
                        {
                            Response.Redirect("Default.aspx");
                            Response.End();
                            return;
                        }
                    %>
                    <p class="start">
                        <img src="img/vertical.jpg" alt="Ginger" class="right" style="margin-left:auto; margin-right:auto" /><%=course.INTRO %></p>

                    <table class="data display datatable">
					<thead>
						<tr>
                            <th style="text-align:center">Title</th>
							<th style="text-align:center">Number</th>
							<th style="text-align:center">Content</th>						
                            <th style="text-align:center">Resource</th>
                            <th style="text-align:center">Document</th>
                            <th style="text-align:center">Note</th>
						</tr>
					</thead>
					<tbody>
                        <%
                            LESSON[] lesson = CourseAccess.GetLessonsByCourse(course);
                            for (int i=0; i<lesson.Length; i++)
                            {
                        %>
						    <tr>
                                <td style="text-align:center"><%=lesson[i].TITLE %></td>
							    <td style="text-align:center"><%=lesson[i].NUMBER %></td>
							    <td style="text-align:center"><%=lesson[i].CONTENT %></td>			    	
                                <td style="text-align:center"><a href="javascript:showResource('<%=lesson[i].ID %>')">资源</a></td>
                                <td style="text-align:center"><a href="javascript:showDocument('<%=lesson[i].ID %>')">文档</a></td>
                                <td style="text-align:center"><a href="javascript:showNote('<%=lesson[i].ID %>')">笔记</a></td>
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
