<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TransactionList.aspx.cs" Inherits="CloudEDUServer.adminconsole.TransactionList" %>

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
            setupLeftMenu();
            $('.datatable').dataTable({
                "sPaginationType": "full_numbers"
            });
            setSidebarHeight();
        });

        function searchDay() {
            window.location.href = "TransactionList.aspx?from=" + document.getElementById("from").value + "&to=" + document.getElementById("to").value;
        }
    </script>

</head>
<body id="Body1" runat="server">
    <div class="container_12">    
        <!--#include file="Navigation.aspx" -->
       <%
            if (!ManagerAccess.haveTransactionPermission ((MANAGER)Session["manager"]))
            {
                Response.Redirect("Default.aspx");
                Response.End();
            }
        %>
        <div class="grid_10">
            <div class="box round first grid">
                <h2>Transaction List
                </h2>
                     <div style="float:right">
                        From<input type="date" id="from"/>
                        To<input type="date" id="to" /><br />
                        <button onclick="searchDay()">搜索</button>
                    </div>
                <div class="block">
                    
					<table class="data display datatable">
					<thead>
						<tr>
							<th style="text-align:center">Id</th>
							<th style="text-align:center">Buyer</th>
							<th style="text-align:center">Saler</th>
                            <th style="text-align:center">Course</th>
                            <th style="text-align:center">Price</th>
                            <th style="text-align:center">Time</th>
						</tr>
					</thead>
					<tbody>
                        <%
                            SALEORDER[] saleorder=null;
                            try
                            {
                                DateTime from = DateTime.Parse(Request.Params.Get("from"));
                                DateTime to = DateTime.Parse(Request.Params.Get("to"));
                                saleorder= TransactionAccess.GetOrderByDateBetween(from, to);
                            }
                            catch
                            {
                                saleorder = TransactionAccess.GetAllSaleOrder();
                            }
                            for (int i=0; i<saleorder.Length; i++)
                            {
                         %>
						    <tr>
							    <td style="text-align:center"><%=saleorder[i].ID %></td>
							    <td style="text-align:center"><%=CustomerAccess.GetCustomerByID(saleorder[i].BUYER).NAME %></td>
							    <td style="text-align:center"><%=CustomerAccess.GetCustomerByID(saleorder[i].SALER).NAME %></td>	
                                <td style="text-align:center"><%=CourseAccess.GetCourseById(saleorder[i].COURSE).TITLE %></td>	
                                <td style="text-align:center"><%=CourseAccess.GetCourseById(saleorder[i].COURSE).PRICE %></td>					    
							    <td style="text-align:center"><%=saleorder[i].TIME %></td>
						    </tr>	
                        <% }%>
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

