<%-- 
    Document   : result
    Created on : 17 Nov, 2018, 8:33:16 AM
    Author     : Owner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Click to see the list of bidders</h1>
        <form method="get">
        <input type="hidden" name="submitflag" value="True">
        <table>
                <tr>
                    <th>Item Name</th>
                    <th>Highest Bid</th>
                    <th>Press to place bid</th>
                </tr>
                <%
                try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/auction", "root", "root");
                Statement stmt = conn.createStatement();
                ResultSet itemListTable= stmt.executeQuery("select * from itemlist");
                
                while(itemListTable.next()){
                    String itemName = itemListTable.getString("itemName");
                    String button = "<button type='submit' name='itemName' value='"+(itemName)+"'>Show Bids</button>";
                    out.println("<tr>"
                                    + "<td>"  + itemName + "</td>"
                                    + "<td>" + itemListTable.getInt("highestBid") + "</td>"
                                    + "<td>" + button + "</td>"
                                + "</tr>");
                }
                
                }catch(SQLException e){}
                catch(ClassNotFoundException e){}
                %>
        </table>
        </form>
        
        <%
        if(request.getParameter("submitflag").equals("True")){
        try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/auction", "root", "root");
        Statement stmt = conn.createStatement();
        String itemName = request.getParameter("itemName");
        ResultSet itemListTable= stmt.executeQuery("select * from " + itemName + " order by bid desc");
        out.println("<h2>The Bid Reults of item: " +itemName+ "</h2>");
        out.println("<table>");
        while(itemListTable.next()){
                    out.println("<tr>"
                                    + "<td>" + itemListTable.getString("name") + "</td>"
                                    + "<td>" + itemListTable.getInt("bid") + "</td>"
                                + "</tr>");
                }
                
                }catch(SQLException e){}
                catch(ClassNotFoundException e){}
        }
        out.println("</table>");
        %>
    </body>
</html>
