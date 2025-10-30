<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>

<%
    // Partie 1 : Code Java
    class Task {
        private String titre;
        private String description;
        private String dateEcheance;
        private boolean terminee;

        public Task(String titre, String description, String dateEcheance) {
            this.titre = titre;
            this.description = description;
            this.dateEcheance = dateEcheance;
            this.terminee = false;
        }

        public String getTitre() { return titre; }
        public String getDescription() { return description; }
        public String getDateEcheance() { return dateEcheance; }
        public boolean isTerminee() { return terminee; }
        public void setTerminee(boolean t) { this.terminee = t; }
    }

    HttpSession sessionTaches = request.getSession();
    ArrayList<Task> listeTaches = (ArrayList<Task>) sessionTaches.getAttribute("taches");
    if (listeTaches == null) {
        listeTaches = new ArrayList<Task>();
        sessionTaches.setAttribute("taches", listeTaches);
    }

    // --- Ajout d'une tâche ---
    if (request.getParameter("ajouter") != null) {
        String titre = request.getParameter("titre");
        String description = request.getParameter("description");
        String date = request.getParameter("date");

        if (titre != null && !titre.trim().isEmpty()) {
            listeTaches.add(new Task(titre, description, date));
        }
    }

    // --- Marquer une tâche comme terminée ---
    if (request.getParameter("done") != null) {
        int index = Integer.parseInt(request.getParameter("done"));
        if (index >= 0 && index < listeTaches.size()) {
            listeTaches.get(index).setTerminee(true);
        }
    }

    // --- Supprimer une tâche ---
    if (request.getParameter("delete") != null) {
        int index = Integer.parseInt(request.getParameter("delete"));
        if (index >= 0 && index < listeTaches.size()) {
            listeTaches.remove(index);
        }
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mini Gestionnaire de Tâches</title>
</head>
<body>
    <h1>Mini Gestionnaire de Tâches</h1>

    <!-- Formulaire d’ajout -->
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

    <h2>Liste des tâches</h2>
    <table border="1" cellpadding="6" cellspacing="0">
        <tr>
            <th>#</th>
            <th>Titre</th>
            <th>Description</th>
            <th>Date</th>
            <th>État</th>
            <th>Actions</th>
        </tr>

        <%
            for (int i = 0; i < listeTaches.size(); i++) {
                Task t = listeTaches.get(i);
        %>
        <tr>
            <td><%= i %></td>
            <td><%= t.getTitre() %></td>
            <td><%= t.getDescription() %></td>
            <td><%= t.getDateEcheance() %></td>
            <td><%= t.isTerminee() ? "Terminée ✅" : "En cours ⏳" %></td>
            <td>
                <% if (!t.isTerminee()) { %>
                    <a href="?done=<%= i %>">Terminer</a> |
                <% } %>
                <a href="?delete=<%= i %>">Supprimer</a>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>
