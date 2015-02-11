/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Calendario;

import Clases.ConectionDB;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.*;

/**
 *
 * @author Amerikillo
 */
public class Events extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        ConectionDB con = new ConectionDB();

        JSONObject json = new JSONObject();
        JSONArray jsona = new JSONArray();
        try {
            String ban = request.getParameter("ban");
            if (ban.equals("1")) {
                try {
                    con.conectar();
                    try {
                        ResultSet rset = con.consulta("SELECT * FROM eventos ORDER BY id;");
                        while (rset.next()) {
                            String start = "", end = "";
                            start = rset.getString("start");
                            end = rset.getString("end");
                            if (start == null) {
                                start = "0000-00-00 00:00:00.0";
                            }
                            if (end == null) {
                                end = "0000-00-00 00:00:00.0";
                            }
                            json.put("id", rset.getString("id"));
                            json.put("title", rset.getString("title"));
                            json.put("start", start);
                            json.put("end", end);
                            json.put("url", rset.getString("url"));
                            json.put("allDay", rset.getString("allDay"));
                            jsona.add(json);
                            json = new JSONObject();
                        }
                        response.setContentType("text/html;charset=UTF-8");
                        out.println(jsona);
                        System.out.println(jsona);
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }
                    con.cierraConexion();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
            if (ban.equals("2")) {
                try {
                    con.conectar();
                    try {
                        String start = request.getParameter("start");
                        String end = request.getParameter("end");

                        if (start.equals("")) {
                            start = "0000-00-00 00:00:00";
                        }
                        if (end.equals("")) {
                            end = "0000-00-00 00:00:00";
                        }

                        con.actualizar("UPDATE eventos SET title='" + request.getParameter("title") + "', start='" + start + "', end='" + end + "' WHERE id='" + request.getParameter("id") + "'");
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }

                    con.cierraConexion();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }
            if (ban.equals("3")) {
                System.out.println("entramos aqui");
                try {
                    con.conectar();
                    try {
                        String start = request.getParameter("start");
                        String end = request.getParameter("end");

                        if (start.equals("")) {
                            start = "0000-00-00 00:00:00";
                        }
                        if (end.equals("")) {
                            end = "0000-00-00 00:00:00";
                        }
                        System.out.println("INSERT INTO eventos (title, start, end, url) values ('" + request.getParameter("url") + " - " + request.getParameter("titulo1") + " - " + request.getParameter("titulo2") + "', '" + start + "', '" + end + "', '" + request.getParameter("url") + "' )");
                        con.actualizar("INSERT INTO eventos (title, start, end, url) values ('" + request.getParameter("url") + " - " + request.getParameter("titulo1") + " - " + request.getParameter("titulo2") + "', '" + start + "', '" + end + "', '" + request.getParameter("url") + "' )");
                        ResultSet rset = con.consulta("select id from eventos where title = '" + request.getParameter("title") + "' and start = '" + request.getParameter("start") + "' and end = '" + request.getParameter("end") + "' and url = '" + request.getParameter("url") + "' ");
                        while (rset.next()) {
                            json.put("id", rset.getString(1));
                            jsona.add(json);
                            json = new JSONObject();
                        }
                        response.setContentType("text/html;charset=UTF-8");
                        System.out.println(jsona);
                        out.println(jsona);
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }

                    con.cierraConexion();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }

            if (ban.equals("4")) {
                try {
                    con.conectar();
                    try {
                        con.actualizar(" delete from eventos where id =  " + request.getParameter("id") + "");
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }

                    con.cierraConexion();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }
            }

            if (ban.equals("5")) {
                try {
                    con.conectar();
                    try {
                        ResultSet rset = con.consulta("SELECT * FROM eventos where url like '%" + request.getParameter("medico") + "' ORDER BY id;");
                        while (rset.next()) {
                            json.put("id", rset.getString("id"));
                            json.put("title", rset.getString("title"));
                            json.put("start", rset.getString("start"));
                            json.put("end", rset.getString("end"));
                            json.put("url", rset.getString("url"));
                            json.put("allDay", rset.getString("allDay"));
                            jsona.add(json);
                            json = new JSONObject();
                        }
                        response.setContentType("text/html;charset=UTF-8");
                        out.println(jsona);
                        System.out.println(jsona);
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }
                    con.cierraConexion();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }

            }

            if (ban.equals("6")) {
                try {
                    con.conectar();
                    try {
                        ResultSet rset = con.consulta("SELECT * FROM eventos where title like '%" + request.getParameter("medico") + "%' ORDER BY id;");
                        while (rset.next()) {
                            json.put("id", rset.getString("id"));
                            json.put("title", rset.getString("title"));
                            json.put("start", rset.getString("start"));
                            json.put("end", rset.getString("end"));
                            json.put("url", rset.getString("url"));
                            json.put("allDay", rset.getString("allDay"));
                            jsona.add(json);
                            json = new JSONObject();
                        }
                        response.setContentType("text/html;charset=UTF-8");
                        out.println(jsona);
                        System.out.println(jsona);
                    } catch (Exception e) {
                        System.out.println(e.getMessage());
                    }
                    con.cierraConexion();
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                }

            }
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
