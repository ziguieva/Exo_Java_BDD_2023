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
    <style>
        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background: #f4f7fa;
            margin: 40px auto;
            max-width: 800px;
            color: #333;
        }

        h1 {
            text-align: center;
            color: #0078D7;
            margin-bottom: 30px;
        }

        .retour {
            text-align: left;
            margin-bottom: 20px;
        }

        .btn-retour {
            background: #ccc;
            color: #333;
            border: none;
            padding: 8px 15px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }

        .btn-retour:hover {
            background: #999;
        }

        form {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        input[type=text],
        input[type=date],
        textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 6px;
            margin-bottom: 10px;
        }

        input[type=submit] {
            background: #0078D7;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
        }

        input[type=submit]:hover {
            background: #005fa3;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
            background: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #0078D7;
            color: white;
        }

        tr:hover { background: #f1f9ff; }
        .terminee { text-decoration: line-through; color: #777; }
        a { color: #0078D7; text-decoration: none; font-weight: bold; }
        a:hover { text-decoration: underline; }
        .etat { font-weight: bold; }
        .etat.enCours { color: #e67e22; }
        .etat.terminee { color: #27ae60; }
    </style>
</head>
<body>

    <!-- 🏠 Bouton de retour -->
    <div class="retour">
        <button class="btn-retour" onclick="window.location.href='index.html'">⬅ Retour à l’accueil</button>
    </div>

    <h1>📝 Mini Gestionnaire de Tâches</h1>

    <!-- Formulaire d’ajout -->
    <form method="post">
        <label><b>Titre :</b></label>
        <input type="text" name="titre" required>

        <label><b>Description :</b></label>
        <textarea name="description" rows="3"></textarea>

        <label><b>Date d’échéance :</b></label>
        <input type="date" name="date">

        <input type="submit" name="ajouter" value="➕ Ajouter la tâche">
    </form>

    <h2>📋 Liste des Tâches</h2>

    <table>
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
            <td><%= i + 1 %></td>
            <td class="<%= t.isTerminee() ? "terminee" : "" %>"><%= t.getTitre() %></td>
            <td class="<%= t.isTerminee() ? "terminee" : "" %>"><%= t.getDescription() %></td>
            <td><%= t.getDateEcheance() %></td>
            <td class="etat <%= t.isTerminee() ? "terminee" : "enCours" %>">
                <%= t.isTerminee() ? "Terminée ✅" : "En cours ⏳" %>
            </td>
            <td>
                <% if (!t.isTerminee()) { %>
                    <a href="?done=<%= i %>">Terminer</a> |
                <% } %>
                <a href="?delete=<%= i %>" style="color:red;">Supprimer</a>
            </td>
        </tr>
        <% } %>
    </table>

</body>
</html>
