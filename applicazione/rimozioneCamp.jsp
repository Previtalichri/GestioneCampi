<html>
    <body>
        <%@ page import="java.io.*" %>
                <%@ page import="java.sql.*" %>
                <%@ page contentType="text/html;charset=UTF-8" language="java" %>
                <%@ page import="net.ucanaccess.jdbc.UcanaccessSQLException" %>
                <%@ page import="java.util.concurrent.TimeUnit" %>
                <%
                    String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
                    Connection connection=null;
                    String user = null;
                    String prov=null;
                    String Sport = request.getParameter("sport");
                    String Comune = request.getParameter("comune");
                    String num = request.getParameter("numero");
                    String Via = request.getParameter("via");
                    String query = null;
                    try{
                        Class.forName(DRIVER);
                    }
                    catch (ClassNotFoundException e) {
                        out.println("Errore: Impossibile caricare il Driver Ucanaccess");
                    }
                    try{
                        HttpSession s = request.getSession();
                        user = (String)s.getAttribute("username");
                        prov = (String)s.getAttribute("provincia");
                        connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                        Statement st = connection.createStatement();                       
                                query = "DELETE * FROM Struttura WHERE Sede = '"+user+"'AND Provincia = '"+prov+"'AND Comune = '"+Comune+"'AND Via = '"+Via+"'AND Numero = '"+num+"'AND Sport = '"+Sport+"';";
                                st.executeUpdate(query);
                                System.out.println(query);
                    }
                    catch(Exception e){
                        out.println(e);
                    }
                    if((user !=null) && (Sport != null) && (Comune !=null)){
                        String url = "Gestore.html";
                        response.sendRedirect(url);
                    }
                %>
    </body>
</html>
 