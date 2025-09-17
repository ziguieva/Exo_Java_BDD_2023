<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>les conditions</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les conditions</h1>

<form action="#" method="post">
    <p>Saisir la valeur 1 : <input type="text" name="valeur1">
    <p>Saisir la valeur 2 : <input type="text" name="valeur2">

    <!-- Champs pour l'exercice 1 -->
    <p>A : <input type="text" name="A">
    <p>B : <input type="text" name="B">
    <p>C : <input type="text" name="C">

    <!-- Champ pour l'exercice 2 -->
    <p>Nombre : <input type="text" name="n">

    <p><input type="submit" value="Afficher">
</form>

<%-- Récupération des valeurs pour la comparaison simple --%>
<% String valeur1 = request.getParameter("valeur1"); %>
<% String valeur2 = request.getParameter("valeur2"); %>

<%-- Vérification de la condition entre les deux valeurs --%>
<% if (valeur1 != null && valeur2 != null && !valeur1.isEmpty() && !valeur2.isEmpty()) { 
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

<h2>Exercice 1 : Comparaison 1</h2>
<p>Ecrire un programme qui demande à l'utilisateur de saisir 3 valeurs (des chiffres), A, B et C et dites nous si la valeur de C est comprise entre A et B.</p>

<% String sa=request.getParameter("A"), sb=request.getParameter("B"), sc=request.getParameter("C"); 
   if(sa!=null && sb!=null && sc!=null && !sa.isEmpty() && !sb.isEmpty() && !sc.isEmpty()){ 
       int A=Integer.parseInt(sa), B=Integer.parseInt(sb), C=Integer.parseInt(sc); %>
       <p><%= (C>=Math.min(A,B) && C<=Math.max(A,B)) 
              ? "Oui C est compris entre A et B" 
              : "Non C n'est pas compris entre A et B" %></p>
<% } %>

<h2>Exercice 2 : Pair ou Impair ?</h2>
<p>Écrivez un programme pour vérifier si un nombre est pair ou impair en utilisant une structure if</p>

<% String sn=request.getParameter("n"); 
   if(sn!=null && !sn.isEmpty()){ 
       int n=Integer.parseInt(sn); %>
       <p><%= (n%2==0) ? "Le nombre est pair" : "Le nombre est impair" %></p>
<% } %>

<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
