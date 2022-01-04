<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="net.ucanaccess.jdbc.UcanaccessSQLException" %>

<html>
    <body>
        <%
            String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
			String user=null;
			String psw=null;
			Connection connection=null;
            try{
                Class.forName(DRIVER);
            }
            catch (ClassNotFoundException e) {
                out.println("Errore: Impossibile caricare il Driver Ucanaccess");
            }
            try{
				user = request.getParameter("usernameUt");
				psw = request.getParameter("passwordUt");
                connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                
                String verifica = "SELECT username from Utenti WHERE username = '"+user+"';";
                Statement s = connection.createStatement();
                ResultSet r = s.executeQuery(verifica);
                if(r.next()){
                    out.println("Username già in uso");
                }
                else{
                    String query = "INSERT INTO Utenti(username,password) VALUES('"+user+"','"+psw+"')";    
                    s.executeUpdate(query);
                    String url = "loginUtente.jsp";
                    response.sendRedirect(url);
                }              
            }
			catch(UcanaccessSQLException ex){
				out.println("Errore");
				out.println(ex);
			}
            catch(Exception e){
                out.println(e);
            }   
        %>
    </body>
</html>