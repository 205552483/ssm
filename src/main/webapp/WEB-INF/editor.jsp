
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>ueditor-demo</title>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="Ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="Ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" src="Ueditor/lang/zh-cn/zh-cn.js"></script>
    <style>
        #submit {
            width: 100px;
            height: 30px;
            line-height: 30px;
            font-size: 16px   ;
        }
    </style>
</head>
<body>
<h2>ueditor测试使用</h2>
<script id="editor" type="text/plain"></script>
<div style="margin-top: 20px; text-align: center;">
    <input type="button" class="btn btn-blue w-100" value="提 交" id="submit">
</div>
<script>
    $(function(){
        //实例化编辑器
        var ue = UE.getEditor('editor',{
            initialFrameWidth:"250%",   //初始化宽度
            initialFrameHeight:400,     //初始化高度
        })

        $('#submit').click(function () {
            //获取ueditor编辑框中的html文本内容
            var content = UE.getEditor('editor').getContent();
            $.ajax({
                url: 'http://172.0.0.1:8081/ssm_project/news/addNews',
                type: 'Post',
                data: {
                    content: content,
                },
                dataType: 'json',
                success: function (res) {
                    console.log(res);
                },
                error: function () {
                    console.log(res);
                }
            })
        })
    })

</script>
</body>
</html>
