<%-- 
    Document   : puestos
    Created on : 12/10/2022, 00:40:16
    Author     : Sapón Pérez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import='modelo.Puesto' %>
<%@page import='javax.swing.table.DefaultTableModel' %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Puestos</title>      
        <meta name="viewport" content="width=device-width, initial-scale=1">
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
                <h1>PUESTOS</h1>
            </figure>
        </header>
        <br>    
        <div class="modal fade" id="modalPuestos" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body">
                        <div>
                            <form action="sr_puesto" method="post" class="form-group">
                                <label for="lbl_id"><b>ID</b></label>
                                <input type="text" name="txt_id" id="txt_id" class="form-control" readonly="" value="0">

                                <label for="lbl_nom"><b>Puesto</b></label>
                                <input type="text" name="txt_puesto" id="txt_puesto" class="form-control" placeholder="Ejemplo: Administrador" required>

                                <br><button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary">Agregar</button>
                                <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success">Modificar</button>
                                <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-danger" onclick="javascript:if (!confirm('¿Desea Eliminar?'))
                                            return false" >Eliminar</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- empieza el body -->

        <div class="container mt-3">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalPuestos" onclick="cls()">Agregar</button>
            <button type="button" name="btn_empleados" id="btn_empleados"  onclick="location.href = 'empleados.jsp';" class="btn btn-primary">Ir a Empleados</button><p></p>
            <table border="1" class="table table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Puesto</th>
                    </tr>
                </thead>
                <tbody id="tbl_puestos">
                    <%
                        Puesto puesto = new Puesto();
                        DefaultTableModel tabla = new DefaultTableModel();
                        tabla = puesto.leer();
                        for (int i = 0; i < tabla.getRowCount(); i++) {
                            out.println("<tr data-id_p=" + tabla.getValueAt(i, 0) + ">");
                            out.println("<td>" + (i + 1) + "</td>");
                            out.println("<td>" + tabla.getValueAt(i, 1) + "</td>");
                            out.println("</tr>");
                        }
                    %>
                </tbody>
            </table>
        </div>  
        <footer class="text-center text-white fixed-bottom" style="background-color:#BFBFBF;">
            <div class="text-center p-3">
                © 2022 Copyright:
                <a class="text-white" href="https://okdiario.com/img/2022/01/21/5-rasgos-que-definen-la-personalidad-de-los-gatos.jpg" target="_blank">Grupo 3</a>
            </div>   
        </footer>

        <script src="https://code.jquery.com/jquery-3.6.1.slim.js" integrity="sha256-tXm+sa1uzsbFnbXt8GJqsgi2Tw+m4BLGDof6eUPjbtk=" crossorigin="anonymous"></script>           
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <script type="text/javascript">
                $('#tbl_puestos').on('click', 'tr td', function (evt) {
                    var target, id, nom;
                    target = $(event.target);
                    id = target.parent().data('id_p');


                    nom = target.parent("tr").find("td").eq(1).html();

                    $("#txt_id").val(id);
                    $("#txt_puesto").val(nom);
                    $("#modalPuestos").modal('show');
                });
        </script>
        <script type="text/javascript">

            function cls() {
                $("#txt_id").val(0);
                $("#txt_puesto").val('');

            }
            ;
        </script>
        <footer class="text-center text-light fixed-bottom" style="background-color:#7ACBEB;">
            <div class="text-center p-3">
                © 2022 Copyright:
                <a class="text-white" href="https://okdiario.com/img/2022/01/21/5-rasgos-que-definen-la-personalidad-de-los-gatos.jpg" target="_blank">Grupo 3</a>
            </div>   
        </footer>
    </body>

</html>
