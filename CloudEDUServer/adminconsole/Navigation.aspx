<%@ Import Namespace="CloudEDUServer" %>

<body>
    <%
       if (Session["manager"] == null)
       {
           Response.Redirect("Login.aspx"); 
       }
    %>
        <div class="grid_12 header-repeat">
            <div id="branding">
                <div class="floatleft">
                    <img src="img/logo.png" alt="Logo" /></div>
                <div class="floatright">
                    <div class="floatleft">
                      <p><%=((MANAGER)Session["manager"]).NAME%></p>
                       
                    </div>
                    <div class="floatleft marginleft10">
                        <ul class="inline-ul floatleft">
                            <li><a href="#">Config</a></li>
                            <li style="margin-left:10px"><a href="Logout.aspx">Logout</a></li>
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
                <li class="ic-dashboard"><a href="Default.aspx"><span>Dashboard</span></a> </li>
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
                                <li><a href="ManagerList.aspx">Manager list</a> </li>
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
</body>    
