/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author sergi
 */
public class ventas {

    int id_venta, no_factura_, id_cliente, id_empleado;
    String serie, fecha_factura, fecha_ingreso;
    Conexion cn;

    public ventas() {}

    public ventas(int id_venta, int no_factura_, int id_cliente, int id_empleado, String serie, String fecha_factura, String fecha_ingreso) {
        this.id_venta = id_venta;
        this.no_factura_ = no_factura_;
        this.id_cliente = id_cliente;
        this.id_empleado = id_empleado;
        this.serie = serie;
        this.fecha_factura = fecha_factura;
        this.fecha_ingreso = fecha_ingreso;
    }

    public int getId_venta() {
        return id_venta;
    }

    public void setId_venta(int id_venta) {
        this.id_venta = id_venta;
    }

    public int getNo_factura_() {
        return no_factura_;
    }

    public void setNo_factura_(int no_factura_) {
        this.no_factura_ = no_factura_;
    }

    public int getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }

    public int getId_empleado() {
        return id_empleado;
    }

    public void setId_empleado(int id_empleado) {
        this.id_empleado = id_empleado;
    }

    public String getSerie() {
        return serie;
    }

    public void setSerie(String serie) {
        this.serie = serie;
    }

    public String getFecha_factura() {
        return fecha_factura;
    }

    public void setFecha_factura(String fecha_factura) {
        this.fecha_factura = fecha_factura;
    }

    public String getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(String fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }
    
    public DefaultTableModel leer_tabla() throws SQLException{
    DefaultTableModel tabla = new DefaultTableModel();
    try{
    cn = new Conexion();
    cn.abrir_conexion();
    String query = "SELECT e.idventa as idventa,e.nofactura,e.serie,e.fechafactura,e.idcliente,concat_ws(' ',p.nombres,p.apellidos) as nombre_cliente,e.idempleado,concat_ws(' ',q.nombres,q.apellidos) as nombre_empleado,e.fechaingreso FROM ventas as e inner join clientes as p on e.idcliente = p.idclientes inner join empleados as q on e.idempleado = q.idempleado;";
    ResultSet consulta_tabla = cn.conexionBD.createStatement().executeQuery(query);
    String encabezado[] = {"id","no factura","serie","nit","fechafactura","idcliente","cliente","idempleado","empleado","fechaingreso"};
    tabla.setColumnIdentifiers(encabezado);
      String datos[] = new String[9];
      while (consulta_tabla.next()){
          datos[0] = consulta_tabla.getString("idventa");
          datos[1] = consulta_tabla.getString("nofactura");
          datos[2] = consulta_tabla.getString("serie");
          datos[3] = consulta_tabla.getString("fechafactura");
          datos[4] = consulta_tabla.getString("idcliente");
          datos[5] = consulta_tabla.getString("nombre_cliente");
          datos[6] = consulta_tabla.getString("idempleado");
          datos[7] = consulta_tabla.getString("nombre_empleado");
          datos[8] = consulta_tabla.getString("fechaingreso");
          tabla.addRow(datos);
      }
        cn.cerrar_conexion();
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    }
    return tabla;
    }
    public int leer_factura() {
        int id_venta_ = 0;
        try {
            cn = new Conexion();
            String query = "SELECT (max(nofactura) + 1) as nofactura FROM ventas;";
            cn.abrir_conexion();
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
            consulta.next();
            id_venta_ = Integer.valueOf(consulta.getString("nofactura"));
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return id_venta_;
    }

    public int agregar() {
        int retorno = 0;
        leer_factura();
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "INSERT INTO ventas(nofactura,serie,fechafactura,idcliente,idempleado,fechaingreso) VALUES (?,?,?,?,?,?);";
            cn.abrir_conexion();
            parametro = (PreparedStatement) cn.conexionBD.prepareStatement(query);
            parametro.setInt(1, leer_factura());
            parametro.setString(2, getSerie());
            parametro.setString(3, getFecha_factura());
            parametro.setInt(4, getId_cliente());
            parametro.setInt(5, getId_empleado());
            parametro.setString(6, getFecha_ingreso());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return retorno;
    }

    public String leer_id() {
        String n_factura = null;
        try {
            cn = new Conexion();
            String query = "SELECT (max(nofactura) + 1) as nofactura FROM ventas;";
            cn.abrir_conexion();
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
            consulta.next();
            n_factura = consulta.getString("nofactura");
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return n_factura;
    }
    public int eliminar_ventas_detalle(){
        int retorno =0;
        try{
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "DELETE FROM ventas_detalle where idventa=?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
            parametro.setInt(1, this.getId_venta());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
    return retorno;
    }
    public int eliminar_ventas(){
        int retorno =0;
        try{
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "DELETE FROM ventas WHERE idventa=?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
            parametro.setInt(1, this.getId_venta());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
    return retorno;
    }
   public int modificar (){
        int retorno =0;
        int id = this.getId_venta();
        try{
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "UPDATE ventas SET fechafactura= ?,idcliente= ?,idempleado= ?,fechaingreso= ? where idventa= "+ id +" ;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
            parametro.setString(1,this.getFecha_factura());
            parametro.setInt(2,this.getId_cliente());
            parametro.setInt(3,this.getId_empleado());
            parametro.setString(4,this.getFecha_ingreso());
            //parametro.setInt(5,getId_venta());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
    return retorno;
    }
       public DefaultTableModel leer() throws SQLException{
    int id = this.getId_venta();
    DefaultTableModel tabla = new DefaultTableModel();
    try{
    cn = new Conexion();
    cn.abrir_conexion();
    String query = "SELECT idventas_detalle,idventa,idproducto,cantidad,precio_unitario FROM ventas_detalle where idventa="+ this.getId_venta() +";";
    ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
    String encabezado[] = {"idventas_detalle","idventa","idproducto","cantidad","precio_unitario"};
    tabla.setColumnIdentifiers(encabezado);
      String datos[] = new String[5];
      while (consulta.next()){
          datos[0] = consulta.getString("idventas_detalle");
          datos[1] = consulta.getString("idventa");
          datos[2] = consulta.getString("idproducto");
          datos[3] = consulta.getString("cantidad");
          datos[4] = consulta.getString("precio_unitario");
          tabla.addRow(datos);
      }
        cn.cerrar_conexion();
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    }
    return tabla;
    }
}
