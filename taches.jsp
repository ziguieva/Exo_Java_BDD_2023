<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%! 
class MyClass {
    int x = 5;
}
%>

<%
    MyClass myObj = new MyClass();
    out.println("Valeur de x : " + myObj.x);
%>

<html>
<head>
<title>Taches</title>
</head>
<body bgcolor=white>
<h1>Saisir une tache</h1>
<form action="#" method="post">
    <label for="inputValeur">Saisir une tache : </label>
    <input type="text" id="inputValeur" name="valeur">
    <input type="submit" value="Enregistrer">
</form>

<%-- Récupération de la valeur saisie par l'utilisateur --%>
<% String valeur = request.getParameter("valeur"); %>
    
<%-- Vérification de l'existence de la valeur --%>
<% if (valeur != null && !valeur.isEmpty()) { %>

<%-- Boucle for pour afficher une ligne d'étoiles --%>
    <%int cpt = Integer.parseInt(valeur); %>
    <p>
    <% for (int i = 1; i <= cpt; i++) { %>
       <%= "*" %>
    <% } %>
    </p>




<% } %>
</body>
</html>
