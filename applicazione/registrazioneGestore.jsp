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
            String paese=null;
			Connection connection=null;
            try{
                Class.forName(DRIVER);
            }
            catch (ClassNotFoundException e) {
                out.println("Errore: Impossibile caricare il Driver Ucanaccess");
            }
            try{
				user = request.getParameter("usernameEn");
				psw = request.getParameter("passwordEn");
                paese = request.getParameter("paese");
                connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                String verifica = "SELECT username from Gestori WHERE username = '"+user+"';";
                Statement s = connection.createStatement();
                ResultSet r = s.executeQuery(verifica);
                if(r.next())
                {
                    out.println("Username gia in uso, tornare indietro per rifare la registrazione");
                }
                else{
                    String query = "INSERT INTO Gestori(username,password,paese) VALUES('"+user+"','"+psw+"','"+paese+"')";  
                    s.executeUpdate(query);
                    String url = "loginGestore.jsp";
                    response.sendRedirect(url);     
                }           
            }
			catch(UcanaccessSQLException ex){
				out.println("<h1>Nome utente già in uso</h1>");
				out.println(ex);
			}
            catch(Exception e){
                out.println(e);
            }   
        %>
    </body>
</html>