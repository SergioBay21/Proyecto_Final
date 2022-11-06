<%-- 
    Document   : ventas
    Created on : 31/10/2022, 17:59:49
    Author     : Sapón Pérez
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="modelo.Conexion"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Empleado" %>
<%@page import="modelo.Producto" %>
<%@page import="modelo.Cliente" %>
<%@page import="modelo.ventas" %>
<%@page import="modelo.ventas_detalle" %>
<%@page import="java.util.HashMap" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ventas</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

            if (session.getAttribute("nombre") == null) {
                response.sendRedirect("index.jsp");
            }
        %>
    </head>
    
 
      
    
    <body><nav class="navbar navbar-expand-lg" style="background-color:#7ACBEB;">
        <div class="container-fluid">
            <div class="collapse navbar-collapse">
                <a class="navbar-brand mt-2 mt-lg-0" href="index.jsp">
                    <img src="despensafelizlogo.png" height="40" alt="logo despensa feliz"/>
                </a>
                            <ul>
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
                </li>

                <li><a href="">Compras</a>
                    <ul>
                        <li><a href="proveedores.jsp">Proveedores</a></li>
                    </ul>
                </li>
                <li><a href="">Reportes</a></li>
            </ul>
            </div>
            <form action="sr_cerrar_sesion">
                <input type=image src="salir.png" width="25" height="25" style="margin-right: 50px">
            </form>
    </nav>
        
        <header>
            <figure class="text-center">
                <P></P>
                <h1>VENTAS</h1>
            </figure>
        </header>
        <form class="container" action="sr_venta" method="post">

            <div class="row">
                <div class="col">
                    <label class="form-label">Id Venta</label>
                    <input type="text" class="form-control" id="txt_id_venta" name="txt_id_venta" readonly value="1232">
                    <p></p>
                    <label class="form-label">No. Factura</label>
                    <input type="text" class="form-control" id="txt_no_factura" name="txt_no_factura" readonly value="0">
                    <p></p>
                    <label class="form-label">Serie</label>
                    <input type="text" class="form-control" id="txt_serie" name="txt_serie" value="A" readonly>
                    <p></p>
                    <label class="form-label">Fecha</label>
                    <input type="date" class="form-control" id="txt_date" name="txt_date">
                </div>

                <div class="col">
                    <div>
                        <label class="form-label">Cliente</label>
                        <div class="input-group mb-3">
                            <select id="slc_cliente" name="slc_cliente" class="form-select">
                                <option>--  Elija Cliente --</option>
                                <%
                                    Cliente cliente = new Cliente();
                                    HashMap<String, String> drop = cliente.drop_cliente();
                                    for (String i : drop.keySet()) {
                                        out.println("<option value='" + i + "'>" + drop.get(i) + "</option>");
                                    }
                                %>
                            </select>
                            <button class="btn btn-outline-secondary" type="button" onclick="location.href = 'clientes.jsp';">Agregar Cliente</button>
                        </div>
                    </div>
                    <label class="form-label">Empleado</label>  
                    <div>
                        <div class="input-group mb-3">
                            <select id="slc_empleado" name="slc_empleado" class="form-select">
                                <option>--  Elija Empleado --</option>
                                <%
                                    Empleado empleado = new Empleado();

                                    HashMap<String, String> drop_e = empleado.drop_empleado();
                                    for (String i : drop_e.keySet()) {
                                        out.println("<option value='" + i + "'>" + drop_e.get(i) + "</option>");
                                    }
                                %>
                            </select>
                            <button class="btn btn-outline-secondary" type="button" onclick="location.href = 'empleados.jsp';">Agregar Empleado</button>
                        </div>
                    </div>
                    <label class="form-label">Fecha de ingreso</label>
                    <input type="text" class="form-control" id="txt_fecha_ingreso" name="txt_fecha_ingreso" readonly>
                    <p></p>
                </div>
            </div>

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
                        <%
                            String id = "125";
                            out.println("<p>"+ id +"<p>");
                            try {
                                Conexion cn;
                                cn = new Conexion();
                                cn.abrir_conexion();
                                String query = "SELECT idventas_detalle,idventa,idproducto,cantidad,precio_unitario FROM ventas_detalle where idventa= "+ id+ ";";
                                
                                ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
                                while (consulta.next()) {
                                    out.println("<tr>");
                                    out.println("<td>" + consulta.getObject("idventas_detalle") + "</td>");
                                    out.println("<td>" + consulta.getObject("idventa") + "</td>");
                                    out.println("<td>" + consulta.getObject("idproducto") + "</td>");
                                    out.println("<td>" + consulta.getObject("cantidad") + "</td>");
                                    out.println("<td>" + consulta.getObject("precio_unitario") + "</td>");
                                    out.println("</tr>");
                                }

                                // cierre de la conexion
                                cn.cerrar_conexion();
                            } catch (Exception e) {
                                // Error en algun momento.
                                out.println("Excepcion " + e);
                                e.printStackTrace();
                            }
                        %>

                    </tbody>
                </table>

            </div>
            <div class="d-grid gap-3 col-3 mx-auto">
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal_productos" name="btn_venta" id="btn_venta" value="agregar" onclick="displayDate()">Agregar Producto</button>
                <button class="btn btn-primary" name="btn_modificar" id="btn_modificar" value="modificar" onclick="displayDate()">Modificar</button>
                <button class="btn btn-primary" name="btn_eliminar" id="btn_eliminar" value="eliminar" onclick="displayDate()">Eliminar</button>
            </div>

        </form>                    
        <div class="d-grid gap-2 col-2 mx-auto">
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal_productos" id="btn_producto" name ="btn_producto" onclick="limpiar()" style="display:none" value="agregar_">Agregar Producto</button>
            <p></p>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal_ventas" name="btn_ventas" id="btn_ventas">Ver Ventas</button>
            <p></p>
            <button class="btn btn-primary" onClick="window.location.reload(true)">Concluir Venta</button>
        </div>

        <div class="modal fade" tabindex="-1" id="modal_productos" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Agregar Producto</h5>
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
                                <button id="btn_agregar_venta" name="btn_agregar_venta" value="agregar" data-bs-dismiss="modal" onclick="celda()">Agregar</button>   
                            </table>
                        </form>
                    </div>        
                </div>           
            </div>       
        </div>
        <div class="modal fade" id="modal_ventas">
            <div class="modal-dialog modal-xl modal-dialog-centered">
                <div class="modal-content">

                    <!-- cabecera del diálogo -->
                    <div class="modal-header">
                        <h4 class="modal-title">Título del diálogo</h4>
                    </div>

                    <!-- cuerpo del diálogo -->
                    <div class="modal-body">
                        <div class="container">
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
                        </div>
                    </div>

                    <!-- pie del diálogo -->
                    <div class="modal-footer">
                        <input type="button" data-dismiss="modal" value="cargar_tabla" id="btn_recargar" name="btn_recargar" value="Cargar">
                    </div>

                </div>
            </div>
        </div> 


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


    </script>
    <script type="text/javascript">
        function hola(){
            var id = document.getElementById('nameValidation').value;
            return id;
        }
        function displayDate() {
            let date = new Date();
            var dateString = (date.toISOString().split('T')[0]);
            var dateString1 = date.toLocaleTimeString();

            document.getElementById("txt_fecha_ingreso").value = [dateString + " " + dateString1];
        }
        ;
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
            };
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('btn_recargar').on('click', function () {
                $("#tbl_venta").load('maestro_detalle_ventas.jsp');
                return false;
            });
        });
    </script>
</body>
<footer class="text-center text-light fixed-bottom" style="background-color:#7ACBEB;">
    <div class="text-center p-3">
        © 2022 Copyright:
        <a class="text-white" href="https://okdiario.com/img/2022/01/21/5-rasgos-que-definen-la-personalidad-de-los-gatos.jpg" target="_blank">Grupo 3</a>
    </div>   
</footer>
</html>
