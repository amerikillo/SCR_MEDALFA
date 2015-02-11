<%-- 
    Document   : RecetaFarm
    Created on : 25/11/2014, 04:45:27 PM
    Author     : CEDIS TOLUCA3
--%>

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


%>
<html>
    <%

    Connection conn; 
    Class.forName("com.mysql.jdbc.Driver"); 
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/scr_medalfa","root","eve9397");
    
    if(Tipo.equals("1")){
    System.out.println("Nombres:"+Usuario);
        
    File reporticket = new File(application.getRealPath("reportes/RecetaTicket.jasper"));   
    Map parameterticket= new HashMap();    
    parameterticket.put("folio",Folio);
    parameterticket.put("NomUsu",Usuario);
    JasperPrint jasperPrintticket= JasperFillManager.fillReport(reporticket.getPath(),parameterticket,conn);
    JasperPrintManager.printReport(jasperPrintticket,false);
    
    File reportfile = new File(application.getRealPath("reportes/RecetaFarm.jasper"));   
    Map parameter= new HashMap();    
    parameter.put("folio",Folio);
    System.out.println("FolioS22-->"+Folio);
    JasperPrint jasperPrint= JasperFillManager.fillReport(reportfile.getPath(),parameter,conn);
    JasperPrintManager.printReport(jasperPrint,true);
    
    out.println("<script>window.location='../farmacia/modSurteFarmacia.jsp'</script>");
    }else if (Tipo.equals("2")){
    File FileCol = new File(application.getRealPath("reportes/RecetaCol.jasper")); 
    Map paraCol= new HashMap();        
    paraCol.put("folio", Folio);    
    System.out.println("Folio33-->"+Folio);    
    
    /*byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter,conn);    
    response.setContentType("application/pdf"); response.setContentLength(bytes.length); ServletOutputStream outputStream= response.getOutputStream(); outputStream.write(bytes,0,bytes.length); 
    outputStream.flush(); outputStream.close();
     */
    JasperPrint jasperPrint= JasperFillManager.fillReport(FileCol.getPath(),paraCol,conn);
    JasperPrintManager.printReport(jasperPrint,false);
    
    out.println("<script>window.location='../farmacia/modSurteFarmaciaCol.jsp'</script>");
    
    }else{
    File reporticket = new File(application.getRealPath("reportes/RecetaTicket.jasper"));   
    Map parameterticket= new HashMap();    
    parameterticket.put("folio",Folio);
    parameterticket.put("NomUsu",Usuario);
    JasperPrint jasperPrintticket= JasperFillManager.fillReport(reporticket.getPath(),parameterticket,conn);
    JasperPrintManager.printReport(jasperPrintticket,false);
      out.println("<script>window.location='../farmacia/ReTicket.jsp'</script>");
    }
    conn.close();
    %>
</html>
