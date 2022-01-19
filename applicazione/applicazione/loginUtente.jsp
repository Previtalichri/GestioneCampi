<%@ page import="java.sql.Connection" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <body>
        <h1>Benvenuti nella pagina di login di un utente</h1>
        <form action="loginUtente.jsp" method="POST">
            <input type="text" id="username" name="username" placeholder="username" required>
            <input type="text" id="password" name="password" placeholder="password" required>
            <input type="submit" id="btn" name="btn" value="Accedi">
        </form>

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
            String dataValue=user;
            psw=request.getParameter("password");
            connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
            String query = "SELECT username,password FROM Utenti WHERE username = '"+user+"'AND password = '"+psw+"';";    
            
            Statement st = connection.createStatement();
            ResultSet result = st.executeQuery(query);
            
            if(result.next()){     
                s.setAttribute("username",dataValue); // imposta i valori di sessioni    
                response.sendRedirect("Utente.html"); 
                
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
