<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="cloudEdu.Login" %>

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
       <link rel="stylesheet" type="text/css" href="css/Login.css" media="screen" />
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
    <script src="js/setup.js" type="text/javascript"></script>
    <script language="javascript" src="js/MD5.js" type="text/javascript"></script>
    <script type="text/javascript">

        var isLogining = false;
        function login() {
            if (isLogining) {
                alert("正在登陆中，请稍后");
                return;
            }
            isLogining = true;
            var account = document.getElementById('account').value;
            var password = document.getElementById('password').value;
            if (account == "") {
                alert("账号不能为空");
                return;
            }
            if (password == "") {
                alert('密码不能为空');
                return;
            }
            password = hex_md5(password);

            jQuery.post("login.aspx/login", { account: account, password: password }, function (data) {
                if (data == "success") {
                    window.location.href = "Default.aspx";
                }
                else alert(data);
                isLogining = false;
            });

        }
    </script>
</head>
<body id="Body1" runat="server" style="height:100%; width:100%; margin:0 0 0 0">
    <form id="form1" runat="server" style="height:100%">
    <div class="container_12">
        <div class="grid_12 header-repeat">
            <div id="branding">
                <div class="floatleft">
                    <img src="img/logo.png" alt="Logo" /></div>
                <div class="clear">
                </div>
            </div>
        </div>
        <div class="clear">
        </div>
        <div style="width:200px; margin-left:auto; margin-right:auto; margin-top:200px">
            <input type="text" id="account" class="loginText" placeholder="account" class="LoginSpan"/> <br /><br />
            <input type="password" id="password" class="loginText" placeholder="password" /> <br /><br />
            <input type="button" value="登陆" onclick="login()"/><br />
        </div>
        <div style="height:200px"></div>
    </div>
    <div class="clear">
    </div>
    <div id="site_info">
        <p>
            Copyright <a href="#">BlueWhale Admin</a>. All Rights Reserved.
        </p>
    </div>
    </form>
</body>
</html>
