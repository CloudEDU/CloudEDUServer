﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddManager.aspx.cs" Inherits="CloudEDUServer.adminconsole.AddManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
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
            setSidebarHeight();
        });

        var isUpdate = false;
        function addManager() {
            if (isUpdate) {
                alert("数据跟新中，请稍后");
                return ;
            }
            isUpdate = true;

            if (confirm("确认添加新的管理员吗")) {
                var account = document.getElementById("account").value;
                var password = document.getElementById("password").value;
                var confirmPassword = document.getElementById("confirmPassword").value;
                if (account == "") {
                    alert("账号不能为空");
                    isUpdate = false;
                    return;
                }
                if (password == "") {
                    alert("密码不能为空");
                    isUpdate = false;
                    return;
                }
                if (!checkStr(account)) {
                    alert("账号只能由大小写字母、数字、下划线组成");
                    isUpdate = false;
                    return;
                }
                if (!checkStr(password)) {
                    alert("密码只能由大小写字母、数字、下划线组成");
                    isUpdate = false;
                    return;
                }
                if (password == confirmPassword) {
                    password = hex_md5(password);
                    jQuery.post("AddManager.aspx", { account: account, password: password }, function (data) {
                        if (data == "success") {
                            isUpdate = false;
                            alert("新的管理员添加成功");
                            window.location.href = "Default.aspx";
                            return;
                        }
                        else {
                            alert(data);
                            isUpdata = false;
                        }
                    });
                }
                else {
                    alert("两次密码不一致");
                    isUpdate = false;
                    return;
                }
            }
            else {
                isUpdate = false;
            }
        }

        function checkStr(str){
            var reg = /[^A-Za-z0-9_]/;
            if (reg.test(str)) return false;
            else return true;
        }
        
   </script>
</head>
<body class="Body1" runat="server">
   <div class="container_12">
        <!--#include file="Navigation.aspx" -->
        <div class="grid_10">
            <div class="box round first fullpage">
                <h2>
                    Form Controls</h2>
                <div class="block ">
                    <form>
                    <table class="form">
                        <tr>
                            <td>
                                <label>账号</label>
                            </td>
                            <td>
                                <input type="text"  maxlength="10" class="success" id="account"/>
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
                                <label>权限</label>
                            </td>
                            <td>
                                <select id="select" name="select">
                                    <option value="1">Value 1</option>
                                    <option value="2">Value 2</option>
                                    <option value="3">Value 3</option>
                                </select>
                            </td>
                        </tr>
                    </table>  
                    </form>
                    <button onclick="addManager()" style="margin-left:250px;">确认</button>
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
</body>
</html>
