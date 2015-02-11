/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Admin;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Clases.*;
import java.sql.ResultSet;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Americo
 */
public class LoginAdmin extends HttpServlet {

    ConectionDB con = new ConectionDB();

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
        PrintWriter out = response.getWriter();
        HttpSession sesion = request.getSession(true);
        try {
            /* TODO output your page here. You may use following sample code. */
            if (request.getParameter("accion").equals("1")) {
                try {
                    con.conectar();
                    try {
                        String id_usu = "", nombre = "", rol = "", cla_uni = "", cedula = "", tipo = "ALMACEN";
                        int ban = 0;
                        ResultSet rset = con.consulta("select id, usuario from admin_users where usuario = '" + request.getParameter("user") + "' and password = PASSWORD('" + request.getParameter("pass") + "') ");
                        while (rset.next()) {
                            ban = 1;
                            id_usu = rset.getString("id");
                            nombre = rset.getString("usuario");
                        }
                        if (ban == 1) {//----------------------EL USUARIO ES VÁLIDO
                            sesion.setAttribute("id_usu", id_usu);
                            response.sendRedirect("admin/main_menu.jsp");
                        } else {//--------------------------EL USUARIO NO ES VÁLIDO
                    out.println("hola");
                            sesion.setAttribute("mensaje", "Usuario no válido");
                            response.sendRedirect("index_admin.jsp");
                        }
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }
                    con.cierraConexion();
                } catch (Exception e) {

                }
            }
        } finally {
            out.close();
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
