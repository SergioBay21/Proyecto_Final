<%-- 
    Document   : marcas
    Created on : 24/10/2022, 17:48:11
    Author     : Sapón Pérez
--%>
<%@page import="modelo.Marca" %>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Marcas</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
        <link href="style.css" rel="stylesheet">
        <link href="estilo_menu.css" rel="stylesheet" type="text/css">
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

            if (session.getAttribute("nombre") == null) {
                response.sendRedirect("index.jsp");
            }
        %>
    </head>
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
    <body>
        <header>
            <figure class="text-center">
                <P></P>
                <h1>MARCAS</h1>
            </figure>
        </header>
        <div class="container">
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal_marca" onclick="limpiar()">Nuevo</button>
            <button type="button" name="btn_productos" id="btn_productos"  onclick="location.href = 'productos.jsp';" class="btn btn-primary">Productos</button> 
            <p></p>
            <!-- modal -->   
            <div class="modal" id="modal_marca">
                <div class="modal-dialog">
                    <div class="modal-content">

                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h4 class="modal-title">Formulario Producto</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>

                        <!-- Modal body -->
                        <div class="modal-body">   
                            <form action="sr_marca" method="post" class="form-group">
                                <label for="lbl_id"><b>ID:</b></label>
                                <input type="text" name="txt_id" id="txt_id" class="form-control" value="0" readonly>
                                <label for="lbl_marca"><b>Marca:</b></label>
                                <input type="text" name="txt_marca" id="txt_marca" class="form-control" placeholder="Ejemplo TOSHIBA" required>

                                <br>
                                <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary">Guardar</button>
                                <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success">Modificar</button>
                                <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-danger" onclick="javascript:if (!confirm('¿Desea Eliminar?'))
                                            return false">Eliminar</button>
                                <button type="button" class="btn btn-warning" data-dismiss="modal">Cerrar</button>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Marca</th>

                    </tr>
                </thead>
                <tbody id="tbl_marca">
                    <%
                        Marca obj_marca = new Marca();;
                        DefaultTableModel tabla = new DefaultTableModel();
                        tabla = obj_marca.leer();
                        for (int t = 0; t < tabla.getRowCount(); t++) {
                            out.println("<tr data-id=" + tabla.getValueAt(t, 0) + ">");
                            out.println("<td>" + (t + 1) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                            out.println("</tr>");
                        }
                    %>

                </tbody>
            </table>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
        <script type="text/javascript">
                                    function limpiar() {
                                        $("#txt_id").val(0);
                                        $("#txt_marca").val('');

                                    }

                                    $('#tbl_marca').on('click', 'tr td', function (evt) {
                                        var target, id, marca;
                                        target = $(event.target);
                                        id = target.parent().data('id');
                                        marca = target.parent("tr").find("td").eq(1).html();
                                        $("#txt_id").val(id);
                                        $("#txt_marca").val(marca);
                                        $("#modal_marca").modal('show');
                                    });
        </script>
        <footer class="text-center text-light fixed-bottom" style="background-color:#7ACBEB;">
            <div class="text-center p-3">
                © 2022 Copyright:
                <a class="text-white" href="https://okdiario.com/img/2022/01/21/5-rasgos-que-definen-la-personalidad-de-los-gatos.jpg" target="_blank">Grupo 3</a>
            </div>   
        </footer>
    </body>


</html>
