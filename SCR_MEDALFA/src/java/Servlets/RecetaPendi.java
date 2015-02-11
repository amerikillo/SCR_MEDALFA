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
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
public class RecetaPendi extends HttpServlet {

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
        String fecha1 = df.format(new Date());
        String fecha2 = "2050-01-01";
        System.out.println("hola");
        try {
            con.conectar();
            try {
                int sol = Integer.parseInt(request.getParameter("can_sol"));
                int sur = sol;
                int sol1 = 0;
                String causes = "998";
                System.out.println("causes");
                /*byte[] a = request.getParameter("causes").getBytes("UTF-8");
                String causes_L = new String(a, "UTF-8");
                ResultSet rset_cau = con.consulta("select id_cau from causes where des_cau = '" + causes_L + "' ");
                while (rset_cau.next()) {
                    causes = rset_cau.getString(1);
                }*/
               
                String det_pro = "";
                String id_rec = "";
                String id_tip = "";
                //ResultSet rset = con.consulta("select r.id_rec, id_tip from receta r, usuarios us, unidades un where r.fol_rec = '" + request.getParameter("folio") + "' and r.cedula = '" + request.getParameter("cedula") + "' and r.id_usu = us.id_usu and us.cla_uni = un.cla_uni and un.des_uni = '" + request.getParameter("uni_ate") + "' ");
                ResultSet rset = con.consulta("select r.id_rec, id_tip from receta r where r.fol_rec = '" + request.getParameter("folio") + "'");
                while (rset.next()) {
                    id_rec = rset.getString(1);
                    id_tip = rset.getString(2);
                }
                   System.out.println("tipoooooo"+id_tip);
                System.out.println("----------------****" + id_rec);
                con.insertar("update receta set baja = '0', transito = '1'  where id_rec = "+id_rec+" ");
               
                rset = con.consulta("SELECT i.id_inv, DP.det_pro, P.cla_pro, P.des_pro, DP.cad_pro, DP.lot_pro, I.cant, DP.cla_fin, DP.id_ori FROM detalle_productos DP, productos P, inventario I, unidades U, usuarios US WHERE DP.cla_pro = P.cla_pro AND DP.det_pro = I.det_pro AND I.cla_uni = U.cla_uni AND US.cla_uni = U.cla_uni AND P.cla_pro = '" + request.getParameter("cla_pro") + "' AND US.id_usu='" + sesion.getAttribute("id_usu") + "' and DP.cad_pro between '"+fecha1+"' and '"+fecha2+"' ORDER BY  DP.id_ori, DP.cad_pro, I.cant ASC ");
                    while (rset.next()) {
                        det_pro = rset.getString("det_pro");
                        if (Integer.parseInt(rset.getString("cant")) > 0) {
                            sol1 = sol;
                            sol = sol - Integer.parseInt(rset.getString("cant"));
                            if (sol <= 0) {
                                if (sol == 0) {
                                    sur = Integer.parseInt(rset.getString("cant"));

                                    con.insertar("insert into detreceta values ('0', '" + rset.getString("det_pro") + "', '" + request.getParameter("can_sol") + "', '" + sur + "', '" + df.format(df2.parse(request.getParameter("fecha"))) + "', '1', '" + id_rec + "', CURTIME(), '" + causes + "','" + request.getParameter("unidades") + " UNIDADES CADA " + request.getParameter("horas") + " HORAS POR " + request.getParameter("dias") + " DIAS = " + request.getParameter("piezas_sol") + " UNIDADES', '0', '0' ) ");
                                    con.insertar("insert into kardex values ('0', '" + id_rec + "', '" + rset.getString("det_pro") + "', '" + sur + "', 'SALIDA RECETA', '-', NOW(), 'SALIDA POR RECETA COL', '" + sesion.getAttribute("id_usu") + "', '0')");
                                    con.insertar("update inventario set cant = '0', web = '0' where id_inv = '" + rset.getString("id_inv") + "' ");
                                }
                                if (sol < 0) {
                                    sur = sol * -1;
                                    con.insertar("insert into detreceta values ('0', '" + rset.getString("det_pro") + "', '" + (sol1) + "', '" + (sol1) + "', '" + df.format(df2.parse(request.getParameter("fecha"))) + "', '1', '" + id_rec + "', CURTIME(), '" + causes + "','" + request.getParameter("unidades") + " UNIDADES CADA " + request.getParameter("horas") + " HORAS POR " + request.getParameter("dias") + " DIAS = " + request.getParameter("piezas_sol") + " UNIDADES', '0', '0' ) ");
                                    con.insertar("insert into kardex values ('0', '" + id_rec + "', '" + rset.getString("det_pro") + "', '" + sol1 + "', 'SALIDA RECETA', '-', NOW(), 'SALIDA POR RECETA COL', '" + sesion.getAttribute("id_usu") + "', '0')");
                                    con.insertar("update inventario set cant = '" + (-1 * sol) + "', web = '0' where id_inv = '" + rset.getString("id_inv") + "' ");
                                }
                                break;
                            }
                            con.insertar("insert into detreceta values ('0', '" + rset.getString("det_pro") + "', '" + rset.getString("cant") + "', '" + rset.getString("cant") + "', '" + df.format(df2.parse(request.getParameter("fecha"))) + "', '1', '" + id_rec + "', CURTIME(), '" + causes + "','" + request.getParameter("unidades") + " UNIDADES CADA " + request.getParameter("horas") + " HORAS POR " + request.getParameter("dias") + " DIAS = " + request.getParameter("piezas_sol") + " UNIDADES', '0', '0' ) ");
                            con.insertar("insert into kardex values ('0', '" + id_rec + "', '" + rset.getString("det_pro") + "', '" + rset.getString("cant") + "', 'SALIDA RECETA', '-', NOW(), 'SALIDA POR RECETA COL', '" + sesion.getAttribute("id_usu") + "', '0')");
                            con.insertar("update inventario set cant = '0', web = '0' where id_inv = '" + rset.getString("id_inv") + "' ");
                        } else {
                        }
                    }
                    if (sol > 0) {
                        if (!(det_pro != "")){
                            ResultSet rset2 = con.consulta("SELECT det_pro FROM detalle_productos where cla_pro='"+request.getParameter("cla_pro")+"' GROUP BY cla_pro");
                            if(rset2.next()){
                                det_pro = rset2.getString(1);
                            }
                        }
                        con.insertar("insert into detreceta values ('0', '" + det_pro + "', '" + sol + "', '0', '" + df.format(df2.parse(request.getParameter("fecha"))) + "', '0', '" + id_rec + "', CURTIME(), '" + causes + "','" + request.getParameter("unidades") + " UNIDADES CADA " + request.getParameter("horas") + " HORAS POR " + request.getParameter("dias") + " DIAS = " + request.getParameter("piezas_sol") + " UNIDADES', '0', '0' ) ");
                        con.insertar("insert into kardex values ('0', '" + id_rec + "', '" + det_pro + "', '0', 'SALIDA RECETA', '-', NOW(), 'SALIDA POR RECETA COL', '" + sesion.getAttribute("id_usu") + "', '0')");
                    }
                 

            } catch (Exception e) {
                System.out.println(e.getMessage());
            }

            try {
                ResultSet rset = con.consulta("SELECT dr.fol_det, p.cla_pro, p.des_pro, dp.lot_pro, dp.cad_pro, dr.can_sol, dr.cant_sur, dr.status, o.des_ori from productos p, detalle_productos dp, detreceta dr, receta r, origen o where dr.baja !='1' and p.cla_pro = dp.cla_pro and dp.det_pro = dr.det_pro AND dr.id_rec = r.id_rec AND dp.id_ori = o.id_ori AND r.fol_rec = '" + request.getParameter("folio") + "' and r.id_usu = '" + sesion.getAttribute("id_usu") + "' ;");
                while (rset.next()) {
                    json.put("fol_det", rset.getString("fol_det"));
                    json.put("cla_pro", rset.getString("cla_pro"));
                    json.put("des_pro", rset.getString("des_pro"));
                    json.put("can_sol", rset.getString("can_sol"));
                    json.put("cant_sur", rset.getString("cant_sur"));
                    jsona.add(json);
                    json = new JSONObject();
                }
                out.println(jsona);
                System.out.println(jsona);
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }

            con.cierraConexion();
        } catch (SQLException e) {
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
