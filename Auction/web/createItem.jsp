<%-- 
    Document   : createItem
    Created on : 16 Nov, 2018, 7:13:35 PM
    Author     : Owner
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Item</title>
    </head>
    <body>
        <h1>Enter item name and its base price.</h1>
        <form method="post">
            <input type="text" name="itemName" placeholder="Item Name">
            <input type="number" name="itemBasePrice" placeholder="Base Price">
            <input type="submit" value="Create Item" name="create">
        </form>
        <%
        String itemName = request.getParameter("itemName");
        String itemBasePrice = (request.getParameter("itemBasePrice"));
        
        try{
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/auction", "root", "root");
        Statement stmt = conn.createStatement();
        
        int createItemFlag = stmt.executeUpdate("create table "+ (itemName)+ "(name varchar(50), bid integer)");
        int addtoItemList = stmt.executeUpdate("insert into itemlist values( '" +(itemName)+ "', "+ (itemBasePrice) +" )");
        
        out.println(createItemFlag + " - " + addtoItemList);
        }
        catch(SQLException e){}
        catch(ClassNotFoundException e){}
        
        /*
        out.println("Item Name: " + itemName);
        out.println("Base Price: " + itemBasePrice);
        */
        
        %>
    </body>
</html>
