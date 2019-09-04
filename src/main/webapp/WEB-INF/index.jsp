
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>首页</title>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript">
        var username=document.cookie;
        function getCookie(name){
            var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
            if(arr=document.cookie.match(reg)){
                return arr[2];
            }else{
                return null;
            }
        }

        $(document).ready(function(){
            if(getCookie("username")!=null){
                $("#welcome").html("欢迎你,"+decodeURI(getCookie("username"),"utf-8"));
            }else{
                $("#welcome").html("<a href='tologin'>请先登录</a>");
            }
        });
    </script>
</head>
<body>
<p id="welcome"></p>
</body>
</html>
