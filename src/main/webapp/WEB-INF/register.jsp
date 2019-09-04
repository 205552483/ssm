<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/9/3
  Time: 14:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>注册</title>
    <style type="text/css">
        a:link {
            font-size: 16px;
            color: #000000;
            text-decoration: none;
        }
        a:visited {
            font-size: 16px;
            color: #000000;
            text-decoration: none;
        }
        a:hover {
            font-size: 16px;
            color: #999999;
            text-decoration: underline;
        }
    </style>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript">
        function checkUsername(){
            var username= $("#username").val();
            $.ajax({
                type:"post",
                url:"checkUsername",
                data:{"username":username},
                dataType:"json",
                success:function(data){
                    if( data==1){
                        $("#usererror").html("用户名已存在");
                        return false;
                    }else{
                        return true;
                    }
                }
            });
            if($("#username").val().length<5||$("#username").val().length>10){
                $("#usererror").html("用户名长度为5-10位");
                return false;
            }else{
                $("#usererror").html("");
                return true;
            }
        }
        function checkPassword(){
            if($("#password").val().length<5||$("#password").val().length>10){
                $("#passworderror").html("密码长度为5-10位");
                return false;
            }else{
                $("#passworderror").html("");
                return true;
            }
        }
        function checkRePassword(){
            if($("#password").val()!=$("#repassword").val()){
                $("#repassworderror").html("两次输入密码不一致");
                return false;
            }else{
                $("#repassworderror").html("");
                return true;
            }
        }

        function register(){
            if(checkUsername()+checkPassword()+checkRePassword()!=3){
                console.log("1:"+checkUsername());
                console.log("2:"+checkPassword());
                console.log("3:"+checkRePassword());
                alert("请确认填写信息正确");
                return;
            }
            var username = $("#username").val();
            var password = $("#password").val();
            var repassword = $("#repassword").val();
            $.ajax({
                type:"post",
                url:"register",
                data:{"username":username,"password":password},
                dataType:"json",
                success:function(data){
                    if(data==1){
                        $("#message").html("正在跳转到登录页面...");
                        setTimeout("window.location.href='tologin'",3000);
                    }
                }
            });
        }
    </script>
</head>
<body>
<p>
    用户：<input type="text" id="username" onBlur="checkUsername();"/>
    <span id="usererror" style="color: red;"></span>
</p>
<p>
    密码：<input type="password" id="password" onBlur="checkPassword();"/>
    <span id="passworderror" style="color: red;"></span>
</p>
<p>
    确认密码：<input type="password" id="repassword" onBlur="checkRePassword();"/>
    <span id="repassworderror" style="color: red;"></span>
</p>
<button onclick="register();">注册</button>
<a href="tologin">有账号，直接登录</a>
<p id="message"></p>
</body>
</html>
