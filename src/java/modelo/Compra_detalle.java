/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author sergi
 */
public class Compra_detalle {

    Conexion cn;
    int idproducto, cantidad, preciounitario,existencia;

    public Compra_detalle() {
    }

    public Compra_detalle(int idproducto, int cantidad, int preciounitario, int existencia) {
        this.idproducto = idproducto;
        this.cantidad = cantidad;
        this.preciounitario = preciounitario;
        this.existencia = existencia;
    }

    public int getIdproducto() {
        return idproducto;
    }

    public void setIdproducto(int idproducto) {
        this.idproducto = idproducto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public int getPreciounitario() {
        return preciounitario;
    }

    public void setPreciounitario(int preciounitario) {
        this.preciounitario = preciounitario;
    }

    public int getExistencia() {
        return existencia;
    }

    public void setExistencia(int existencia) {
        this.existencia = existencia;
    }
    

    public int leer_detalle() {
        int id_compra = 0;
        try {
            cn = new Conexion();
            String query = "SELECT (max(idcompra_detalle) + 1) as id_compra_detalle FROM compras_detalle;";
            cn.abrir_conexion();
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
            consulta.next();
            id_compra = Integer.valueOf(consulta.getString("id_compra_detalle"));
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return id_compra;
    }

    public int leer_compra() {
        int id_compra = 0;
        try {
            cn = new Conexion();
            String query = "SELECT (max(idcompra)) as id_compra FROM compras;";
            cn.abrir_conexion();
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
            consulta.next();
            id_compra = Integer.valueOf(consulta.getString("id_compra"));
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return id_compra;
    }

    public int agregar() {
        leer_detalle();
        leer_compra();
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "INSERT INTO compras_detalle (idcompra_detalle, idcompra, idproducto, cantidad, precio_costo_unitario) VALUES (?,?,?,?,?);";
            cn.abrir_conexion();
            parametro = (PreparedStatement) cn.conexionBD.prepareStatement(query);
            parametro.setInt(1, leer_detalle());
            parametro.setInt(2, leer_compra());
            parametro.setInt(3, this.getIdproducto());
            parametro.setInt(4, this.getCantidad());
            parametro.setInt(5, this.getPreciounitario());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return retorno;
    }

    public int modificar_existencia() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            cn = new Conexion();
            String query = "UPDATE productos SET existencia = ? WHERE (idproductos = ?);";
            cn.abrir_conexion();
            parametro = (PreparedStatement) cn.conexionBD.prepareStatement(query);
            parametro.setInt(1, this.getExistencia());
            parametro.setInt(2, this.getIdproducto());
            retorno = parametro.executeUpdate();
            cn.cerrar_conexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return retorno;
    }

}
