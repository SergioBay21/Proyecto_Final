<%-- 
    Document   : reportes
    Created on : 5/11/2022, 04:43:39 PM
    Author     : sergi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reportes</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="estilo_menu.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div>
            <form action="sr_cerrar_sesion">
                <input type=image src="recursos/cerrar.png" width="35" height="35" style="margin-right: 50px; margin-top: 20px" align="right">
            </form>
                <img src="recursos/despensafelizlogo.png" alt="logo">
            <nav id="header">
                <ul class="nav">
                    <li><a href="productos.jsp">Productos</a>
                        <ul>
                            <li><a href="marcas.jsp">Marcas</a></li>
                        </ul>
                    </li>
                    <li><a href="ventas.jsp">Ventas</a>
                        <ul>
                            <li><a href="clientes.jsp">Clientes</a></li>
                            <li><a href="empleados.jsp">Empleados</a>
                                <ul>
                                    <li><a href="puestos.jsp">Puestos</a></li>
                                </ul>
                            </li>
                        </ul>
                    <li><a href="compras.jsp">Compras</a>
                        <ul>
                            <li><a href="proveedores.jsp">Proveedores</a></li>
                        </ul>
                    </li>
                    <li><a href="reportes.jsp">Reportes</a></li>
                </ul>
            </nav>
        </div>
        <a href="reporte_ventas.jsp">Reporte Ventas</a><br>
        <p></p>
        <a href="reporte_clientes.jsp">Reporte Clientes</a><br>
        <p></p>
        <a href="reporte_empleados.jsp">Reporte Empleados</a><br>
        <p></p>
        <a href="reporte_productos.jsp">Reporte Productos</a><br>
        <p></p>
        <a href="reporte_proveedores.jsp">Reporte Proveedores</a><br>
        <script src="https://code.jquery.com/jquery-3.6.1.slim.js" integrity="sha256-tXm+sa1uzsbFnbXt8GJqsgi2Tw+m4BLGDof6eUPjbtk=" crossorigin="anonymous"></script>           
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>


        <footer class="text-center text-light fixed-bottom" style="background-color:#7ACBEB;">
            <div class="text-center p-3">
                © 2022 Copyright:
                <a class="text-white" href="https://okdiario.com/img/2022/01/21/5-rasgos-que-definen-la-personalidad-de-los-gatos.jpg" target="_blank">Grupo 3</a>
            </div>   
        </footer>
    </body>
</html>
