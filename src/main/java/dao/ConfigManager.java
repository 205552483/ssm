package dao;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.*;

public final class ConfigManager {

    private final String rootPath;
    private final String originalPath;
    private final String contextPath;
    /**
     * 存放备注文件
     **/
    private static final String configFileName = "config.json";
    private String parentPath = null;
    private JSONObject jsonConfig = null;
    // 涂鸦上传filename定义
    private final static String SCRAWL_FILE_NAME = "scrawl";
    // 远程图片抓取filename定义
    private final static String REMOTE_FILE_NAME = "remote";

    /*
     * 通过一个给定的路径构建一个配置管理器， 该管理器要求地址路径所在目录下必须存在config.properties文件
     */
    private ConfigManager(String rootPath, String contextPath, String uri) throws FileNotFoundException, IOException {

        rootPath = rootPath.replace("\\", "/");
        //下面的rootPath就是我的根路径
        // rootPath=D:/workspace_de_client/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/Test/
        this.rootPath = rootPath;
        this.contextPath = contextPath;
        //请求路径 url = /Test/jsp/controller.jsp
        if (contextPath.length() > 0) {
            // D:/workspace_de_client/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/Test//jsp/controller.jsp
            this.originalPath = this.rootPath + uri.substring(contextPath.length());
        } else {
            this.originalPath = this.rootPath + uri;
        }
        /** 调用当前类的初始化环境方法 initEnv **/
        this.initEnv();

    }

//上面的方法无法就是获得controller.jsp这个类所在的真实目录而已


//下面看看initEnv（）这个方法

    private void initEnv() throws FileNotFoundException, IOException {
        /**  **/
        File file = new File(this.originalPath);

        if (!file.isAbsolute()) {
            file = new File(file.getAbsolutePath());
        }
        /** 获得文件的父路径，也就是  ..../jsp **/
        this.parentPath = file.getParent();
        /** 读取配置文件，这个方法比较重要，往下看 **/
        String configContent = this.readFile(this.getConfigPath());

        try {
            /** 把返回的的json字符串扔进JsonObject对象中 **/
            JSONObject jsonConfig = new JSONObject(configContent);
            this.jsonConfig = jsonConfig;
        } catch (Exception e) {
            this.jsonConfig = null;
        }

    }

    /**
     * 获得配置路径，记住config.json是和controller.jsp放在同一个目录下的，很坑有木有
     **/
    private String getConfigPath() {
        /** 拼凑config.json的真实路径 **/
        return this.parentPath + File.separator + ConfigManager.configFileName;
    }

    private String[] getArray(String key) {

        JSONArray jsonArray = this.jsonConfig.getJSONArray(key);
        String[] result = new String[jsonArray.length()];

        for (int i = 0, len = jsonArray.length(); i < len; i++) {
            result[i] = jsonArray.getString(i);
        }

        return result;

    }

    /**
     * 获得配置文件的内容，变成字符串返回
     **/
    private String readFile(String path) throws IOException {

        StringBuilder builder = new StringBuilder();

        try {

            InputStreamReader reader = new InputStreamReader(new FileInputStream(path), "UTF-8");
            BufferedReader bfReader = new BufferedReader(reader);

            String tmpContent = null;

            while ((tmpContent = bfReader.readLine()) != null) {
                builder.append(tmpContent);
            }

            bfReader.close();

        } catch (UnsupportedEncodingException e) {
            // 忽略
        }
        //过滤输入字符串, 剔除多行注释以及替换掉反斜杠
        return this.filter(builder.toString());

    }

    // 过滤输入字符串, 剔除多行注释以及替换掉反斜杠
    private String filter(String input) {

        return input.replaceAll("/\\*[\\s\\S]*?\\*/", "");
    }
}