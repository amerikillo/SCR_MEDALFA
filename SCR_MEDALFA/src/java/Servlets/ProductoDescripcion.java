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
public class ProductoDescripcion extends HttpServlet {

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
            DateFormat df2 = new SimpleDateFormat("dd/MM/yyyy");
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            ConectionDB con = new ConectionDB();
            JSONObject json = new JSONObject();
            JSONArray jsona = new JSONArray();
            con.conectar();
            try {

                /*
                 *Seccion para insertar a la tabla Receta
                 */
                try {
                    con.conectar();

                    try {

                        int ban = 0;
                        String id_pac = "";
                        String id_rec = "";
                        byte[] a = request.getParameter("nom_pac").getBytes("ISO-8859-1");
                        String nombre = new String(a, "UTF-8");
                        a = request.getParameter("carnet").getBytes("ISO-8859-1");
                        String carnet = new String(a, "UTF-8");
                        ResultSet rset = con.consulta("select id_pac from pacientes where nom_com = '" + nombre + "' and num_afi = '" + request.getParameter("fol_sp") + "' ");
                        while (rset.next()) {
                            id_pac = rset.getString(1);
                        }

                        rset = con.consulta("select r.id_rec from receta r, usuarios us, unidades un where r.fol_rec = '" + request.getParameter("folio") + "' and r.cedula = '" + request.getParameter("cedula") + "' and r.id_tip = '1' and r.id_usu = us.id_usu and us.cla_uni = un.cla_uni and un.des_uni = '" + request.getParameter("uni_ate") + "' ");
                        while (rset.next()) {
                            ban = 1;
                            id_rec = rset.getString(1);
                        }

                        /*
                         *Si ya existe la receta actualiza campos
                         */
                        if (carnet.equals("")) {
                            carnet = "-";
                        }
                        
                        json.put("carnet", carnet);
                        if (ban == 1) {
                            con.insertar("update receta set id_pac = '" + id_pac + "', cedula='" + request.getParameter("cedula") + "', carnet= '" + carnet + "' where id_rec= '" + id_rec + "'");
                        } else {//Si no inserta la receta
                            con.insertar("insert into receta values ('0', '" + request.getParameter("folio") + "', '" + id_pac + "', '" + request.getParameter("cedula") + "', '1', '" + sesion.getAttribute("id_usu") + "', '-', '" + carnet + "', '1', NOW(),'1', '0', '0')");
                        }

                    } catch (Exception e) {
                    }

                } catch (Exception e) {
                }

                /*
                 *Devuelve datos de la clave solicitada
                 */
                ResultSet rset = con.consulta("select cla_pro, amp_pro from productos where des_pro = '" + request.getParameter("des_pro") + "' ");
                while (rset.next()) {
                    json.put("cla_pro", rset.getString(1));
                    json.put("amp_pro", rset.getString(2));
                }
                rset = con.consulta("SELECT sum(i.cant)\n"
                        + "FROM productos p, detalle_productos dp, inventario i\n"
                        + "WHERE\n"
                        + "p.cla_pro = dp.cla_pro\n"
                        + "and dp.det_pro = i.det_pro\n"
                        + "and p.des_pro='" + request.getParameter("des_pro") + "'\n"
                        + ";");
                while (rset.next()) {
                    json.put("total", rset.getString(1));
                }
                
                rset = con.consulta("SELECT sum(i.cant)\n"
                        + "FROM productos p, detalle_productos dp, inventario i\n"
                        + "WHERE\n"
                        + "p.cla_pro = dp.cla_pro\n"
                        + "and dp.det_pro = i.det_pro\n"
                        + "and dp.id_ori = '0'\n"
                        + "and p.des_pro='" + request.getParameter("des_pro") + "'\n"
                        + ";");
                while (rset.next()) {
                    json.put("origen0", rset.getString(1));
                }

                rset = con.consulta("SELECT sum(i.cant)\n"
                        + "FROM productos p, detalle_productos dp, inventario i\n"
                        + "WHERE\n"
                        + "p.cla_pro = dp.cla_pro\n"
                        + "and dp.det_pro = i.det_pro\n"
                        + "and dp.id_ori = '1'\n"
                        + "and p.des_pro='" + request.getParameter("des_pro") + "'\n"
                        + ";");
                while (rset.next()) {
                    json.put("origen1", rset.getString(1));
                }

                rset = con.consulta("SELECT sum(i.cant)\n"
                        + "FROM productos p, detalle_productos dp, inventario i\n"
                        + "WHERE\n"
                        + "p.cla_pro = dp.cla_pro\n"
                        + "and dp.det_pro = i.det_pro\n"
                        + "and dp.id_ori = '2'\n"
                        + "and p.des_pro='" + request.getParameter("des_pro") + "'\n"
                        + ";");
                while (rset.next()) {
                    json.put("origen2", rset.getString(1));
                }

                con.cierraConexion();
                jsona.add(json);
                json = new JSONObject();
            } catch (Exception e) {
            }
            con.cierraConexion();
            out.println(jsona);
            System.out.println(jsona);

        } catch (Exception e) {
            System.out.println(e.getMessage());
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
