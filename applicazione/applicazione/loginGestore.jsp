<%@ page import="java.sql.Connection" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <body>

        <h1>Benvenuti nella pagina di login di un gestore</h1>
            <form action="loginGestore.jsp" method="POST">
            <input type="text" id="username" name="username" placeholder="username">
            <input type="password" id="password" name="password" placeholder="password">
	    <input type="text" id="provincia" name="provincia" placeholder="provincia es. BG,BS">

            <input type="submit" id="btn" name="btn" value="Accedi">
            </form>
        <%
        String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
        Connection connection=null;
        String user=null;
        String psw=null;
	    String prov=null;
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
	    prov=request.getParameter("provincia");
	    
            connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
            String query = "SELECT username,password,provincia FROM Gestori WHERE username = '"+user+"'AND password = '"+psw+"'AND provincia = '"+prov+"';"; 
            
            Statement st = connection.createStatement();
            ResultSet result = st.executeQuery(query);
            
            if(result.next()){  
                s.setAttribute("username",user); 
		        s.setAttribute("provincia",prov);       
                response.sendRedirect("Gestore.html"); 
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
