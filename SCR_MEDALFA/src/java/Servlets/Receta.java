/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Clases.ConectionDB;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.*;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Americo
 */
public class Receta extends HttpServlet {

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

        try {

            if (request.getParameter("encargado") != null) {
                /*
                 *Para Receta Colectiva
                 */
                DateFormat df2 = new SimpleDateFormat("dd/MM/yyyy");
                DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                ConectionDB con = new ConectionDB();
                JSONObject json = new JSONObject();
                JSONArray jsona = new JSONArray();
                con.conectar();
                HttpSession sesion = request.getSession(true);
                String folio_rec = request.getParameter("folio");
                String id_rec = "";
                if (folio_rec.equals("")) {
                    try {
                        ResultSet rset = con.consulta("select id_rec from indices");
                        while (rset.next()) {
                            id_rec = rset.getString(1);
                        }
                        if (id_rec.equals("")) {
                            con.actualizar("insert into indices (id_rec) values ('2')");
                            id_rec = "1";
                        } else {
                            con.actualizar("update indices set id_rec= '" + (Integer.parseInt(id_rec) + 1) + "' ");
                        }
                        json.put("fol_rec", id_rec);
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }
                    out.println();
                    sesion.setAttribute("folio_rec", id_rec);
                    folio_rec = id_rec;
                } else {
                    json.put("fol_rec", folio_rec);
                }
                try {
                    int ban = 0;
                    ResultSet rset2 = con.consulta("select id_rec from receta where fol_rec = '" + folio_rec + "' ");
                    while (rset2.next()) {
                        ban = 1;
                    }
                    if (ban == 0) {
                        con.insertar("insert into receta values ('0', '" + folio_rec + "', '0', '-', '2', '" + sesion.getAttribute("id_usu") + "', '" + request.getParameter("encargado") + "', '-', '" + request.getParameter("select_serv") + "', NOW(), '1', '0', '0')");
                    }
                    try {
                        System.out.println(request.getParameter("btn_clave"));
                        if (request.getParameter("btn_clave").equals("1")) {
                            ResultSet rset = con.consulta("select des_pro, amp_pro from productos where cla_pro = '" + request.getParameter("cla_pro") + "' ");
                            while (rset.next()) {
                                json.put("des_pro", rset.getString(1));
                                json.put("amp_pro", rset.getString(2));
                            }
                            rset = con.consulta("SELECT sum(i.cant)\n"
                                    + "FROM productos p, detalle_productos dp, inventario i\n"
                                    + "WHERE\n"
                                    + "p.cla_pro = dp.cla_pro\n"
                                    + "and dp.det_pro = i.det_pro\n"
                                    + "and p.cla_pro='" + request.getParameter("cla_pro") + "'\n"
                                    + ";");
                            while (rset.next()) {
                                json.put("total", rset.getString(1));
                            }

                            rset = con.consulta("SELECT sum(i.cant)\n"
                                    + "FROM productos p, detalle_productos dp, inventario i\n"
                                    + "WHERE\n"
                                    + "p.cla_pro = dp.cla_pro\n"
                                    + "and dp.det_pro = i.det_pro\n"
                                    + "and dp.id_ori = '1'\n"
                                    + "and p.cla_pro='" + request.getParameter("cla_pro") + "'\n"
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
                                    + "and p.cla_pro='" + request.getParameter("cla_pro") + "'\n"
                                    + ";");
                            while (rset.next()) {
                                json.put("origen2", rset.getString(1));
                            }

                            con.cierraConexion();
                            jsona.add(json);
                            json = new JSONObject();
                        }
                    } catch (Exception e) {
                    }
                    try {
                        System.out.println(request.getParameter("btn_descripcion"));
                        if (request.getParameter("btn_descripcion").equals("1")) {
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
                        }
                    } catch (Exception e) {
                    }

                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
                System.out.println(jsona);
                out.println(jsona);
                con.cierraConexion();
            } else {
                /*
                 *Para Receta Farmacia
                 */
                DateFormat df2 = new SimpleDateFormat("dd/MM/yyyy");
                DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                ConectionDB con = new ConectionDB();
                JSONObject json = new JSONObject();
                JSONArray jsona = new JSONArray();
                con.conectar();
                HttpSession sesion = request.getSession(true);
                String folio_sp = request.getParameter("sp_pac");
                String folio_rec = request.getParameter("folio");
                String id_rec = "";
                if (folio_rec.equals("")) {
                    try {
                        ResultSet rset = con.consulta("select id_rec from indices");
                        while (rset.next()) {
                            id_rec = rset.getString(1);
                        }
                        if (id_rec.equals("")) {
                            con.actualizar("insert into indices (id_rec) values ('2')");
                            id_rec = "1";
                        } else {
                            con.actualizar("update indices set id_rec= '" + (Integer.parseInt(id_rec) + 1) + "' ");
                        }
                        json.put("fol_rec", id_rec);
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }
                    out.println();
                } else {
                    json.put("fol_rec", folio_rec);
                }
                int ban = 0;
                try {
                        //ResultSet rset = con.consulta("select id_pac, nom_com, sexo, fec_nac, num_afi from pacientes where num_afi = '" + request.getParameter("sp_pac") + "' ");
                    ResultSet rset = con.consulta("select id_pac, nom_com, sexo, fec_nac, num_afi,expediente from pacientes where num_afi = '" + request.getParameter("sp_pac") + "' ");
                    while (rset.next()) {
                        ban = 1;

                        sesion.setAttribute("folio_rec", folio_rec);
                        sesion.setAttribute("id_pac", rset.getString(1));
                        sesion.setAttribute("nom_com", rset.getString(2));
                        sesion.setAttribute("sexo", rset.getString(3));
                        sesion.setAttribute("fec_nac", df2.format(df.parse(rset.getString(4))));
                        sesion.setAttribute("num_afi", rset.getString(5));
                        sesion.setAttribute("carnet", rset.getString(6));
                        json.put("id_pac", rset.getString(1));
                        json.put("nom_com", rset.getString(2));
                        json.put("sexo", rset.getString(3));
                        json.put("fec_nac", df2.format(df.parse(rset.getString(4))));
                        json.put("num_afi", rset.getString(5));
                        json.put("carnet", rset.getString(6));
                        json.put("mensaje", "");
                        jsona.add(json);
                        json = new JSONObject();
                    }
                    if (ban == 0) {
                        json.put("id_pac", "");
                        json.put("nom_com", "");
                        json.put("sexo", "");
                        json.put("fec_nac", "");
                        json.put("num_afi", "");
                        json.put("carnet", "");
                        json.put("mensaje", "Paciente inexistente");
                        jsona.add(json);
                        json = new JSONObject();
                    }
                } catch (Exception e) {
                }

                System.out.println((String) sesion.getAttribute("folio_rec"));

                con.cierraConexion();
                out.println(jsona);
                System.out.println(jsona);
            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        /*String folio_sp = request.getParameter("sp_pac");
         System.out.println(folio_sp);
         out.println(folio_sp);*/
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
