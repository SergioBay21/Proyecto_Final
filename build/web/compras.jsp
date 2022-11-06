<%-- 
    Document   : compras
    Created on : 29/10/2022, 20:24:31
    Author     : Sapón Pérez
--%>

<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Proveedor"%>
<%@page import="modelo.Compra"%>
<%@page import="modelo.Producto"%>
<%@page import="java.util.HashMap" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Compras</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
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
        <div class="container">
            <a class="btn btn-primary" data-bs-toggle="modal" href="#modal_compras" role="button" onclick="limpiar_compras()">Agregar Compra</a>
            <p></p>
            <table border="1" class="table table-striped">
                <thead>
                    <tr>
                        <th>Id Compra</th>
                        <th>No. Orden</th>
                        <th>Id proveedor</th>
                        <th>Proveedor</th>
                        <th>Fecha Orden</th>
                        <th>Fecha Ingreso</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody id="tbl_compras">
                    <%
                        Compra compras = new Compra();
                        DefaultTableModel tabla_compra = new DefaultTableModel();
                        tabla_compra = compras.leer_compras();
                        for (int t = 0; t < tabla_compra.getRowCount(); t++) {
                            out.println("<tr>");
                            out.println("<td>" + tabla_compra.getValueAt(t, 0) + "</td>");
                            out.println("<td>" + tabla_compra.getValueAt(t, 1) + "</td>");
                            out.println("<td>" + tabla_compra.getValueAt(t, 2) + "</td>");
                            out.println("<td>" + tabla_compra.getValueAt(t, 3) + "</td>");
                            out.println("<td>" + tabla_compra.getValueAt(t, 4) + "</td>");
                            out.println("<td>" + tabla_compra.getValueAt(t, 5) + "</td>");
                            out.println("</tr>");
                        }
                    %>

                </tbody>
            </table>
        </div>
        <-<!-- Modal Compra -->
        <div class="modal fade" id="modal_compras" aria-hidden="true" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Venta</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="sr_compras" method="post">
                            <label class="form-label">Id Compra</label>
                            <input class="form-control" id="txt_id_compra" name="txt_id_compra" value =0 readonly>
                            <label class="form-label">No. Orden de Compra</label>
                            <input class='form-control' id="txt_no_orden" name="txt_no_orden" value=0 readonly>
                            <label class="form-label">Proveedor</label>
                            <div class="input-group mb-3">
                                <select id="slc_proveedor" name="slc_proveedor" class="form-select">
                                    <option>--  Elija Proveeedor --</option>
                                    <%
                                        Proveedor drop_proveedor;
                                        drop_proveedor = new Proveedor();
                                        HashMap<String, String> drop = drop_proveedor.drop_proveedor();
                                        for (String i : drop.keySet()) {
                                            out.println("<option value='" + i + "'>" + drop.get(i) + "</option>");
                                        }
                                    %>
                                </select>
                                <button class="btn btn-outline-secondary" type="button" onclick="location.href = 'proveedores.jsp';">Agregar Proveedor</button>
                            </div>
                            <label class="form-label">Fecha</label>
                            <input type="date" class="form-control" id="txt_date" name="txt_date">
                            <label class="form-label">Fecha de ingreso</label>
                            <input type="text" class="form-control" id="txt_fecha_ingreso" name="txt_fecha_ingreso" readonly>
                            <div class="container">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>Id Producto</th>
                                            <th>Cantidad</th>
                                            <th>Descripcion</th>
                                            <th>Precio Costo</th>
                                            <th>Precio Venta</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbl_compra_detalle">

                                    </tbody>
                                </table>

                            </div>
                            <button class="btn btn-primary" data-bs-target="#modal_producto" data-bs-toggle="modal" data-bs-dismiss="modal" name="btn_compra" id="btn_compra" onclick="displayDate()" value="agregar">Agregar Compra</button>
                            <button class="btn btn-primary" id="btn_modificar" name="btn_modificar" value="modificar">Modificar</button>
                            <button class="btn btn-primary" id="btn_eliminar" name="btn_eliminar" value="eliminar">Eliminar</button>
                        </form>
                        <button class="btn btn-primary" data-bs-target="#modal_producto" data-bs-toggle="modal" data-bs-dismiss="modal" id="btn_producto" name ="btn_producto" style="display:none" value="agregar_">Agregar Compra</button><hr>
                        <button data-bs-dismiss="modal" onClick="window.location.reload(true)">Concluir Compra</button>

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
                        <form class="container" action="sr_compras_detalle" method="post">  
                            <label class="form-label">Id Producto</label>
                            <input type="text" class="form-control" id="txt_idproducto" name="txt_idproducto" readonly>
                            <label class="form-label">Cantidad</label>
                            <div class="input-group mb-3">
                                <input type="text" class="form-control" id="txt_cantidad" name="txt_cantidad" onchange="existencia()">
                                <span class="input-group-text">Existencia</span>
                                <input type="text" class="form-control" id="txt_existencia" name="txt_existencia" readonly>
                            </div>
                            <label class="form-label">Descripcion</label>
                            <input type="text" class="form-control" id="txt_descripcion_producto" name="txt_descripcion_producto" readonly>
                            <label class="form-label">Precio Costo</label>
                            <input type="text" class="form-control" id="txt_precio_costo" name="txt_precio_costo" onchange="precio()">
                            <label class="form-label">Precio Venta</label>
                            <input type="text" class="form-control" id="txt_precio_venta" name="txt_precio_venta" readonly>
                            <label></label>
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th scope="col">Id</th>
                                        <th scope="col">Descripcion</th>
                                        <th scope="col">Precio Costo</th>
                                        <th scope="col">Precio Venta</th>
                                        <th scope="col">Existencia</th>
                                    </tr>
                                </thead>
                                <tbody id="tabla_productos">
                                    <%
                                        Producto producto = new Producto();
                                        DefaultTableModel tabla = new DefaultTableModel();
                                        tabla = producto.leer_tabla_2();
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
                            <div class="modal-footer">
                                <button class="btn btn-primary" data-bs-target="#modal_compras" data-bs-toggle="modal" data-bs-dismiss="modal" id="btn_agregar_compra" name="btn_agregar_compra" value="agregar" onclick="celda()">Agregar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <script type="text/javascript">
                                    var table = document.getElementById('tbl_compras');

                                    for (var i = 0; i < table.rows.length; i++)
                                    {
                                        table.rows[i].onclick = function ()
                                        {

                                            //rIndex = this.rowIndex;
                                            document.getElementById("txt_id_compra").value = this.cells[0].innerHTML;
                                            document.getElementById("txt_no_orden").value = this.cells[1].innerHTML;
                                            document.getElementById("slc_proveedor").value = this.cells[2].innerHTML;
                                            document.getElementById("txt_date").value = this.cells[4].innerHTML;
                                            document.getElementById("txt_fecha_ingreso").value = this.cells[5].innerHTML;
                                            $("#modal_compras").modal('show');
                                        };
                                    }
                                    function displayDate() {
                                        let date = new Date();
                                        var dateString = (date.toISOString().split('T')[0]);
                                        var dateString1 = date.toLocaleTimeString();

                                        document.getElementById("txt_fecha_ingreso").value = [dateString + " " + dateString1];
                                    }
                                    ;
                                    function celda() {
                                        tbl = document.getElementById("tbl_compra_detalle");
                                        row = tbl.insertRow(0);
                                        var newCell = row.insertCell(0);
                                        newCell.innerHTML = document.getElementById("txt_idproducto").value;
                                        var newCell = row.insertCell(1);
                                        newCell.innerHTML = document.getElementById("txt_cantidad").value;
                                        var newCell = row.insertCell(2);
                                        newCell.innerHTML = document.getElementById("txt_descripcion_producto").value;
                                        var newCell = row.insertCell(3);
                                        newCell.innerHTML = document.getElementById("txt_precio_costo").value;
                                        var newCell = row.insertCell(4);
                                        newCell.innerHTML = document.getElementById("txt_precio_venta").value;
                                    }
                                    const btn = document.getElementById("btn_compra");
                                    const btn_2 = document.getElementById("btn_producto");
                                    btn.addEventListener('click', () => {
                                        btn.style.display = 'none';
                                        btn_2.style.display = "block";
                                    });
                                    function existencia() {
                                        var cant = document.getElementById("txt_cantidad").value;
                                        var exist = document.getElementById("txt_existencia").value;
                                        var exist_total = parseInt(cant) + parseInt(exist);
                                        document.getElementById("txt_existencia").value = exist_total;
                                    }
                                    function precio() {
                                        var p_c = document.getElementById("txt_precio_costo").value;
                                        var precio_venta = p_c * 1.25;
                                        document.getElementById("txt_precio_venta").value = precio_venta;
                                    }
                                    var table = document.getElementById('tabla_productos');

                                    for (var i = 0; i < table.rows.length; i++)
                                    {
                                        table.rows[i].onclick = function ()
                                        {
                                            rIndex = this.rowIndex;
                                            document.getElementById("txt_idproducto").value = this.cells[0].innerHTML;
                                            document.getElementById("txt_descripcion_producto").value = this.cells[1].innerHTML;
                                            document.getElementById("txt_precio_costo").value = this.cells[2].innerHTML;
                                            document.getElementById("txt_existencia").value = this.cells[3].innerHTML;
                                        };
                                    }
                                    function limpiar_compras() {
                                        $("#txt_id_compra").val(0);
                                        $("#txt_no_orden").val(0);
                                        $("#txt_date").val('');
                                        $("#slc_proveedor").val('');
                                        $("#txt_fecha_ingreso").val('');
                                    }
                                    function limpiar() {
                                        $("#txt_idproducto").val(0);
                                        $("#txt_descripcion_producto").val('');
                                        $("#txt_precio_costo").val('');
                                        $("#txt_cantidad").val('');
                                        $("#txt_precio_venta").val('');
                                        $("#txt_existencia").val('');
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
