<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewPermissionManagers.aspx.cs" Inherits="CloudEDUServer.adminconsole.ViewPermissionManagers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>

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
    <script language="javascript" src="js/MD5.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            setupLeftMenu();
            $('.datatable').dataTable({
                "sPaginationType": "full_numbers"
            });
            setSidebarHeight();
        });

        var isOperating = false;
        function deleteManager(account) {
            if (isOperating) {
                alert("操作中，请稍后");
                return;
            }
            isOperating = true;
            if (confirm("确认删除该管理员吗")) {
                $.post("ManagerList.aspx", { operate: "delete", account: account }, function (data) {
                    if (data == "success") {
                        alert("删除成功");
                        isOperating = false;
                        window.location.href = "ManagerList.aspx";
                    }
                    else {
                        alert(data);
                        isOperating = false;
                    }
                });
            }
            else {
                isOperating = false;
            }
        }
        function editManager(account) {
            if (isOperating) {
                alert("操作中，请稍后");
                return;
            }
            isOperating = true;
    
            $.post("ManagerList.aspx", { operate: "edit", account: account }, function (data) {
                if (data == "success") {
                    window.location.href = "EditManager.aspx";
                }
                else {
                    alert(data);
                }
                isOperating = false;
            });
        }

    </script>
</head>
<body id="Body1" class="Body1" runat="server">
    <div class="container_12">
        <!--#include file="Navigation.aspx" -->
        <%
            if (!ManagerAccess.haveManagerPermission((MANAGER)Session["manager"]))
            {
                Response.Redirect("Default.aspx");
                Response.End();
            }
        %>
        <div class="grid_10">
            <div class="box round first grid">
                <h2>Manager List
                </h2>
                <div class="block">
                    <table class="data display datatable">
                        <thead>
                            <tr>
                                <th style="text-align: center">Name</th>
                                <th style="text-align: center">Permission</th>
                                <th style="text-align: center">Type</th>
                                <th style="text-align: center"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                PERMISSION[] permission_name = (PERMISSION[])Session["permission_name"];
                                MANAGER[] manager = ManagerAccess.GetManagersByPermissions(permission_name);
                                for (int i = 0; i < manager.Length; i++)
                                {
                             
                            %>
                            <tr ondblclick="editManager('<%=manager[i].NAME%>')">
                                <td style="text-align: center"><%=manager[i].NAME%></td>
                                <td style="text-align: center"><%=ManagerAccess.getPermissionStringByManager(manager[i])%></td>
                                <td style="text-align: center"><%=ManagerAccess.GetTypeByID((int)manager[i].MNGR_TYPE).DESCRIPTION%></td>
                                <td style="text-align: center"><a href="javascript:deleteManager('<%=manager[i].NAME%>')">删除</a></td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                </div>
                <ul style="margin-left: 800px;">
                    <li><a href="AddManager.aspx">添加管理员</a></li>
                </ul>
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
