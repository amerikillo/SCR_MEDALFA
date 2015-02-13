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
public class MuestraInsumosReceta extends HttpServlet {

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

        DateFormat df2 = new SimpleDateFormat("dd/MM/yyyy");
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        ConectionDB con = new ConectionDB();
        JSONObject json = new JSONObject();
        JSONArray jsona = new JSONArray();
        HttpSession sesion = request.getSession(true);

        try {
            con.conectar();
            try {
                //ResultSet rset = con.consulta("SELECT dr.fol_det, p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, dr.can_sol, dr.cant_sur, dr.status, o.des_ori from productos p, detalle_productos dp, detreceta dr, receta r, origen o where dr.baja !='1' and p.cla_pro = dp.cla_pro and dp.det_pro = dr.det_pro AND dr.id_rec = r.id_rec AND dp.id_ori = o.id_ori AND r.fol_rec = '" + request.getParameter("folio") + "' and r.id_usu = '" + sesion.getAttribute("id_usu") + "' ;");
                ResultSet rset = con.consulta("SELECT dr.fol_det, p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, dr.can_sol, dr.cant_sur, dr.status, o.des_ori,o.id_ori from productos p, detalle_productos dp, detreceta dr, receta r, origen o where dr.baja !='1' and p.cla_pro = dp.cla_pro and dp.det_pro = dr.det_pro AND dr.id_rec = r.id_rec AND dp.id_ori = o.id_ori AND r.fol_rec = '" + sesion.getAttribute("folio_rec") + "' and r.id_usu = '" + sesion.getAttribute("id_usu") + "' ;");
                while (rset.next()) {
                    json.put("fol_det", rset.getString("fol_det"));
                    json.put("cla_pro", rset.getString("cla_pro"));
                    json.put("des_pro", rset.getString("des_pro"));
                    json.put("lot_pro", rset.getString("lot_pro"));
                    json.put("cad_pro", df2.format(df.parse(rset.getString("cad_pro"))));
                    json.put("can_sol", rset.getString("can_sol"));
                    json.put("cant_sur", rset.getString("cant_sur"));
                    json.put("id_ori", rset.getString("id_ori"));
                    jsona.add(json);
                    json = new JSONObject();
                }
                out.println(jsona);
                System.out.println(jsona);
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
