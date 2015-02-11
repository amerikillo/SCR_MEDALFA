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
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Americo
 */
public class Farmacias extends HttpServlet {

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
        DateFormat df2 = new SimpleDateFormat("dd/MM/yyyy");
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        HttpSession sesion = request.getSession(true);
        String fecha1 = df.format(new Date());
        String fecha2 = "2050-01-01";
        
        try {
            String NombreUsu="";
            String usuario = (String) sesion.getAttribute("id_usu");
           
            /*
             * Para el Surtido de la Receta
             */
            if (request.getParameter("accion").equals("surtir")) {
                con.conectar();
                String idtip="";
                try {
                     ResultSet RsetUsu = con.consulta("SELECT nombre FROM usuarios WHERE id_usu='"+usuario+"'");
                     if(RsetUsu.next()){
                         NombreUsu = RsetUsu.getString(1);
                     }
                     System.out.println(NombreUsu);
                    String fol_det2 = request.getParameter("fol_det");
                    System.out.println(fol_det2);
                    String folios2[] = fol_det2.split(",");                
                    for (int x = 0; x < folios2.length; x++) {
                        if (!folios2[x].equals("")) {
                            String sol2 = request.getParameter("sol_" + folios2[x]);
                            String sur2 = request.getParameter("sur_" + folios2[x]);
                            if (Integer.parseInt(sur2)== Integer.parseInt(sol2)) {
                                con.insertar("update receta set transito = '0' where id_rec = '" + request.getParameter("id_rec") + "'  ");                    
                            }else{
                                con.insertar("update receta set transito = '0',baja='2' where id_rec = '" + request.getParameter("id_rec") + "'  ");
                            }
                            out.println("<script>alert('Se surtió la receta con folio: " + request.getParameter("fol_rec") + " correctamente.')</script>");
                            ResultSet rset = con.consulta("SELECT id_tip FROM receta WHERE fol_rec='"+request.getParameter("fol_rec")+"' GROUP BY id_tip");
                            if(rset.next()){
                                idtip = rset.getString("id_tip");
                            }
                        }
                    }                    
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                    out.println("<script>alert('Error al surtir la receta')</script>");
                }
                con.cierraConexion();
                out.println("<script>window.location='reportes/RecetaFarm.jsp?fol_rec=" + request.getParameter("fol_rec") + "&tipo="+idtip+"&usuario="+NombreUsu+"'</script>");
                //out.println("<script>window.location='reportes/TicketReceta.jsp?fol_rec=" + request.getParameter("fol_rec") + "'</script>");
                
                out.println("<script>window.location='farmacia/modSurteFarmacia.jsp'</script>");
            } 
            /*
             * Para el Surtido de la Receta Pendientes
             */
            if (request.getParameter("accion").equals("surtir2")) {
                con.conectar();
                ResultSet rset = null;
                ResultSet rset2 = null;
                ResultSet rset3 = null;
                ResultSet rset4 = null;
                ResultSet rset5 = null;
                String idtip="";
                String det_pro = "",causes="",lote="",cadu="",clapro="",indica="",folio="",existt="";
                int sol1 = 0,cont=0,exist=0,total2=0,dife=0,cansol=0,cansur=0,totalp=0,totaldife=0,surc=0;
                try {                    
                    String fol_det2 = request.getParameter("fol_det");
                    System.out.println(fol_det2);
                    String folios2[] = fol_det2.split(",");                       
                    for (int x = 0; x < folios2.length; x++) {
                        if (!folios2[x].equals("")) {                            
                            String sol2 = request.getParameter("sol_" + folios2[x]);
                            String sur1 = request.getParameter("sur1_" + folios2[x]);
                            String sur2 = request.getParameter("sur_" + folios2[x]);
                            String clave = request.getParameter("clave_" + folios2[x]);
                            
                            int sol21= Integer.parseInt(sol2);
                            int sur12= Integer.parseInt(sur1);
                            int sur21= Integer.parseInt(sur2);
                            int sur = sur21;
                            int total = sur12 + sur21;
                            rset5 = con.consulta("SELECT i.id_inv, DP.det_pro, P.cla_pro, P.des_pro, DP.cad_pro, DP.lot_pro, I.cant, DP.cla_fin, DP.id_ori FROM detalle_productos DP, productos P, inventario I, unidades U, usuarios US WHERE DP.cla_pro = P.cla_pro AND DP.det_pro = I.det_pro AND I.cla_uni = U.cla_uni AND US.cla_uni = U.cla_uni AND P.cla_pro = '" + clave + "' AND US.id_usu='" + sesion.getAttribute("id_usu") + "' and DP.cad_pro between '"+fecha1+"' and '"+fecha2+"' AND cant>0 ORDER BY  DP.id_ori, DP.cad_pro, I.cant ASC ");                                        
                            while (rset5.next()) {
                                if (Integer.parseInt(rset5.getString("cant")) > 0) {
                                    rset2 = con.consulta("SELECT cause,cla_pro,lote,caducidad,indicaciones,fol_det,det_pro FROM recetas WHERE id_rec='"+request.getParameter("id_rec")+"' and can_sol='"+sol2+"' and cant_sur='"+sur1+"' and cla_pro='"+clave+"'");
                                    while(rset2.next()){
                                        causes = rset2.getString("cause");
                                        clapro = rset2.getString("det_pro");
                                        /*lote = rset2.getString("lote");
                                        cadu = rset2.getString("caducidad");*/
                                        indica = rset2.getString("indicaciones");                                
                                        folio = rset2.getString("fol_det");   
                                    }
                            rset3 = con.consulta("SELECT cla_pro,SUM(cant) AS cant,d.det_pro as detpro FROM detalle_productos d INNER JOIN inventario i on d.det_pro=i.det_pro WHERE d.det_pro='"+clapro+"' AND cant>0");
                            while(rset3.next()){                                
                                existt = rset3.getString("cant");
                                det_pro = rset3.getString("detpro");                                
                            }
                            if (existt != null){
                            exist = Integer.parseInt(existt);
                            cont = 1;
                            }
                            dife = sur21 - exist;
                            if (cont > 0){
                                if (total == sol21){
                                    if (exist >= sur){
                                        
                                            exist = exist - sur21;                                        
                                        
                                        con.insertar("update receta set baja = '0' where id_rec = '" + request.getParameter("id_rec")+"'");                    
                                        con.insertar("update detreceta set cant_sur = '"+sol2+"' where id_rec = '" + request.getParameter("id_rec") + "' and fol_det='"+folio+"'");                        
                                        con.insertar("UPDATE inventario SET cant='"+exist+"' WHERE det_pro='"+det_pro+"'");                        
                                    }else{
                                        total2 = exist +  sur12;
                                        con.insertar("update detreceta set cant_sur = '"+total2+"' where id_rec = '" + request.getParameter("id_rec") + "' and fol_det='"+folio+"'  ");                    
                                        con.insertar("UPDATE inventario SET cant='0' WHERE det_pro='"+det_pro+"'");                        
                                        sur21 = sur21 - exist;
                                    }
                                    cont=0;                                           
                                    exist = 0;
                                }else if(total < sol21){
                                    if (exist >= sur){
                                        exist = exist - sur;
                                        System.out.println("detalle mayor--"+det_pro+"-exis-"+exist);
                                        con.insertar("update detreceta set cant_sur = '"+total+"' where id_rec = '" + request.getParameter("id_rec") + "' and fol_det='"+folio+"' ");                    
                                        con.insertar("UPDATE inventario SET cant='"+exist+"' WHERE det_pro='"+det_pro+"'");                        
                                    }else{
                                        total2 = exist +  sur12;
                                        System.out.println("detalle menor--"+det_pro+"-exis-"+exist);
                                        con.insertar("update detreceta set cant_sur = '"+total2+"' where id_rec = '" + request.getParameter("id_rec") + "' and fol_det='"+folio+"' ");                    
                                        con.insertar("UPDATE inventario SET cant='0' WHERE det_pro='"+det_pro+"'");                        
                                    }
                                   cont=0; 
                                   sur21 = sur21 - exist;
                                   exist = 0;
                                }
                            
                            }else{
                                if (dife > 0){
                                    rset = con.consulta("SELECT i.id_inv, DP.det_pro, P.cla_pro, P.des_pro, DP.cad_pro, DP.lot_pro, I.cant, DP.cla_fin, DP.id_ori FROM detalle_productos DP, productos P, inventario I, unidades U, usuarios US WHERE DP.cla_pro = P.cla_pro AND DP.det_pro = I.det_pro AND I.cla_uni = U.cla_uni AND US.cla_uni = U.cla_uni AND P.cla_pro = '" + clave + "' AND US.id_usu='" + sesion.getAttribute("id_usu") + "' and DP.cad_pro between '"+fecha1+"' and '"+fecha2+"' AND cant>0 ORDER BY  DP.id_ori, DP.cad_pro, I.cant ASC ");                                        
                                    while (rset.next()) {
                                        det_pro = rset.getString("det_pro");
                                        if (Integer.parseInt(rset.getString("cant")) > 0) {
                                            sol1 = dife;
                                            dife = dife - Integer.parseInt(rset.getString("cant"));
                                        rset4 = con.consulta("SELECT can_sol,cant_sur FROM detreceta where fol_det='"+folio+"'"); 
                                        while (rset4.next()){
                                            cansol = Integer.parseInt(rset4.getString("can_sol"));
                                            cansur = Integer.parseInt(rset4.getString("cant_sur"));
                                        }   
                                            if (dife <= 0) {
                                                if (dife == 0) {
                                                    sur = Integer.parseInt(rset.getString("cant"));
                                                    con.insertar("update receta set baja = '0' where id_rec = '" + request.getParameter("id_rec")+"'");
                                                    con.insertar("insert into detreceta values ('0', '" + rset.getString("det_pro") + "', '" + sol1 + "', '" + sol1 + "', curdate(), '1', '" + request.getParameter("id_rec") + "', CURTIME(), '" + causes + "','" + indica +"' , '0', '0' ) ");
                                                    con.insertar("insert into kardex values ('0', '" + request.getParameter("id_rec") + "', '" + rset.getString("det_pro") + "', '" + sol1 + "', 'SALIDA RECETA', '-', NOW(), 'SALIDA POR RECETA FAR', '" + sesion.getAttribute("id_usu") + "', '0')");
                                                    con.insertar("update inventario set cant = '0', web = '0' where id_inv = '" + rset.getString("id_inv") + "' ");
                                                    sur21 = 0;
                                                    dife = 0;
                                                    
                                                }
                                                if (dife < 0) {
                                                    surc = dife * -1;
                                                    totalp = cansur + sol1;
                                                    totaldife = cansol - cansur;
                                                    if(totalp == cansol){
                                                        con.insertar("update receta set baja = '0' where id_rec = '" + request.getParameter("id_rec")+"'");
                                                        con.insertar("update detreceta set can_sol = '"+cansur+"' where id_rec = '" + request.getParameter("id_rec") + "' and fol_det='"+folio+"' ");                    
                                                        sur21 = 0;
                                                        dife= 0;
                                                    }else{
                                                        //con.insertar("update detreceta set cant_sur = '"+totalp+"' where id_rec = '" + request.getParameter("id_rec") + "' and fol_det='"+folio+"' ");                    
                                                        con.insertar("update detreceta set cant_sur = '"+cansur+"',can_sol='"+cansur+"' where id_rec = '" + request.getParameter("id_rec") + "' and fol_det='"+folio+"' ");                    
                                                        con.insertar("update receta set baja = '1' where id_rec = '" + request.getParameter("id_rec")+"'");
                                                        sur21 = sur21 - cansur;
                                                    }
                                                    con.insertar("insert into detreceta values ('0', '" + det_pro + "', '" + totaldife + "', '" + sol1 + "', curdate(), '1', '" + request.getParameter("id_rec") + "', CURTIME(), '" + causes + "','" + indica + "', '0', '0' ) ");
                                                    con.insertar("insert into kardex values ('0', '" + request.getParameter("id_rec") + "', '" + rset.getString("det_pro") + "', '" + sol1 + "', 'SALIDA RECETA', '-', NOW(), 'SALIDA POR RECETA FAR', '" + sesion.getAttribute("id_usu") + "', '0')");
                                                    con.insertar("update inventario set cant = '" + (surc) + "', web = '0' where id_inv = '" + rset.getString("id_inv") + "' ");
                                                }
                                                break;
                                            }else{
                                                totaldife = cansol - cansur;
                                                con.insertar("update detreceta set cant_sur = '"+cansur+"',can_sol='"+cansur+"' where id_rec = '" + request.getParameter("id_rec") + "' and fol_det='"+folio+"' ");                    
                                                con.insertar("insert into detreceta values ('0', '" + det_pro + "', '" + totaldife + "', '" + rset.getString("cant") + "', curdate(), '1', '" + request.getParameter("id_rec") + "', CURTIME(), '" + causes + "','" + indica + "', '0', '0' ) ");
                                                con.insertar("insert into kardex values ('0', '" + request.getParameter("id_rec") + "', '" + rset.getString("det_pro") + "', '" + rset.getString("cant") + "', 'SALIDA RECETA', '-', NOW(), 'SALIDA POR RECETA FAR', '" + sesion.getAttribute("id_usu") + "', '0')");
                                                con.insertar("update inventario set cant = '0', web = '0' where id_inv = '" + rset.getString("id_inv") + "' ");  
                                                dife = sol1 - rset.getInt("cant");
                                                sur21 = sur21 - rset.getInt("cant");
                                                rset2 = con.consulta("SELECT fol_det,det_pro FROM recetas WHERE id_rec='"+request.getParameter("id_rec")+"' and can_sol='"+totaldife+"' and cant_sur='"+rset.getString("cant")+"' and cla_pro='"+clave+"'");
                                                while(rset2.next()){                                
                                                    folio = rset2.getString("fol_det");                                
                                                }
                                            }
                                            
                                            
                                            
                                            
                                        } else {
                                        }
                                    }
                                }
                            }
                            } else {
                        }
                    }
                            
                            out.println("<script>alert('Se surtió la receta con folio: " + request.getParameter("fol_rec") + " correctamente.')</script>");
                            rset = con.consulta("SELECT id_tip FROM receta WHERE fol_rec='"+request.getParameter("fol_rec")+"' GROUP BY id_tip");
                            if(rset.next()){
                                idtip = rset.getString("id_tip");
                            }
                        }
                    }                    
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                    out.println("<script>alert('Error al surtir la receta Pendiente')</script>");
                }
                con.cierraConexion();
                out.println("<script>window.location='reportes/RecetaFarm.jsp?fol_rec=" + request.getParameter("fol_rec") + "&tipo="+idtip+"'</script>");
                //out.println("<script>window.location='reportes/TicketReceta.jsp?fol_rec=" + request.getParameter("fol_rec") + "'</script>");
                out.println("<script>window.location='farmacia/modSurteFarmacia.jsp'</script>");
            }
            /*
             * 
             * Para Cancelar una Receta
             */ else if (request.getParameter("accion").equals("cancelar")) {
                con.conectar();
                try {

                    ResultSet rset = con.consulta("select fol_det from detreceta where id_rec = '" + request.getParameter("id_rec") + "' ");
                    while (rset.next()) {
                        ResultSet rset2 = con.consulta("select dr.det_pro, dr.can_sol, dr.cant_sur, i.cant, dr.id_rec from detreceta dr, detalle_productos dp, inventario i where dr.det_pro = dp.det_pro and dp.det_pro = i.det_pro and dr.fol_det = '" + rset.getString(1) + "' ");
                        while (rset2.next()) {
                            String det_pro = "", id_rec = "";
                            int n_cant = 0, can_sol = 0, cant_sur = 0, cant_inv = 0;
                            det_pro = rset2.getString(1);
                            can_sol = rset2.getInt(2);
                            cant_sur = rset2.getInt(3);
                            cant_inv = rset2.getInt(4);
                            id_rec = rset2.getString(5);
                            n_cant = cant_inv + cant_sur;

                            con.insertar("update detreceta set can_sol = '0', cant_sur = '0', baja='1' where fol_det = '" + rset.getString(1) + "' ");
                            con.insertar("update inventario set cant = '" + n_cant + "' where det_pro = '" + det_pro + "' ");
                            con.insertar("insert into kardex values ('0', '" + id_rec + "', '" + det_pro + "', '" + cant_sur + "', 'REINTEGRA AL IVENTARIO', '-', NOW(), 'SE SE CANCELA RECETA', '" + sesion.getAttribute("id_usu") + "', '0'); ");
                        }

                    }
                    con.insertar("update receta set transito = '0', baja='1' where id_rec = '" + request.getParameter("id_rec") + "'  ");
                    out.println("<script>alert('Se canceló la receta con folio: " + request.getParameter("fol_rec") + " correctamente.')</script>");
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                    out.println("<script>alert('Error al cancelar la receta')</script>");
                }
                con.cierraConexion();
                out.println("<script>window.location='farmacia/modSurteFarmacia.jsp'</script>");
            } else if (request.getParameter("accion").equals("modificar")) {
                try {
                    con.conectar();
                    String fol_det = request.getParameter("fol_det");
                    System.out.println(fol_det);
                    String folios[] = fol_det.split(",");
                    for (int i = 0; i < folios.length; i++) {
                        if (!folios[i].equals("")) {
                            System.out.println(folios[i]);
                            String sol = request.getParameter("sol_" + folios[i]);
                            String sur = request.getParameter("sur_" + folios[i]);
                            System.out.println("sol+" + sol + "+sur+" + sur);
                            if (Integer.parseInt(sur) > Integer.parseInt(sol)) {
                                out.println("<script>alert('No se puede surtir una cantidad mayor que la solicitada.')</script>");
                            } else {
                                String id_inv = "", id_rec = "", det_pro = "";
                                int sol1 = Integer.parseInt(sol);
                                int sur1 = Integer.parseInt(sur);
                                int dif = sol1 - sur1;
                                int cant_inv = 0;
                                int cant_nueva = 0;
                                try {
                                    ResultSet rset = con.consulta("select * from salidas where fol_det = '" + folios[i] + "' ");
                                    while (rset.next()) {
                                        cant_inv = rset.getInt("cant");
                                        id_rec = rset.getString("id_rec");
                                        id_inv = rset.getString("id_inv");
                                        det_pro = rset.getString("det_pro");
                                    }
                                } catch (Exception e) {
                                }
                                cant_nueva = cant_inv + dif;
                                try {
                                    con.insertar("insert into kardex values ('0', '" + id_rec + "', '" + det_pro + "', '" + dif + "', 'ENTRADA POR AJUSTE', '-', NOW(), 'SE EDITA RECETA AL ENTREGARSE', '" + sesion.getAttribute("id_usu") + "', '0')  ");
                                    con.insertar("update inventario set cant = '" + cant_nueva + "' where id_inv= '" + id_inv + "' ");
                                    con.insertar("update detreceta set cant_sur = '" + sur + "', can_sol = '" + sol + "' where fol_det  = '" + folios[i] + "' ");
                                } catch (Exception e) {
                                    System.out.println(e.getMessage());
                                }
                            }

                        }
                    }
                    con.cierraConexion();
                    out.println("<script>alert('Modifiación Correcta')</script>");
                out.println("<script>window.location='farmacia/modSurteFarmacia.jsp'</script>");
                    //response.sendRedirect("farmacia/modSurteFarmacia.jsp");
                } catch (Exception e) {
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
