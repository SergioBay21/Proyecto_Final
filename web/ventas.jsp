<%-- 
    Document   : ventas
    Created on : 3/11/2022, 12:41:03 AM
    Author     : sergi
--%>

<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Cliente" %>
<%@page import="modelo.Empleado" %>
<%@page import="modelo.Producto" %>
<%@page import="modelo.ventas" %>
<%@page import="modelo.ventas_detalle" %>
<%@page import="java.util.HashMap" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ventas</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
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
        <!-- Modal Venta -->
        <div class="modal fade" id="modal_ventas" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Venta</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="sr_venta" method="post">
                            <label class="form-label">Id Venta</label>
                            <input class="form-control" id="txt_id_venta" name="txt_id_venta" readonly>
                            <label class="form-label">No. Factura</label>
                            <input class='form-control' id="txt_no_factura" name="txt_no_factura" value=0 readonly>
                            <label class="form-label">Serie</label>
                            <input type="text" class="form-control" id="txt_serie" name="txt_serie" value="A" readonly>
                            <label class="form-label">Fecha</label>
                            <input type="date" class="form-control" id="txt_date" name="txt_date">
                            <label class="form-label">Cliente</label>
                            <div class="input-group mb-3">
                                <select id="slc_cliente" name="slc_cliente" class="form-select">
                                    <option>--  Elija Cliente --</option>
                                    <%
                                        Cliente Cliente;
                                        Cliente = new Cliente();
                                        HashMap<String, String> drop = Cliente.drop_cliente();
                                        for (String i : drop.keySet()) {
                                            out.println("<option value='" + i + "'>" + drop.get(i) + "</option>");
                                        }
                                    %>
                                </select>
                                <button class="btn btn-outline-secondary" type="button" onclick="location.href = 'clientes.jsp';">Agregar Cliente</button>
                            </div>
                            <label class="form-label">Empleado</label>
                            <div class="input-group mb-3">
                                <select id="slc_empleado" name="slc_empleado" class="form-select">
                                    <option>--  Elija Empleado --</option>
                                    <%
                                        Empleado Empleado;
                                        Empleado = new Empleado();
                                        HashMap<String, String> drop_e = Empleado.drop_empleado();
                                        for (String i : drop_e.keySet()) {
                                            out.println("<option value='" + i + "'>" + drop_e.get(i) + "</option>");
                                        }
                                    %>
                                </select>
                                <button class="btn btn-outline-secondary" type="button" onclick="location.href = 'empleados.jsp';">Agregar Empleado</button>
                            </div>
                            <label class="form-label">Fecha de ingreso</label>
                            <input type="text" class="form-control" id="txt_fecha_ingreso" name="txt_fecha_ingreso" readonly>
                            <div class="container">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>Id Producto</th>
                                            <th>Cantidad</th>
                                            <th>Descripcion</th>
                                            <th>Precio unitario</th>
                                            <th>Total</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbl_venta">

                                    </tbody>
                                </table>

                            </div>
                            <button class="btn btn-primary" data-bs-target="#modal_producto" data-bs-toggle="modal" data-bs-dismiss="modal" name="btn_venta" id="btn_venta" onclick="displayDate()" value="agregar">Agregar producto</button>
                            <button class="btn btn-primary" id="btn_modificar" name="btn_modificar" value="modificar">Modificar</button>
                            <button class="btn btn-primary" id="btn_eliminar" name="btn_eliminar" value="eliminar">Eliminar</button>
                        </form>
                        <button class="btn btn-primary" data-bs-target="#modal_producto" data-bs-toggle="modal" data-bs-dismiss="modal" id="btn_producto" name ="btn_producto" style="display:none" value="agregar_">Agregar producto</button><hr>
                        <button data-bs-dismiss="modal" onClick="window.location.reload(true)">Concluir Venta</button>

                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Producto -->
        <div class="modal fade" id="modal_producto" aria-hidden="true" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Producto</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form class="container" action="sr_ventas_detalle" method="post">  
                            <label class="form-label">Id Producto</label>
                            <input type="text" class="form-control" id="txt_idproducto" name="txt_idproducto" readonly>
                            <label class="form-label">Cantidad</label>
                            <div class="input-group mb-3">
                                <input type="text" class="form-control" id="txt_cantidad" name="txt_cantidad" onchange="total()">
                                <span class="input-group-text">Existencia</span>
                                <input type="text" class="form-control" id="txt_existencia" name="txt_existencia" readonly>
                            </div>
                            <label class="form-label">Descripcion</label>
                            <input type="text" class="form-control" id="txt_descripcion_producto" name="txt_descripcion_producto" readonly>
                            <label class="form-label">Precio Unitario</label>
                            <input type="text" class="form-control" id="txt_precio_unitario" name="txt_precio_unitario" readonly>
                            <label class="form-label">Total</label>
                            <input type="text" class="form-control" id="txt_total" name="txt_total" readonly>
                            <label></label>
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th scope="col">Id</th>
                                        <th scope="col">Descripcion</th>
                                        <th scope="col">Precio Unitario</th>
                                        <th scope="col">Existencia</th>
                                    </tr>
                                </thead>
                                <tbody id="tabla_productos">
                                    <%
                                        Producto producto = new Producto();
                                        DefaultTableModel tabla = new DefaultTableModel();
                                        tabla = producto.leer_tabla();
                                        for (int t = 0; t < tabla.getRowCount(); t++) {
                                            out.println("<tr>");
                                            out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                                            out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                                            out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                                            out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                                            out.println("</tr>");
                                        }
                                    %>
                                </tbody> 
                            </table>
                            <div class="modal-footer">
                                <button class="btn btn-primary" data-bs-target="#modal_ventas" data-bs-toggle="modal" data-bs-dismiss="modal" id="btn_agregar_venta" name="btn_agregar_venta" value="agregar" onclick="celda()">Agregar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <div class="container">
            <header>
                <figure class="text-center">
                    <P></P>
                    <h1>VENTAS</h1>
                </figure>
            </header>
            <a class="btn btn-primary" data-bs-toggle="modal" href="#modal_ventas" role="button" onclick="limpiar_ventas()">Agregar Venta</a>
            <p></p>
        </div>
        <div class="container">
            <form action="sr_venta" method="post">
                <table border="1" class="table table-striped">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>No. Factura</th>
                            <th>Serie</th>
                            <th>Fecha Factura</th>
                            <th>Id Cliente</th>
                            <th>Nombre Cliente</th>
                            <th>Id Empleado</th>
                            <th>Nombre Empleado</th>
                            <th>Fecha de Ingreso</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody id="tbl_ventas">
                        <%
                            ventas Venta = new ventas();
                            DefaultTableModel tabla_venta = new DefaultTableModel();
                            tabla_venta = Venta.leer_tabla();
                            for (int t = 0; t < tabla_venta.getRowCount(); t++) {
                                out.println("<tr>");
                                out.println("<td>" + tabla_venta.getValueAt(t, 0) + "</td>");
                                out.println("<td>" + tabla_venta.getValueAt(t, 1) + "</td>");
                                out.println("<td>" + tabla_venta.getValueAt(t, 2) + "</td>");
                                out.println("<td>" + tabla_venta.getValueAt(t, 3) + "</td>");
                                out.println("<td>" + tabla_venta.getValueAt(t, 4) + "</td>");
                                out.println("<td>" + tabla_venta.getValueAt(t, 5) + "</td>");
                                out.println("<td>" + tabla_venta.getValueAt(t, 6) + "</td>");
                                out.println("<td>" + tabla_venta.getValueAt(t, 7) + "</td>");
                                out.println("<td>" + tabla_venta.getValueAt(t, 8) + "</td>");
                                out.println("</tr>");
                            }
                        %>

                    </tbody>
                </table>
            </form>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <script type="text/javascript">
                var table = document.getElementById('tabla_productos');

                for (var i = 0; i < table.rows.length; i++)
                {
                    table.rows[i].onclick = function ()
                    {
                        rIndex = this.rowIndex;
                        document.getElementById("txt_idproducto").value = this.cells[0].innerHTML;
                        document.getElementById("txt_descripcion_producto").value = this.cells[1].innerHTML;
                        document.getElementById("txt_precio_unitario").value = this.cells[2].innerHTML;
                        document.getElementById("txt_existencia").value = this.cells[3].innerHTML;
                    };
                }
                function limpiar_ventas() {
                    $("#txt_id_venta").val(0);
                    $("#txt_no_factura").val(0);
                    $("#txt_date").val('');
                    $("#slc_cliente").val('');
                    $("#slc_empleado").val('');
                    $("#txt_fecha_ingreso").val('');
                }
                function limpiar() {
                    $("#txt_idproducto").val(0);
                    $("#txt_descripcion_producto").val('');
                    $("#txt_precio_unitario").val('');
                    $("#txt_cantidad").val('');
                    $("#txt_total").val('');
                    $("#txt_existencia").val('');
                }

                function total() {
                    var precio_u = document.getElementById("txt_precio_unitario");
                    var cant = document.getElementById("txt_cantidad");
                    var exist = document.getElementById("txt_existencia");
                    var total = precio_u.value * cant.value;
                    var exist_total = exist.value - cant.value;
                    document.getElementById("txt_total").value = total;
                    document.getElementById("txt_existencia").value = exist_total;
                }
                function celda() {
                    tbl = document.getElementById("tbl_venta");
                    row = tbl.insertRow(0);
                    var newCell = row.insertCell(0);
                    newCell.innerHTML = document.getElementById("txt_idproducto").value;
                    var newCell = row.insertCell(1);
                    newCell.innerHTML = document.getElementById("txt_cantidad").value;
                    var newCell = row.insertCell(2);
                    newCell.innerHTML = document.getElementById("txt_descripcion_producto").value;
                    var newCell = row.insertCell(3);
                    newCell.innerHTML = document.getElementById("txt_precio_unitario").value;
                    var newCell = row.insertCell(4);
                    newCell.innerHTML = document.getElementById("txt_total").value;
                }
                const btn = document.getElementById("btn_venta");
                const btn_2 = document.getElementById("btn_producto");
                btn.addEventListener('click', () => {
                    btn.style.display = 'none';
                    btn_2.style.display = "block";
                });
                function displayDate() {
                    let date = new Date();
                    var dateString = (date.toISOString().split('T')[0]);
                    var dateString1 = date.toLocaleTimeString();

                    document.getElementById("txt_fecha_ingreso").value = [dateString + " " + dateString1];
                }
                ;
        </script>
        <script type="text/javascript">
            var table = document.getElementById('tbl_ventas');

            for (var i = 0; i < table.rows.length; i++)
            {
                table.rows[i].onclick = function ()
                {

                    //rIndex = this.rowIndex;
                    document.getElementById("txt_id_venta").value = this.cells[0].innerHTML;
                    document.getElementById("txt_no_factura").value = this.cells[1].innerHTML;
                    document.getElementById("txt_serie").value = this.cells[2].innerHTML;
                    document.getElementById("txt_date").value = this.cells[3].innerHTML;
                    document.getElementById("slc_cliente").value = this.cells[4].innerHTML;
                    document.getElementById("slc_empleado").value = this.cells[6].innerHTML;
                    document.getElementById("txt_fecha_ingreso").value = this.cells[8].innerHTML;
                    $("#modal_ventas").modal('show');
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
