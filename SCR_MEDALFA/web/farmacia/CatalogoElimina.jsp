<%-- 
    Document   : index
    Created on : 07-mar-2014, 15:38:43
    Author     : Americo
--%>

<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Clases.ConectionDB"%>

<%java.text.DateFormat df2 = new java.text.SimpleDateFormat("yyyy-MM-dd"); %>
<%java.text.DateFormat df3 = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
   
    ConectionDB con = new ConectionDB();
    HttpSession sesion = request.getSession();
    String id_usu = "";
    try {
        id_usu = (String) session.getAttribute("id_usu");
    } catch (Exception e) {
    }

    if (id_usu == null) {
        response.sendRedirect("index.jsp");
    }

  String clave="";
    try {
        clave = request.getParameter("clave");        
    } catch (Exception e) {
    }
    
    try {
        con.conectar();
        con.actualizar("update productos set f_status='S' where cla_pro='"+clave+"'");
        out.println("<script>window.location='CatalogoMedica.jsp'</script>");
        con.cierraConexion();
    } catch (Exception e) {}
%>
<!DOCTYPE html>
<html>
    <head>
       
    </head>
    <body>
        

        
    </body>
    
</html>

