/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Sapón Pérez
 */
public class Compra {

    Conexion cn;
    int id_compra, no_orden, id_proveedor;
    String fecha_orden, fecha_ingreso;

    public Compra() {
    }

    public Compra(int id_compra, int no_orden, int id_proveedor, String fecha_orden, String fecha_ingreso) {
        this.id_compra = id_compra;
        this.no_orden = no_orden;
        this.id_proveedor = id_proveedor;
        this.fecha_orden = fecha_orden;
        this.fecha_ingreso = fecha_ingreso;
    }

    public int getId_compra() {
        return id_compra;
    }

    public void setId_compra(int id_compra) {
        this.id_compra = id_compra;
    }

    public int getNo_orden() {
        return no_orden;
    }

    public void setNo_orden(int no_orden) {
        this.no_orden = no_orden;
    }

    public int getId_proveedor() {
        return id_proveedor;
    }

    public void setId_proveedor(int id_proveedor) {
        this.id_proveedor = id_proveedor;
    }

    public String getFecha_orden() {
        return fecha_orden;
    }

    public void setFecha_orden(String fecha_orden) {
        this.fecha_orden = fecha_orden;
    }

    public String getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(String fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }

    public DefaultTableModel leer_compras() {
        DefaultTableModel tabla = new DefaultTableModel();

        try {
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "select e.idcompra,e.no_orden_compra,e.idproveedor,p.proveedor,e.fecha_orden,fechaingreso from compras as e inner join proveedores as p on e.idproveedor = p.idproveedores;";
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
            String encabezado[] = {"id", "no_orden", "idproveedor", "proveedor", "fecha_orden", "Fecha_Ingreso"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[7];
            while (consulta.next()) {
                datos[0] = consulta.getString("idcompra");
                datos[1] = consulta.getString("no_orden_compra");
                datos[2] = consulta.getString("idproveedor");
                datos[3] = consulta.getString("proveedor");
                datos[4] = consulta.getString("fecha_orden");
                datos[5] = consulta.getString("fechaingreso");
                tabla.addRow(datos);

            }
            cn.cerrar_conexion();

        } catch (SQLException ex) {
            System.out.println("xxxXXXXXerrorXXXXXxxx" + ex.getMessage());
        }
        return tabla;
    }

    public int leer_orden() {
        int orden = 0;
        try {
            cn = new Conexion();
            String query = "SELECT (max(no_orden_compra) + 1) as no_orden_compra FROM compras;";
            cn.abrir_conexion();
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
            consulta.next();
            orden = Integer.valueOf(consulta.getString("no_orden_compra"));
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return orden;
    }

    public int agregar() {
        int retorno = 0;
        leer_orden();
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "INSERT INTO compras(no_orden_compra,idproveedor,fecha_orden,fechaingreso) VALUES (?,?,?,?);";
            cn.abrir_conexion();
            parametro = (PreparedStatement) cn.conexionBD.prepareStatement(query);
            parametro.setInt(1, leer_orden());
            parametro.setInt(2, this.getId_proveedor());
            parametro.setString(3, this.getFecha_orden());
            parametro.setString(4, this.getFecha_ingreso());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return retorno;
    }

    public int modificar() {
        int retorno = 0;
        int id = this.getId_compra();
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "UPDATE compras SET idproveedor=?, fecha_orden= ?, fechaingreso= ? where idcompra= " + id + " ;";
            cn.abrir_conexion();
            parametro = (PreparedStatement) cn.conexionBD.prepareStatement(query);
            parametro.setInt(1, this.getId_proveedor());
            parametro.setString(2, this.getFecha_orden());
            parametro.setString(3, this.getFecha_ingreso());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return retorno;
    }

    public int eliminar_compra() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "DELETE FROM compras WHERE idcompra=?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement) cn.conexionBD.prepareStatement(query);
            parametro.setInt(1, this.getId_compra());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return retorno;
    }
        public int eliminar_compra_detalle(){
        int retorno =0;
        try{
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "DELETE FROM compras_detalle where idcompra=?;";
            cn.abrir_conexion();
            parametro = (PreparedStatement)cn.conexionBD.prepareStatement(query);
            parametro.setInt(1, this.getId_compra());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
    return retorno;
    }

}
