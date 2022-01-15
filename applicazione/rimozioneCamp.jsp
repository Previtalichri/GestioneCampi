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
                    String Sport = request.getParameter("sport");
                    String Data = request.getParameter("data");
                    String ora = request.getParameter("orario");
                    String Paese = request.getParameter("paese");
                    String prov = request.getParameter("provincia");
                    String query;
                    String verifica;
                    try{
                        Class.forName(DRIVER);
                    }
                    catch (ClassNotFoundException e) {
                        out.println("Errore: Impossibile caricare il Driver Ucanaccess");
                    }
                    try{
                        HttpSession s = request.getSession();
                        user = (String)s.getAttribute("username");
                        connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                        verifica = "SELECT username FROM Gestori WHERE username = '"+user+"';";
                        Statement st = connection.createStatement();
                        ResultSet result = st.executeQuery(verifica);
                        
                        if((user !=null) && (Sport != null) && (Data != null) && (ora != null) && (Paese != null) && (prov != null)){
                            if (result.next()){
                                query = "DELETE * FROM Prenotazioni WHERE username = '"+user+"'AND sport = '"+Sport+"'AND orario = '"+ora+"'AND paese = '"+Paese+"'AND provincia = '"+prov+"'AND data = '"+Data+"';";
                                st.executeUpdate(query);
                            }
                            
                        }
                    }
                    catch(Exception e){
                        out.println(e);
                    }
                    if((user !=null) && (Sport != null) && (Data != null) && (ora != null) && (Paese != null) && (prov != null)){
                        String url = "Gestore.html";
                        response.sendRedirect(url);
                    }
                %>
    </body>
</html>
 