
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
                    String sede = request.getParameter("sede");
                    String Data = request.getParameter("data");
                    String ora = request.getParameter("orario");
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
                        Statement st = connection.createStatement();
                        
                        if((sede !=null) && (User != null) && (Data != null) && (ora != null)){
                                query = "DELETE * FROM Prenotazioni WHERE Sede = '"+sede+"'AND Utente = '"+User+"' AND orario = '"+ora+"' AND data = '"+Data+"';";
                                st.executeUpdate(query);                          
                        }
                    }
                    catch(Exception e){
                        out.println(e);
                    }
                    if((sede !=null) && (User != null) && (Data != null) && (ora != null)){
                        String url = "Utente.jsp";
                        response.sendRedirect(url);
                    }
                %>
    </body>
</html>
 