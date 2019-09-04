
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>登录</title>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript">
        function login(){
            var username = $("#username").val();
            var password = $("#password").val();
            console.log(username);
            console.log(password);
            if(username==""){
                alert("用户名不可为空");
                return;
            }
            if(password==""){
                alert("密码不可为空");
                return;
            }
            $.ajax({
                type:"post",
                url:"login",
                data: {"username":username,"password":password},
                dataType:"json",
                success:function(data){
                    console.log(data);
                    if(data==1){
                        window.location.href="toIndex";
                    }else if(data==2){
                        alert("用户或密码不正确");
                    }
                }
            });
        }

        function register(){
            window.location.href="toRegister";
        }
    </script>
</head>
<body>
<p>
    用户：<input type="text" id="username">
</p>
<p>
    密码：<input type="password" id="password">
</p>
<p>
    <button onclick="login();">登录</button>
    <button onclick="register();">注册</button>
</p>
</body>
</html>
