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
            String prov=null;
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
                prov = (request.getParameter("provincia")).toUpperCase();
                
                connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                String verifica = "SELECT username,provincia from Gestori WHERE username = '"+user+"'AND provincia = '"+prov+"' ;";
                Statement s = connection.createStatement();
                ResultSet r = s.executeQuery(verifica);
                if(r.next())
                {
                    out.println("Username e provincia gia registrati, immettere un'altro username");
                    out.println("<br><br>");
                    out.println("<a href='index.html'>Premi qui per tornare al login</a>");
                }
                else{
                    String query = "INSERT INTO Gestori(username,password,provincia) VALUES('"+user+"','"+psw+"','"+prov+"')";  
                    s.executeUpdate(query);
                    String url = "loginGestore.jsp";
                    response.sendRedirect(url);     
                }           
            }
			catch(UcanaccessSQLException ex){
				out.println(ex);
			}
            catch(Exception e){
                out.println(e);
            }   
        %>
    </body>
</html>