<html>
    <body>
        <h1> Benvenuti nella pagina Utente, qui e' possibile selezionare tutte le azioni che puoi e vuoi fare</h1>
        <input type="button" onclick="location.href='ricerca.jsp'" value="Cerca"/>
        <input type="button" onclick="location.href='elencoPren.jsp'" value="Elenco prenotazioni"/>
        <%@ page import="java.io.*" %>
        <%@ page import="java.sql.*" %>
        <%@ page import="java.util.*" %>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <%@ page import="net.ucanaccess.jdbc.UcanaccessSQLException" %>
        <%@ page import="java.text.*" %>
        <%@ page import="java.util.Date" %>

        <%
            String utente;
            String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
            Connection connection = null;
            String dataQuery = null;
            SimpleDateFormat d = new SimpleDateFormat("dd/MM/yyyy");
            try{
                Class.forName(DRIVER);
            }
            catch (ClassNotFoundException e) {
                out.println("Errore: Impossibile caricare il Driver Ucanaccess");
            }
                
            try{
                String date =d.format(new Date());
                HttpSession s = request.getSession();
                utente = (String)s.getAttribute("username");
                connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                Statement st = connection.createStatement();
                dataQuery = "DELETE * FROM Prenotazioni WHERE Utente = '"+utente+"' AND data < '"+date+"';";
                
                st.executeUpdate(dataQuery);  
            }
            catch(Exception e){
                System.out.println(e);
            }
        %>

    </body>
</html>



