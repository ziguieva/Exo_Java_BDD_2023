<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>les conditions</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les conditions</h1>

<!-- Formulaire pour comparer deux valeurs -->
<form action="#" method="post">
    <p>Saisir la valeur 1 : <input type="text" name="valeur1">
    <p>Saisir la valeur 2 : <input type="text" name="valeur2">
    <p><input type="submit" value="Comparer">
</form>

<%-- Récupération des valeurs --%>
<% String valeur1 = request.getParameter("valeur1"); %>
<% String valeur2 = request.getParameter("valeur2"); %>

<% if (valeur1 != null && valeur2 != null) { 
       int intValeur1 = Integer.parseInt(valeur1); 
       int intValeur2 = Integer.parseInt(valeur2); 
       if (intValeur1 > intValeur2) { %>
            <p>Valeur 1 est supérieure à Valeur 2.</p>
<%     } else if (intValeur1 < intValeur2) { %>
            <p>Valeur 1 est inférieure à Valeur 2.</p>
<%     } else { %>
            <p>Valeur 1 est égale à Valeur 2.</p>
<%     } 
   } %>

<hr>

<h2>Exercice 1 : Comparaison 1</h2>
<form action="#" method="post">
    <p>A : <input type="text" name="A">
    <p>B : <input type="text" name="B">
    <p>C : <input type="text" name="C">
    <p><input type="submit" value="Tester">
</form>

<% String sa=request.getParameter("A"), sb=request.getParameter("B"), sc=request.getParameter("C"); 
   if(sa!=null && sb!=null && sc!=null){ 
       int A=Integer.parseInt(sa), B=Integer.parseInt(sb), C=Integer.parseInt(sc); %>
       <p><%= (C>=Math.min(A,B) && C<=Math.max(A,B)) 
              ? "Oui C est compris entre A et B" 
              : "Non C n'est pas compris entre A et B" %></p>
<% } %>

<hr>

<h2>Exercice 2 : Pair ou Impair ?</h2>
<form action="#" method="post">
    <p>Nombre : <input type="text" name="n">
    <p><input type="submit" value="Vérifier">
</form>

<% String sn=request.getParameter("n"); 
   if(sn!=null){ 
       int n=Integer.parseInt(sn); %>
       <p><%= (n%2==0) ? "Le nombre est pair" : "Le nombre est impair" %></p>
<% } %>

<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
