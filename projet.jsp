<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*, java.text.*" %>

<%
    // Partie 1 : Logique Java
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

    // --- Fonction utilitaire pour formater la date ---
    String formatDateFR(String date) {
        try {
            Date d = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            return new SimpleDateFormat("dd-MM-yyyy").format(d);
        } catch (Exception e) {
            return date;
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
            font-family: "Roboto", "Segoe UI", Arial, sans-serif;
            background: #f2f5f9;
            margin: 0;
            padding: 0;
            color: #222;
        }

        header {
            background-color: #0b63ce;
            color: white;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        header h1 {
            font-size: 24px;
            margin: 0;
        }

        .btn-retour {
            background-color: white;
            color: #0b63ce;
            border: 1px solid #0b63ce;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        .btn-retour:hover {
            background-color: #eaf1fc;
        }

        main {
            max-width: 900px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        h2 {
            border-bottom: 2px solid #0b63ce;
            padding-bottom: 10px;
            color: #0b63ce;
        }

        form {
            margin-bottom: 30px;
        }

        label {
            font-weight: 600;
            display: block;
            margin-top: 10px;
        }

        input[type=text],
        input[type=date],
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            margin-top: 5px;
            transition: border 0.2s ease-in-out;
        }

        input[type=text]:focus,
        input[type=date]:focus,
        textarea:focus {
            border-color: #0b63ce;
            outline: none;
        }

        input[type=submit] {
            margin-top: 15px;
            background: #0b63ce;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s ease-in-out;
        }

        input[type=submit]:hover {
            background: #094fa5;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th {
            background-color: #0b63ce;
            color: white;
            padding: 10px;
            text-align: left;
        }

        td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        tr:hover {
            background: #f9fcff;
        }

        .terminee {
            text-decoration: line-through;
            color: #888;
        }

        a {
            color: #0b63ce;
            font-weight: bold;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        .etat {
            font-weight: bold;
            padding: 3px 8px;
            border-radius: 4px;
        }

        .etat.enCours {
            background-color: #fff3cd;
            color: #856404;
        }

        .etat.terminee {
            background-color: #d4edda;
            color: #155724;
        }

        footer {
            text-align: center;
            font-size: 14px;
            padding: 15px;
            color: #777;
            margin-top: 40px;
        }
    </style>
</head>
<body>

    <header>
        <h1>Mini Gestionnaire de Tâches</h1>
        <button class="btn-retour" onclick="window.location.href='index.html'">Retour à l’accueil</button>
    </header>

    <main>
        <h2>Ajouter une nouvelle tâche</h2>

        <form method="post">
            <label>Titre :</label>
            <input type="text" name="titre" required>

            <label>Description :</label>
            <textarea name="description" rows="3"></textarea>

            <label>Date d’échéance :</label>
            <input type="date" name="date">

            <input type="submit" name="ajouter" value="Ajouter la tâche">
        </form>

        <h2>Liste des tâches</h2>

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
                <td><%= formatDateFR(t.getDateEcheance()) %></td>
                <td>
                    <span class="etat <%= t.isTerminee() ? "terminee" : "enCours" %>">
                        <%= t.isTerminee() ? "Terminée" : "En cours" %>
                    </span>
                </td>
                <td>
                    <% if (!t.isTerminee()) { %>
                        <a href="?done=<%= i %>">Terminer</a> |
                    <% } %>
                    <a href="?delete=<%= i %>" style="color:red;" onclick="return confirm('Confirmer la suppression ?');">Supprimer</a>
                </td>
            </tr>
            <% } %>
        </table>
    </main>

    <footer>
        <p>Projet JSP - Gestionnaire de Tâches | Réalisé par Evan © 2025</p>
    </footer>

</body>
</html>
