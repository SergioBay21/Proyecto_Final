/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author sergi
 */
public class tabla {
    Conexion cn;
    int id_venta;
    
    public tabla(){}
    public tabla(int id_venta) {
        this.id_venta = id_venta;
    }
    

    public int getId_venta() {
        return id_venta;
    }

    public void setId_venta(int id_venta) {
        this.id_venta = id_venta;
    }
    
    public int leerid(){
        int id = this.getId_venta();
                
        return id;
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

