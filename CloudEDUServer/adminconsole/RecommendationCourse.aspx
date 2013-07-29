<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecommendationCourse.aspx.cs" Inherits="CloudEDUServer.adminconsole.RecommendationCourse" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>Typography | BlueWhale Admin</title>

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

        function editRecommendation(id) {
            jQuery.post("RecommendationCourse.aspx", {operate:"editRecommendation", id: id }, function () {
                window.showModalDialog("ShowRecommendationCourse.aspx");
            });
        }

        var isDelete = false;
        function deleteRecommendation(id) {
            if (isDelete) {
                alert("删除中，请稍后");
                return;
            }
            isDelete = true;
            jQuery.post("RecommendationCourse.aspx", { operate: "deleteRecommendation", id: id }, function (data) {
                if (data == "success") {
                    alert("删除成功");
                    isDelete = false;
                    window.location.href = "RecommendationCourse.aspx";
                }
                else {
                    alert(data);
                    isDelete = false;
                }
            });
        }

        function showRecommendation(id) {
            window.location.href = "RecommendationCourseList.aspx?id=" + id;
        }

        var isShow = false;
        function showNewRecommendation() {
            if (isShow) {
                $("#NewRecommendation").hide();
                isShow = false;
            }
            else {
                $("#NewRecommendation").show();
                isShow = true;
            }
        }

        var isPost = false;
        function submitNewRecommendation() {
            if (isPost) {
                alert("正在更新中，请稍后");
                return;
            }
            isPost = true;
            jQuery.post("RecommendationCourse.aspx", { operate: "new", title: document.getElementById("NewRecommendationTitle").value, description: document.getElementById("NewRecommendationDescription").value }, function (data) {
                if (data == "success") {
                    document.getElementById("NewRecommendationTitle").value = "";
                    document.getElementById("NewRecommendationDescription").value = "";
                    alert("新建成功");
                    window.location.href = "RecommendationCourse.aspx";
                }
                else {
                    alert(data);
                }
                isPost = false;
            })
        }
    </script>
</head>
<body id="Body1" runat="server">
    <div class="container_12">
        <!--#include file="Navigation.aspx" -->

        <div class="grid_10">
            <div class="box round first grid">
                <h2>
                    Recommendation List                   
                </h2>
                <br />
                 <button onclick="showNewRecommendation()" style="float:right">Add Recommendation</button>
                <br/>
                <br />
                <table id="NewRecommendation" style="float:right; display:none; z-index:100; background-color:rgb(27, 84, 141)">
                    <tr>
                        <td class="col1">
                            <label>Title</label>
                        </td>
                        <td class="col2">
                            <input type="text" id="NewRecommendationTitle" />
                        </td>
                    </tr>
                   <tr>
                       <td class="col1">
                           <label>Description</label>
                        </td>
                        <td class="col2">
                            <input type="text" id="NewRecommendationDescription" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <button onclick="submitNewRecommendation()">确认</button>
                        </td>
                    </tr>
                </table>
                <div class="block">
                    <table class="data display datatable" id="example">
                        <thead>
                            <tr>
                                <th style="text-align: center">Title</th>
                                <th style="text-align: center">Description</th>
                                <th style="text-align: center">Edit Recomendation</th>
                                <th style="text-align: center">Delete Recommendation</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                RECOMMENDATION[] recommendation = CourseAccess.GetAllRecommendations();
                                for (int i = 0; i < recommendation.Length; i++)
                                {
                             
                            %>
                            <tr ondblclick="showRecommendation('<%=recommendation[i].ID%>')">
                                <td style="text-align: center"><%=recommendation[i].TITLE %></td>
                                <td style="text-align: center"><%=recommendation[i].DESCRIPTION %></td>
                                <td style="text-align: center"><a href="javascript:editRecommendation('<%=recommendation[i].ID %>')">edit</a></td>
                                <td style="text-align: center"><a href="javascript:deleteRecommendation('<%=recommendation[i].ID %>')">delete</a></td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>

                </div>

                <!--block div是datatable用来定位的，不要在里面放出了table以外的东西-->

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
