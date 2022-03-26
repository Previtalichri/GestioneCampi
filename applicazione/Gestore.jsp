

<html>
    <body>
        <h1> Benvenuti nella pagina entita, qui e' possibile selezionare tutte le azioni che puoi e vuoi fare</h1>
        <input type="button" onclick="location.href='disposizione.jsp'" value="Metti a disposizione un campo"/>
        <input type="button" onclick="location.href='elencoCamp.jsp'" value="Visualizza i campi messi a disposizione"/>
        <input type="button" onclick="location.href='logOutGestore.jsp'" value="log out"/>
        <%@ page import="java.io.*" %>
        <%@ page import="java.sql.*" %>
        <%@ page import="java.util.*" %>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ page import="net.ucanaccess.jdbc.UcanaccessSQLException" %>
        <%@ page import="java.text.*" %>
        <%@ page import="java.util.Date" %>
        <%@ page import="java.time.format.DateTimeFormatter" %>
        <%@ page import="java.time.LocalDate" %>
        
        <%
            String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
            Connection connection = null;
            String prov = null;
            String gestore = null;
            String queryProv= null;
            try{
                Class.forName(DRIVER);
            }
            catch (ClassNotFoundException e) {
                out.println("Errore: Impossibile caricare il Driver Ucanaccess");
            }     
            try{
                HttpSession s = request.getSession();
                gestore = (String)s.getAttribute("username");
                connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                Statement st = connection.createStatement();
                queryProv = "SELECT provincia FROM Gestori WHERE username = '"+gestore+"';";
                ResultSet r = st.executeQuery(queryProv);   
                while(r.next()){
                    prov = r.getString(1);
                    s.setAttribute("provincia",prov); // imposta i valori di sessioni    
                }
            }
            catch(Exception e){
                System.out.println(e);
            }
            System.out.println(prov);
            
        %>


    </body>
</html>


