/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Compra;

/**
 *
 * @author sergi
 */
public class sr_compras extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet sr_compras</title>");            
            out.println("</head>");
            out.println("<body>");
            Compra compra;
            compra = new Compra(Integer.valueOf(request.getParameter("txt_id_compra")),Integer.valueOf(request.getParameter("txt_no_orden")),Integer.valueOf(request.getParameter("slc_proveedor")),request.getParameter("txt_date"),request.getParameter("txt_fecha_ingreso"));
             if ("agregar".equals(request.getParameter("btn_compra"))){
            if (compra.agregar()> 0){
            response.setStatus(HttpServletResponse.SC_NO_CONTENT);
            }else{
            out.println("<h1> xxxxxxx No se Ingreso xxxxxxxxxxxx </h1>");
            out.println("<a href='compras.jsp'>Regresar...</a>");
            }
            }if ("eliminar".equals(request.getParameter("btn_eliminar"))){
            if (compra.eliminar_compra_detalle()> 0){
                compra.eliminar_compra();
            response.sendRedirect("compras.jsp");
            }else{
            out.println("<h1> xxxxxxx No se Elimino xxxxxxxxxxxx </h1>");
            out.println("<a href='compras.jsp'>Regresar...</a>");
            }
            }
            if ("modificar".equals(request.getParameter("btn_modificar"))){
            if (compra.modificar()> 0){
            response.sendRedirect("compras.jsp");
            }else{
            out.println("<h1> xxxxxxx No se Elimino xxxxxxxxxxxx </h1>");
            out.println("<a href='compras.jsp'>Regresar...</a>");
            }
            }
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
