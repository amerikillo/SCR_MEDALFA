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
public class Usuarios extends HttpServlet {

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
                String Unidad="";
                byte[] a = request.getParameter("ape_pat").getBytes("ISO-8859-1");
                String ape_pat = new String(a, "UTF-8");
                a = request.getParameter("ape_mat").getBytes("ISO-8859-1");
                String ape_mat = new String(a, "UTF-8");
                a = request.getParameter("nombre").getBytes("ISO-8859-1");
                String nombre = new String(a, "UTF-8");
                String  completo = ape_pat.toUpperCase() + " " + ape_mat.toUpperCase() + " " + nombre.toUpperCase();
                
                ResultSet rset1 = con.consulta("SELECT cla_uni FROM unidades");
                if(rset1.next()){
                    Unidad = rset1.getString("cla_uni");
                }
                
                ResultSet rset = con.consulta("select id_usu from usuarios WHERE user='"+request.getParameter("usuario")+"'");
                
                while(rset.next()){
                    foliop = Integer.parseInt(rset.getString("id_usu"));
                    cont++;
                }
                if (cont > 0){
                    json.put("mensaje", "Usuario Existente, Clave Usuario= "+foliop+"");
                    json.put("ban","1");
                }else{
                    //if (Tipo == 1 || Tipo == 3){
                        con.insertar("insert into usuarios values('0','" + (ape_pat.toUpperCase() + " " + ape_mat.toUpperCase() + " " + nombre.toUpperCase()) + "','"+request.getParameter("usuario")+"',PASSWORD('"+request.getParameter("passw")+"'),'1','1','" +Unidad+ "', '-');");
                    /*}else{
                        con.insertar("insert into usuarios values('0','" + (ape_pat.toUpperCase() + " " + ape_mat.toUpperCase() + " " + nombre.toUpperCase()) + "','"+request.getParameter("usuario")+"',PASSWORD('"+request.getParameter("passw")+"'),'"+Tipo+"','1','" +Unidad+ "', '" + request.getParameter("select_medico") + "');");
                    }*/
                
                ResultSet rset2 = con.consulta("select id_usu from usuarios WHERE user='"+request.getParameter("usuario")+"'");
                while(rset2.next()){
                    foliop = Integer.parseInt(rset2.getString("id_usu"));
                    
                }
                json.put("mensaje", "Usuario guardado correctamente con la Clave "+foliop+" ");                
                json.put("ban","1");
                }
            } catch (Exception e) {
                json.put("mensaje", "El Usuario no se pudo dar de alta");
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
