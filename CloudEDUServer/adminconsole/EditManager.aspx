﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditManager.aspx.cs" Inherits="CloudEDUServer.adminconsole.EditManager" %>

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

    <script type="text/javascript" src="js/table/table.js"></script>
    <script src="js/setup.js" type="text/javascript"></script>
    <script src="js/MD5.js" type="text/javascript"></script>

    <script type="text/javascript">

        $(document).ready(function () {
            setupLeftMenu();
            setSidebarHeight();
            document.getElementById("type").value="<%=Session["editType"]%>" ;
            <%Session["editType"] = null;%>
        });

        var isUpdate = false;
        function addManager(permissionLength) {
            if (isUpdate) {
                alert("数据跟新中，请稍后");
                return;
            }
            isUpdate = true;

            if (confirm("确认编辑管理员吗")) {
                var account = document.getElementById("account").value;
                var password = document.getElementById("password").value;
                var confirmPassword = document.getElementById("confirmPassword").value;
                var type = document.getElementById("type").value;
                var isNewPassword = false;
                if (password != "" || confirmPassword != "") isNewPassword = true;

                if (account == "") {
                    alert("账号不能为空");
                    isUpdate = false;
                    return;
                }
                if (!checkStr(account)) {
                    alert("账号只能由大小写字母、数字、下划线组成");
                    isUpdate = false;
                    return;
                }
                if (isNewPassword && !checkStr(password)) {
                    alert("密码只能由大小写字母、数字、下划线组成");
                    isUpdate = false;
                    return;
                }
                if (isNewPassword && password != confirmPassword) {
                    alert("两次密码不一致");
                    isUpdate = false;
                    return;
                }
                else{

                    var permission = 0;
                    for (var i = 0; i < permissionLength; i++) {
                        
                        if (document.getElementById('permissionID' + i).checked) {
                            permission += 1 << i;
                        }
                    }
                    if (isNewPassword) {
                        password = hex_md5(password);
                    }
                    jQuery.post("EditManager.aspx", { account: account, password: password, permission:permission,type:type }, function (data) {
                        if (data == "success") {
                            isUpdate = false;
                            alert("管理员编辑成功");
                            window.location.href = "Default.aspx";
                            return;
                        }
                        else {
                            alert(data);
                            isUpdate = false;
                        }
                    });
                }
            }
            else {
                isUpdate = false;
            }
        }

        function checkStr(str) {
            var reg = /[^A-Za-z0-9_]/;
            if (reg.test(str)) return false;
            else return true;
        }

        function changePermission(ele) {
            if (ele.id == "permissionID2") {
                if (ele.checked == true) {
                    document.getElementById("permissionID1").checked = true;
                }
            }
            if (ele.id == "permissionID1") {
                if (ele.checked == false) {
                    document.getElementById("permissionID2").checked = false;
                    document.getElementById("permissionID3").checked = false;
                }
            }
            if (ele.id == "permissionID3") {
                if (ele.checked == true) {
                    document.getElementById("permissionID1").checked = true;
                }
            }
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
            <div class="box round first fullpage">
                <h2>
                    Edit Manager</h2>
                <div class="block ">
                    <form>
                    <table class="form">
                        <tr>
                            <td>
                                <label>账号</label>
                            </td>
                            <td>
                                <input type="text" readonly value="<%=Session["editAccount"] %>" maxlength="10" class="success" id="account"/>
                                <% Session["editAccount"] = null; %>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>密码</label>
                            </td>
                            <td>
                                <input type="password" maxlength="10"  id="password" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>确认密码</label>
                            </td>
                            <td>
                                <input type="password"  maxlength="10" id="confirmPassword" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                 <label>type</label>
                            </td>
                            <td>
                                <select id="type" name="select">
                                    <%
                                       TYPE []allType=ManagerAccess.GetAllManagerTypes();
                                       for (int i=0; i<allType.Length; i++)
                                       { 
                                    %>
                                        <option value="<%=allType[i].ID %>"><%=allType[i].DESCRIPTION %></option>
                                    <%}%>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label>权限</label>
                            </td>
                            <td>
                               <%
                                PERMISSION[] permission = ManagerAccess.GetAllPermissions();
                                PERMISSION[] managerPermision =(PERMISSION[]) Session["editPermission"];
                                int editPermisionJ=0;
                                for (int i=0; i<permission.Length; i++)
                                {
                                    if (managerPermision!=null && editPermisionJ<managerPermision.Length && managerPermision[editPermisionJ].ID == permission[i].ID)
                                    {
                                        editPermisionJ++;                                
                                %>
                                      <input type="checkbox" id="<%="permissionID"+i%>" onchange="changePermission(this)" checked="checked" /><%=permission[i].NAME %>
                                    
                                <% } 
                                   else
                                   {%>
                                      <input type="checkbox" id="<%="permissionID"+i%>"  onchange="changePermission(this)" /><%=permission[i].NAME %>
                                   <%}
                                }
                                Session["editPermission"]=null;
                                %>  
                            </td>
                        </tr>
                    </table>  
                    </form>
                    <button onclick="addManager(<%=permission.Length %>)" style="margin-left:250px;">确认</button>
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
