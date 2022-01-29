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
        <%@ page import="java.time.format.DateTimeFormatter" %>
        <%@ page import="java.time.LocalDate" %>
        
        <%
            String utente;
            String DRIVER = "net.ucanaccess.jdbc.UcanaccessDriver";
            Connection connection = null;
            String dataQuery = null;
            String eliminazione = null;
            try{
                Class.forName(DRIVER);
            }
            catch (ClassNotFoundException e) {
                out.println("Errore: Impossibile caricare il Driver Ucanaccess");
            }     
            try{
                DateTimeFormatter form = DateTimeFormatter.ofPattern("dd/MM/yyyy");  
                LocalDate oggi = LocalDate.now();   
                System.out.println(oggi);    
                HttpSession s = request.getSession();
                utente = (String)s.getAttribute("username");
                connection = DriverManager.getConnection("jdbc:ucanaccess://" + request.getServletContext().getRealPath("/") + "Prenotazione.accdb");
                Statement st = connection.createStatement();
                dataQuery = "SELECT data FROM Prenotazioni WHERE Utente = '"+utente+"';";
                boolean isbefore=false; 
                ResultSet r = st.executeQuery(dataQuery); 
                LocalDate data=null;      
                String dataDb = null;         
                while(r.next()){
                    dataDb = r.getString(1);
                    data = LocalDate.parse(dataDb,form);
                    isbefore = data.isBefore(oggi);
                    if(isbefore){
                        eliminazione = "DELETE * FROM Prenotazioni WHERE Utente = '"+utente+"' AND data = '"+dataDb+"';";
                        st.executeUpdate(eliminazione);

                    }  
                    }      
            }
            catch(Exception e){
                System.out.println(e);
            }
        %>

    </body>
</html>


