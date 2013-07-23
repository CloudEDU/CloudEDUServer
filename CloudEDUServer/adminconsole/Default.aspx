<%@ Page Title="主页" Language="C#" MasterPageFile="Site.master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="cloudEdu.Login" %>

<%@ Import Namespace="CloudEDUServer" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>Dashboard | BlueWhale Admin</title>
    <link rel="stylesheet" type="text/css" href="css/reset.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/text.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/grid.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/layout.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="css/nav.css" media="screen" />
    <link rel="Stylesheet" type="text/css" href="css/Default.css" media="screen" />
    <!--[if IE 6]><link rel="stylesheet" type="text/css" href="css/ie6.css" media="screen" /><![endif]-->
    <!--[if IE 7]><link rel="stylesheet" type="text/css" href="css/ie.css" media="screen" /><![endif]-->
    <!-- BEGIN: load jquery -->
    <script src="js/jquery-1.6.4.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/jquery-ui/jquery.ui.core.min.js"></script>
    <script src="js/jquery-ui/jquery.ui.widget.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.ui.accordion.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.core.min.js" type="text/javascript"></script>
    <script src="js/jquery-ui/jquery.effects.slide.min.js" type="text/javascript"></script>
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

    <script src="js/setup.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            setupDashboardChart('chart1');
            setupLeftMenu();
            setSidebarHeight();
        });
    </script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
     <div class="container_12">
        <div class="grid_12 header-repeat">
            <div id="branding">
                <div class="floatleft">
                    <img src="img/logo.png" alt="Logo" /></div>
                <div class="floatright">
                    <div class="floatleft">
                        <%
                            MANAGER manager = new MANAGER();
                            manager.NAME = "test11";
                            manager.PASSWORD = "asdf";
                            manager.MNGR_TYPE = 1;
                            ManagerAccess.AddManager(manager);
                             %>>
                    </div>
                    <div class="floatleft marginleft10">
                        <ul class="inline-ul floatleft">
                            <li><a href="#">Config</a></li>
     
                        </ul>
                        <br />
                        <span class="small grey">Last Login: 3 hours ago</span>
                    </div>
                </div>
                <div class="clear">
                </div>
            </div>
        </div>
        <div class="clear">
        </div>
        <div class="grid_12">
            <ul class="nav">
                <li class="ic-dashboard"><a href="default.aspx"><span>Dashboard</span></a> </li>

            </ul>
        </div>
        <div class="clear">
        </div>
        <div class="grid_2">
            <div class="box sidemenu">
                <div class="block" id="section-menu">
                    <ul class="section menu">
                        <li><a class="menuitem">User Management</a>
                            <ul class="submenu">
                                <li><a href="userlist.aspx">User List</a> </li>
                                <li><a href="userloginstatus.html">User Login Status</a> </li>
                                <li><a href="userlevel.html">User Level</a></li>
                            </ul>
                        </li>
                        <li><a class="menuitem">Courstore Management</a>
                            <ul class="submenu">
                                <li><a href="courselist.html">Course List</a> </li>
                                <li><a href="courseinformation.html">Course Information</a> </li>
                                <li><a href="coursecommentmanage.html">Comment Management</a> </li>
                            </ul>
                        </li>
                        <li><a class="menuitem">Manager Management</a>
                            <ul class="submenu">
                                <li><a href="managerlist.html">Manager list</a> </li>
                                <li><a href="dblog.html">DB Log</a> </li>
                            </ul>
                        </li>
                        <li><a class="menuitem">Transaction Management</a>
                            <ul class="submenu">
                                <li><a href="transactionlist.html">Transaction List</a> </li>
                                <li><a href="trancactionquery.html">Transaction Query</a> </li>
                    
                            </ul>
                        </li>
                    </ul>
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
            Copyright <a href="#">BlueWhale Admin</a>. All Rights Reserved.
        </p>
    </div>
</asp:Content>
