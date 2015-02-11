/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Clases.ConectionDB;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Americo
 */
public class EliminaClave extends HttpServlet {

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
        System.out.println("hols");
        DateFormat df2 = new SimpleDateFormat("dd/MM/yyyy");
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        ConectionDB con = new ConectionDB();
        JSONObject json = new JSONObject();
        JSONArray jsona = new JSONArray();
        HttpSession sesion = request.getSession(true);
        try {
            con.conectar();
            try {
                String det_pro = "", id_rec = "";
                int n_cant = 0, can_sol = 0, cant_sur = 0, cant_inv = 0;
                ResultSet rset = con.consulta("select dr.det_pro, dr.can_sol, dr.cant_sur, i.cant, dr.id_rec from detreceta dr, detalle_productos dp, inventario i where dr.det_pro = dp.det_pro and dp.det_pro = i.det_pro and dr.fol_det = '" + request.getParameter("fol_det") + "' ");
                while (rset.next()) {
                    det_pro = rset.getString(1);
                    can_sol = rset.getInt(2);
                    cant_sur = rset.getInt(3);
                    cant_inv = rset.getInt(4);
                    id_rec = rset.getString(5);
                }

                n_cant = cant_inv + cant_sur;

                System.out.println("update detreceta set can_sol = '0', cant_sur = '0', baja='1' where fol_det = '" + request.getParameter("fol_det") + "' ");
                System.out.println("update inventario set cant = '" + n_cant + "' where det_pro = '" + det_pro + "' ");
                System.out.println("insert into kardex values ('0', '" + id_rec + "', '" + det_pro + "', '" + cant_sur + "', 'REINTEGRA AL IVENTARIO', '-', NOW(), 'SE ELIMINA INSUMO DE RECETA', '" + sesion.getAttribute("id_usu") + "', '0'); ");
                con.insertar("update detreceta set can_sol = '0', cant_sur = '0', baja='1' where fol_det = '" + request.getParameter("fol_det") + "' ");
                con.insertar("update inventario set cant = '" + n_cant + "' where det_pro = '" + det_pro + "' ");
                con.insertar("insert into kardex values ('0', '" + id_rec + "', '" + det_pro + "', '" + cant_sur + "', 'REINTEGRA AL IVENTARIO', '-', NOW(), 'SE ELIMINA INSUMO DE RECETA', '" + sesion.getAttribute("id_usu") + "', '0'); ");
            } catch (Exception e) {
            }
            con.cierraConexion();
        } catch (Exception e) {
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
