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
public class RecetaNueva2 extends HttpServlet {

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
        JSONObject json = new JSONObject();
        JSONArray jsona = new JSONArray();
        HttpSession sesion = request.getSession(true);
        String fecha1 = df.format(new Date());
        String NombreUsu="";
        String usuario = (String) sesion.getAttribute("id_usu");
        String folio = (String) sesion.getAttribute("folio_rec");
        System.out.println("hola");
        ConectionDB con = new ConectionDB();
            String ban ="";
          
            ban = request.getParameter("btn_nueva");
            
            if (ban.equals("1")){
                
                try {
                     con.conectar();
                     ResultSet RsetUsu = con.consulta("SELECT nombre FROM usuarios WHERE id_usu='"+usuario+"'");
                     if(RsetUsu.next()){
                         NombreUsu = RsetUsu.getString(1);
                     }
                     con.cierraConexion();
                }catch(Exception e){}
                if(folio !=""){
                out.println("<script>window.open('reportes/RecetaFarm.jsp?fol_rec="+folio+"&tipo=4&usuario="+NombreUsu+"', '', 'width=1200,height=800,left=50,top=50,toolbar=no');</script>");
                }
                sesion.setAttribute("folio_rec", "");
                sesion.setAttribute("nom_com", "");
                sesion.setAttribute("sexo", "");
                sesion.setAttribute("fec_nac", "");
                sesion.setAttribute("num_afi", "");
                //response.sendRedirect("receta/receta_farmacia.jsp");
                out.println("<script>window.location='receta/receta_farmacia.jsp'</script>");
                
            }else if(ban.equals("2")){
                sesion.setAttribute("folio_rec", "");
                response.sendRedirect("receta/receta_colectiva.jsp");
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
