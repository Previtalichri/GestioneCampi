<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigInteger" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="net.ucanaccess.jdbc.UcanaccessSQLException" %>

<html>
    <body>

    <%!

    public class MD5Util {
        public String encrypt(String message) {
            try{
                MessageDigest m = MessageDigest.getInstance("MD5");
                m.update(message.getBytes());
                return String.format("%032x",new BigInteger(1,m.digest()));
            }
            catch(Exception e){
                return null;
            }
    }
    }

    %>
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
                    out.println("Username gia in uso, immettere un username differente");
                    out.println("<br><br>");
                    out.println("<a href='index.html'>Premi qui per tornare al login</a>");
                    
                }
                else{

                    MD5Util md = new MD5Util();
                    String cri = md.encrypt(psw);
                    System.out.println(cri);

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