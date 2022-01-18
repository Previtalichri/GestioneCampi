
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
                    String sede = request.getParameter("username");
                    String Sport = request.getParameter("sport");
                    String Data = request.getParameter("data");
                    String ora = request.getParameter("orario");
                    String Paese = request.getParameter("paese");
                    String prov = request.getParameter("provincia");
                    String User = null;
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
                        User = (String)s.getAttribute("username");
                        connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                        verifica = "SELECT username FROM Gestori WHERE username = '"+sede+"';";
                        Statement st = connection.createStatement();
                        ResultSet result = st.executeQuery(verifica);
                        
                        if((sede !=null) && (User != null) && (Sport != null) && (Data != null) && (ora != null) && (Paese != null) && (prov != null)){
                            if (result.next()){
                                query = "UPDATE Prenotazioni SET prenotato = 'No' WHERE username = '"+sede+"'AND sport = '"+Sport+"'AND orario = '"+ora+"'AND paese = '"+Paese+"'AND provincia = '"+prov+"'AND prenotato = '"+User+"'AND data = '"+Data+"';";
                                st.executeUpdate(query);
                            }                           
                        }
                    }
                    catch(Exception e){
                        out.println(e);
                    }
                    if((sede !=null) && (User != null) && (Sport != null) && (Data != null) && (ora != null) && (Paese != null) && (prov != null)){
                        String url = "Utente.html";
                        response.sendRedirect(url);
                    }
                %>
    </body>
</html>
 