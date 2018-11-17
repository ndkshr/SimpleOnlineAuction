<%-- 
    Document   : placeBid
    Created on : 16 Nov, 2018, 8:48:16 PM
    Author     : Owner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Place your bids here!</title>
    </head>
    <body>
        <h1>Enter your unique name and place bid</h1>
        <form method="get">
            <h2>Item list</h2>
            <input type="text" name="name" placeholder="Enter your name" required />
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
                    String button = "<button type='submit' name='itemName' value='"+(itemName)+"'>Place Bid</button>";
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
                try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/auction", "root", "root");
                Statement stmt = conn.createStatement();
                String name = request.getParameter("name");
                String itemName = request.getParameter("itemName");
                
                if(request.getParameter("submitflag").equals("True")){
                
                out.println(name + " -- " + itemName);
                //ResultSet itemListTable= stmt.executeQuery("select * from itemlist");
                ResultSet bidset=stmt.executeQuery("select highestBid from itemlist where itemName ='"+(itemName)+"'");
                if(bidset.next()){
                int highestbid = bidset.getInt("highestBid");
                out.println("<h1>" + highestbid + "</h1>");
                int insertbid = stmt.executeUpdate("insert into "+(itemName)+" values('" + (name) + "'," +((highestbid)+50)+ ")");
                int updateHB = stmt.executeUpdate("update itemlist set highestBid=highestBid+50 where itemName='"+(itemName)+"'");
                }
                }

                }catch(SQLException e){}
                catch(ClassNotFoundException e){}
                catch(NullPointerException e){}
                
                %>
    </body>
</html>
