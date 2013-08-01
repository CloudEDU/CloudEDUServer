<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="CloudEDUServer.adminconsole.UserList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
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
            $('.datatable').dataTable({
                "sPaginationType": "full_numbers"
            });
            setupLeftMenu();
            setSidebarHeight();
        });

        function editUser(id) {
            window.location.href = "EditUser.aspx?id=" + id;
        }

        function showUserComment(userId) {
            jQuery.post("CourseComment.aspx", { user: userId }, function () {
                window.location.href = "CourseComment.aspx";
            });
        }

        function changeUserState(ele) {
            jQuery.post("UserList.aspx", { userId: ele.name, userState: ele.value }, function (data) {
            });
        }

        function showUserNote(userId) {
            window.location.href = "UserNote.aspx?userId="+userId;
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
							<th style="text-align:center">Name</th>
							<th style="text-align:center">Balance</th>
							<th style="text-align:center">Email</th>
                            <th style="text-align:center">Degree</th>
                            <th style="text-align:center">Learn Rate</th>
                            <th style="text-align:center">Teach Rate</th>
                            <th style="text-align:center">Birthday</th>
                            <th style="text-align:center">Comment</th>
                             <th style="text-align:center">note</th>
                            <th style="text-align:center">Allow</th>                          
						</tr>
					</thead>
					<tbody>
                        <%
                            CUSTOMER[] user=CustomerAccess.GetAllCustomers();
                            for (int i=0; i<user.Length; i++)
                            {
                                if (ManagerAccess.haveUserPermission((MANAGER)Session["manager"]))
                                { 
                         %>
                            
						    <tr ondblclick="editUser(<%=user[i].ID %>)">
                               <%}
                                    else
                                    {%>
                                <tr>
                                 <%} %>
							    <td style="text-align:center"><%=user[i].NAME %></td>
							    <td style="text-align:center"><%=user[i].BALANCE.ToString().Substring(0,user[i].BALANCE.ToString().Length-2) %></td>
							    <td style="text-align:center"><%=user[i].EMAIL %></td>	
                                <td style="text-align:center; text-transform:capitalize"><%=user[i].DEGREE %></td>						    
							    <td style="text-align:center"><%=user[i].LEARN_RATE %></td>
                                <td style="text-align:center"><%=user[i].TEACH_RATE %></td>
                                <td style="text-align:center"><%=user[i].BIRTHDAY.ToShortDateString() %></td>
                                <td style="text-align:center"><a href="javascript:showUserComment('<%=user[i].ID %>')">评论</a></td>
                                 <td style="text-align:center"><a href="javascript:showUserNote('<%=user[i].ID %>')">笔记</a></td>
                                <td style="text-align:center">
                                     <%
                                        if (user[i].ALLOW)
                                        {
                                    %>
                                            <input type="radio" name="<%=user[i].ID %>" checked="checked" value="YES" onchange="changeUserState(this)" />YES
                                            <input type="radio" name="<%=user[i].ID %>" value="NO" onchange="changeUserState(this)" />NO
                                  
                                    <%         
                                        }
                                        else
                                        {
                                    %>
                                            <input type="radio" name="<%=user[i].ID %>" value="YES" onchange="changeUserState(this)" />YES
                                            <input type="radio" name="<%=user[i].ID %>" value="NO" checked="checked" onchange="changeUserState(this)" />NO
                                    <%  }   %>
                                </td>
                               
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
