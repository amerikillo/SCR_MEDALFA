<%-- 
    Document   : RecetaFarm
    Created on : 25/11/2014, 04:45:27 PM
    Author     : CEDIS TOLUCA3
--%>

<%@page import="net.sf.jasperreports.view.JasperViewer"%>
<%@page import="net.sf.jasperreports.engine.util.JRLoader"%>
<%@page import="java.net.URL"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.io.*"%> 
<%@page import="java.util.HashMap"%> 
<%@page import="java.util.Map"%> 
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%

String Folio="",Tipo="",Usuario="";
try {
Folio = request.getParameter("fol_rec");
Tipo = request.getParameter("tipo");
Usuario = request.getParameter("usuario");
} catch (Exception e) {
}

String Imagen="imagen/isem.png";
String Imagen2="imagen/mlogo.png";
String Imagen3="imagen/gobierno.png";
String Reporte="RecetaFarmR.jasper";


%>

<html>
    <img src="imagen/medalfalogo2.png" width=100 heigth=100>
    <%

    Connection conn; 
    Class.forName("com.mysql.jdbc.Driver"); 
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scr_medalfa","root","eve9397");
    
    if(Tipo.equals("1")){
    System.out.println("Nombres:"+Usuario);
    
    File reportfile = new File(application.getRealPath("reportes/RecetaFarm.jasper"));   
    Map parameter= new HashMap();    
    parameter.put("folio",Folio);
    parameter.put("logo1",Imagen);
    parameter.put("logo2",Imagen2);
    parameter.put("logo3",Imagen3);
    parameter.put("reporte",Reporte);
    System.out.println("FolioS22-->"+Folio);
    JasperPrint jasperPrint= JasperFillManager.fillReport(reportfile.getPath(),parameter,conn);
    JasperPrintManager.printReport(jasperPrint,true);
    
    out.println("<script>window.location='../farmacia/modSurteFarmacia.jsp'</script>");
    }else if (Tipo.equals("2")){
    File FileCol = new File(application.getRealPath("reportes/RecetaCol.jasper")); 
    Map paraCol= new HashMap();        
    paraCol.put("folio", Folio);    
    System.out.println("Folio33-->"+Folio);    
    
    JasperPrint jasperPrint= JasperFillManager.fillReport(FileCol.getPath(),paraCol,conn);
    JasperPrintManager.printReport(jasperPrint,false);
    
    out.println("<script>window.location='../farmacia/modSurteFarmaciaCol.jsp'</script>");
    
    }else if (Tipo.equals("2")){
        File reporticket = new File(application.getRealPath("reportes/RecetaTicket.jasper"));   
        Map parameterticket= new HashMap();    
        parameterticket.put("folio",Folio);
        parameterticket.put("NomUsu",Usuario);
        JasperPrint jasperPrintticket= JasperFillManager.fillReport(reporticket.getPath(),parameterticket,conn);
        JasperPrintManager.printReport(jasperPrintticket,false);
        out.println("<script>window.location='../farmacia/ReTicket.jsp'</script>");
    }else{
        File reporticket = new File(application.getRealPath("reportes/RecetaTicket.jasper"));   
        Map parameterticket= new HashMap();    
        parameterticket.put("folio",Folio);
        parameterticket.put("NomUsu",Usuario);
        JasperPrint jasperPrintticket= JasperFillManager.fillReport(reporticket.getPath(),parameterticket,conn);
        JasperPrintManager.printReport(jasperPrintticket,false);
        %>
        <script type="text/javascript">
            var ventana = window.self; 
            ventana.opener = window.self; 
            setTimeout("window.close()", 2000);
        </script>
    <%
    }
    conn.close();
    %>
</html>
