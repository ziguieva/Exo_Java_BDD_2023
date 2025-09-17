<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>les conditions</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les conditions</h1>

<form action="#" method="post">
    <!-- Champs pour Exercice 1 -->
    <p>Saisir A : <input type="text" name="A">
    <p>Saisir B : <input type="text" name="B">
    <p>Saisir C : <input type="text" name="C">

    <!-- Champ pour Exercice 2 -->
    <p>Saisir un nombre pair ou impair : <input type="text" name="n">

    <p><input type="submit" value="Afficher">
</form>

<%-- Exercice 1 : Comparaison 1 --%>
<h2>Exercice 1 : Comparaison 1</h2>
<% String sa=request.getParameter("A"), sb=request.getParameter("B"), sc=request.getParameter("C"); 
   if(sa!=null && sb!=null && sc!=null && !sa.isEmpty() && !sb.isEmpty() && !sc.isEmpty()){ 
       int A=Integer.parseInt(sa), B=Integer.parseInt(sb), C=Integer.parseInt(sc); %>
       <p><%= (C>=Math.min(A,B) && C<=Math.max(A,B)) 
              ? "Oui C est compris entre A et B" 
              : "Non C n'est pas compris entre A et B" %></p>
<% } %>

<%-- Exercice 2 : Pair ou Impair --%>
<h2>Exercice 2 : Pair ou Impair ?</h2>
<% String sn=request.getParameter("n"); 
   if(sn!=null && !sn.isEmpty()){ 
       int n=Integer.parseInt(sn); %>
       <p><%= (n%2==0) ? "Le nombre est pair" : "Le nombre est impair" %></p>
<% } %>

<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
