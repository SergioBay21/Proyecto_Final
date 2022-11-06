<%-- 
    Document   : reporte_empleados
    Created on : 5/11/2022, 06:24:27 PM
    Author     : sergi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import='java.util.*'%>
<%@page import='java.sql.*'%>
<%@page import="java.io.File"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
                <%
            Connection cn;
                Class.forName("com.mysql.jdbc.Driver");
                cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_final","usr_final","Final_2002");
            
            File jasperFile = new File(application.getRealPath("reportes/reporte_empleado.jasper"));
            Map parameters = new HashMap();

            parameters.put("id", 4);

            byte[] bytes = JasperRunManager.runReportToPdf(jasperFile.getPath(),parameters,cn);
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outputStream = response.getOutputStream();
            outputStream.write(bytes, 0, bytes.length);
            outputStream.flush();
            outputStream.close();
        %>
    </body>
</html>
