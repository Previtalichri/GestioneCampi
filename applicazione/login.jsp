<%@ page import="java.sql.Connection" %>
<%@ page import="java.io.*" %>
<!--<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %> -->
<%@ page import="java.sql.*" %>

<%@ page import="java.math.BigInteger" %>
<%@ page import="java.security.MessageDigest" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <body>
        <h1>Benvenuti nella pagina di login</h1>
        <form action="login.jsp" method="POST">
            <input type="text" id="username" name="username" placeholder="username" required>
            <input type="password" id="password" name="password" placeholder="password" required>
            <input type="submit" id="btn" name="btn" value="Accedi">
        </form>

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
        Connection connection=null;
        String user=null;
        String psw=null;
        try{
            Class.forName(DRIVER);
        }
        catch (ClassNotFoundException e) {
            out.println("Errore: Impossibile caricare il Driver Ucanaccess");
        }
        try{
            HttpSession s = request.getSession();         
            user=request.getParameter("username");
            psw=request.getParameter("password");
            MD5Util md = new MD5Util();
            String cri = md.encrypt(psw); //hash della password
            connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
            String queryUtenti = "SELECT username,password FROM Utenti WHERE username = ? AND password = ?;"; 
            String queryGestori = "SELECT username,password FROM Gestori WHERE username = ? AND password = ?;"; 
            PreparedStatement pGestori = connection.prepareStatement(queryGestori);
            PreparedStatement pUtenti = connection.prepareStatement(queryUtenti);  
            pGestori.setString(1,user);
            pGestori.setString(2,cri);
            pUtenti.setString(1,user);
            pUtenti.setString(2,cri);

            ResultSet resultUtenti = pUtenti.executeQuery();
            ResultSet resultGestori = pGestori.executeQuery();
            
            if(resultUtenti.next()){     
                s.setAttribute("username",user); // imposta i valori di sessioni    
                s.setAttribute("ruolo","utente"); // imposta i valori di sessioni   
                response.sendRedirect("Utente.jsp"); 
                
            }
            else if(resultGestori.next()){
                s.setAttribute("username",user); // imposta i valori di sessioni  
                s.setAttribute("ruolo","gestore"); // imposta i valori di sessioni     
                response.sendRedirect("Gestore.jsp"); 

            }
            else{
                if((user != null) && (psw != null)){
                    out.println("<h1>Credenziali errate</h1>");
                }  
            }
        }
        catch(Exception e){
            out.println(e);

        }
        finally{
            if(connection != null){
                try{
                    connection.close();
                }
                catch(Exception e){
                    out.println("Errore nella chiusura della connessione");
                }
            }
        }
        %>
    </body>
</html>
