package com.workhub;

import org.apache.catalina.Context;
import org.apache.catalina.webresources.StandardRoot;
import org.apache.catalina.startup.Tomcat;

import java.io.File;

public class EmbeddedTomcatLauncher {
    public static void main(String[] args) throws Exception {
        int port = 8080;
        String portText = System.getProperty("server.port");
        if (portText != null && !portText.trim().isEmpty()) {
            port = Integer.parseInt(portText);
        }

        String baseDir = new File(".").getAbsolutePath();
        String webappDir = new File("src/main/webapp").getAbsolutePath();
        String classesDir = new File("target/classes").getAbsolutePath();

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(port);
        tomcat.setBaseDir(new File("target/tomcat").getAbsolutePath());
        tomcat.getConnector();

        Context context = tomcat.addWebapp("", webappDir);
        context.setParentClassLoader(EmbeddedTomcatLauncher.class.getClassLoader());
        context.setResources(new StandardRoot(context));
        context.setReloadable(false);

        File classes = new File(classesDir);
        if (classes.exists()) {
            context.getResources().createWebResourceSet(
                    org.apache.catalina.WebResourceRoot.ResourceSetType.POST,
                    "/WEB-INF/classes",
                    classes.getAbsolutePath(),
                    null,
                    "/"
            );
        }

        tomcat.start();
        System.out.println("Smart Office started: http://localhost:" + port + "/login.jsp");
        tomcat.getServer().await();
    }
}
