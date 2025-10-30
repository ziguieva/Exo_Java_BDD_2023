<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>

<%
    // Classe interne représentant une Tâche
    class Task {
        private String titre;
        private String description;
        private String dateEcheance;
        private boolean terminee;

        // Constructeur
        public Task(String titre, String description, String dateEcheance) {
            this.titre = titre;
            this.description = description;
            this.dateEcheance = dateEcheance;
            this.terminee = false;
        }

        // Getters
        public String getTitre() { return titre; }
        public String getDescription() { return description; }
        public String getDateEcheance() { return dateEcheance; }
        public boolean isTerminee() { return terminee; }

        // Setter
        public void setTerminee(boolean t) { this.terminee = t; }
    }

    // Récupération ou création de la liste de tâches dans la session
    HttpSession maSession = request.getSession();
    ArrayList<Task> listeTaches = (ArrayList<Task>) maSession.getAttribute("taches");

    if (listeTaches == null) {
        listeTaches = new ArrayList<Task>();
        maSession.setAttribute("taches", listeTaches);
    }

    if (request.getParameter("ajouter") != null) {
        String titre = request.getParameter("titre");
        String description = request.getParameter("description");
        String date = request.getParameter("date");

        if (titre != null && !titre.trim().isEmpty()) {
            Task nouvelle = new Task(titre, description, date);
            listeTaches.add(nouvelle);
            maSession.setAttribute("taches", listeTaches);
        }
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Projet JSP - Mini Gestionnaire de Tâches</title>
</head>
<body>
    <h1>Projet JSP - Mini Gestionnaire de Tâches</h1>

    <!-- ✅ Formulaire pour ajouter une tâche -->
    <form method="post">
        <label>Titre :</label><br>
        <input type="text" name="titre" required><br><br>

        <label>Description :</label><br>
        <textarea name="description" rows="3" cols="40"></textarea><br><br>

        <label>Date d’échéance :</label><br>
        <input type="date" name="date"><br><br>

        <input type="submit" name="ajouter" value="Ajouter la tâche">
    </form>

    <hr>

    <%
        // ✅ Affichage du nombre de tâches pour test
        out.println("<p>Nombre de tâches en session : " + listeTaches.size() + "</p>");
    %>
</body>
</html>
