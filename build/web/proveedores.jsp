<%-- 
    Document   : proveedores
    Created on : 21/10/2022, 00:11:02
    Author     : Sapón Pérez
--%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="modelo.Proveedor" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Proveedores</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="style.css" rel="stylesheet">
        <link href="estilo_menu.css" rel="stylesheet" type="text/css">
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

            if (session.getAttribute("nombre") == null) {
                response.sendRedirect("index.jsp");
            }
        %>

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

        <header>
            <figure class="text-center">
                <P></P>
                <h1>PROVEEDORES</h1>
            </figure>
        </header>

        <div class="container">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal_proveedor" onclick="limpiar()">Agregar Proveedor</button>
            <p></p>

            <!-- Modal -->
            <div class="modal fade" id="modal_proveedor" tabindex="-1" aria-labelledby="modal_proveedor" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Agregar Cliente</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="sr_proveedor" method="post">
                                <label for="lbl_id">id</label>
                                <input  type="text" name="txt_id" id="txt_id" value="0" readonly class="form-control">
                                <label for="lbl_nombre_proveedor">Proveedor</label>
                                <input  type="text" name="txt_nombre_proveedor" id="txt_nombre_proveedor" class="form-control" required="">
                                <label for="lbl_nit">Nit</label>
                                <input  type="text" name="txt_nit_proveedor" id="txt_nit_proveedor" pattern="[0-9]{0,12}" title="Ingrese el nit sin guiones" class="form-control">
                                <label for="lbl_direccion">Direccion</label>
                                <input  type="text" name="txt_direccion_proveedor" id="txt_direccion_proveedor" class="form-control">
                                <label for="lbl_telefono">Telefono</label>
                                <input  type="text" name="txt_telefono_proveedor" id="txt_telefono_proveedor" pattern="[0-9]{8}" class="form-control">   

                                <div class="modal-footer">
                                    <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary">Agregar</button>
                                    <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success">Modificar</button>
                                    <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-danger">Eliminar</button>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>

            <!-- Empieza la tabla -->
            <table border="1" class="table table-striped">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Nombre</th>
                        <th>Nit</th>
                        <th>Direccion</th>
                        <th>Telefono</th>
                    </tr>
                </thead>
                <tbody id="tbl_clientes">
                    <%
                        Proveedor proveedor = new Proveedor();
                        DefaultTableModel tabla = new DefaultTableModel();
                        tabla = proveedor.leer();
                        for (int t = 0; t < tabla.getRowCount(); t++) {
                            out.println("<tr>");
                            out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 4) + "</td>");
                            out.println("</tr>");
                        }
                    %>

                </tbody>
            </table>

            <footer class="text-center text-white fixed-bottom" style="background-color: #BFBFBF;"> 

                <div class="text-center p-3">
                    © 2022 Copyright:
                    <a class="text-white" href="https://okdiario.com/img/2022/01/21/5-rasgos-que-definen-la-personalidad-de-los-gatos.jpg" target="_blank">Grupo 3</a>
                </div>
            </footer>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <script type="text/javascript">
                function limpiar() {
                    $("#txt_id").val(0);
                    $("#txt_nombre_proveedor").val('');
                    $("#txt_nit_proveedor").val('');
                    $("#txt_direccion_proveedor").val('');
                    $("#txt_telefono_proveedor").val('');
                }
                var table = document.getElementById('tbl_clientes');

                for (var i = 0; i < table.rows.length; i++)
                {
                    table.rows[i].onclick = function ()
                    {
                        //rIndex = this.rowIndex;
                        document.getElementById("txt_id").value = this.cells[0].innerHTML;
                        document.getElementById("txt_nombre_proveedor").value = this.cells[1].innerHTML;
                        document.getElementById("txt_nit_proveedor").value = this.cells[2].innerHTML;
                        document.getElementById("txt_direccion_proveedor").value = this.cells[3].innerHTML;
                        document.getElementById("txt_telefono_proveedor").value = this.cells[4].innerHTML;
                        $("#modal_proveedor").modal('show');
                    };
                }
        </script>
        <footer class="text-center text-light fixed-bottom" style="background-color:#7ACBEB;">
            <div class="text-center p-3">
                © 2022 Copyright:
                <a class="text-white" href="https://okdiario.com/img/2022/01/21/5-rasgos-que-definen-la-personalidad-de-los-gatos.jpg" target="_blank">Grupo 3</a>
            </div>   
        </footer>
    </body>



</html>
