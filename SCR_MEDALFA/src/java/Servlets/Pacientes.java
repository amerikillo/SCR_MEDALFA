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
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Americo
 */
public class Pacientes extends HttpServlet {

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
        try {
            JSONObject json = new JSONObject();
            JSONArray jsona = new JSONArray();

            DateFormat df2 = new SimpleDateFormat("dd/MM/yyyy");
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            con.conectar();

            try {
                int cont=0,foliop=0;
                
                byte[] a = request.getParameter("ape_pat").getBytes("ISO-8859-1");
                String ape_pat = new String(a, "UTF-8");
                a = request.getParameter("ape_mat").getBytes("ISO-8859-1");
                String ape_mat = new String(a, "UTF-8");
                a = request.getParameter("nombre").getBytes("ISO-8859-1");
                String nombre = new String(a, "UTF-8");
                String  completo = ape_pat.toUpperCase() + " " + ape_mat.toUpperCase() + " " + nombre.toUpperCase(); 
                ResultSet rset = con.consulta("SELECT id_pac FROM pacientes WHERE nom_com='"+completo+"'");
                while(rset.next()){
                    foliop = Integer.parseInt(rset.getString("id_pac"));
                    cont++;
                }
                if (cont > 0){
                    json.put("mensaje", "Paciente Existente, Folio Paciente= "+foliop+"");
                    json.put("ban","1");
                }else{
                String TipCob = request.getParameter("tip_cob");
                String ini_vig="", fin_vig="";
                if (TipCob != "SP"){
                    ini_vig = "2010-01-01";
                    fin_vig = "2050-12-31";
                }else{
                  ini_vig = request.getParameter("ini_vig");  
                  fin_vig = request.getParameter("fin_vig");
                }
                con.insertar("insert into pacientes values('0', '" + ape_pat.toUpperCase() + "', '" + ape_mat.toUpperCase() + "', '" + nombre.toUpperCase() + "', '" + (ape_pat.toUpperCase() + " " + ape_mat.toUpperCase() + " " + nombre.toUpperCase()) + "', '" + request.getParameter("fec_nac") + "', '" + request.getParameter("sexo").toUpperCase() + "', '" + request.getParameter("no_afi") + "', '" + request.getParameter("tip_cob") + "', '" + ini_vig + "', '" + fin_vig + "', '0', '" + request.getParameter("no_exp") + "', 'A');");
                ResultSet rset2 = con.consulta("SELECT id_pac FROM pacientes WHERE nom_com='"+completo+"'");
                while(rset2.next()){
                    foliop = Integer.parseInt(rset2.getString("id_pac"));
                    
                }
                json.put("mensaje", "Paciente guardado correctamente con el folio "+foliop+" ");                
                json.put("ban","1");
                }
            } catch (Exception e) {
                json.put("mensaje", "El paciente no se pudo dar de alta");
                System.out.println(e.getMessage());
            }
            out.println();

            con.cierraConexion();
            jsona.add(json);
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
