/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package in.co.sneh.controller;

import in.co.sneh.model.FileUpload;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.FileUploadException;
import java.io.InputStream;
import java.io.PrintWriter;
import org.apache.commons.fileupload.FileItemIterator;
import javax.servlet.http.HttpSession;
import Clases.*;

/**
 *
 * @author CEDIS TOLUCA3
 */
public class FileUploadServlet extends HttpServlet {

    LeerCSV lee = new LeerCSV();
    CargaAbasto carga = new CargaAbasto();

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        ConectionDB con = new ConectionDB();
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        
        
        boolean isMultiPart = ServletFileUpload.isMultipartContent(request);
        if (isMultiPart) {
            ServletFileUpload upload = new ServletFileUpload();
            try {
                HttpSession sesion = request.getSession(true);
                FileItemIterator itr = upload.getItemIterator(request);
                while (itr.hasNext()) {
                    FileItemStream item = itr.next();
                    if (item.isFormField()) {
                        String fielName = item.getFieldName();
                        InputStream is = item.openStream();
                        byte[] b = new byte[is.available()];
                        is.read(b);
                        String value = new String(b);
                        response.getWriter().println(fielName + ":" + value + "<br/>");
                    } else {
                        String path = getServletContext().getRealPath("/");
                        if (FileUpload.processFile(path, item)) {
                            //response.getWriter().println("file uploaded successfully");
                            sesion.setAttribute("ban", "1");
                            if (lee.leeCSV(path, item.getName())) {
                                String mensaje = carga.cargaAbasto((String) sesion.getAttribute("cla_uni"), (String) sesion.getAttribute("id_usu"), item.getName());
                                out.println("<script>alert('"+mensaje+"')</script>");
                                out.println("<script>window.location='farmacia/cargaAbasto.jsp'</script>");
                            }
                            //response.sendRedirect("cargaFotosCensos.jsp");
                        } else {
                            //response.getWriter().println("file uploading falied");
                            //response.sendRedirect("cargaFotosCensos.jsp");
                        }
                    }
                }
            } catch (FileUploadException fue) {
                System.out.println(fue.getMessage());
                fue.printStackTrace();
            }
            out.println("<script>alert('No se pudo subir el inventario, verifique las celdas')</script>");
            out.println("<script>window.location='farmacia/cargaAbasto.jsp'</script>");
            //response.sendRedirect("carga.jsp");
        }

        /*
         * Para insertar el excel en tablas
         */
    }
}
