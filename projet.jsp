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

    // Récupération de la liste de tâches depuis la session
    HttpSession maSession = request.getSession();
    ArrayList<Task> listeTaches = (ArrayList<Task>) maSession.getAttribute("taches");

    // Si la liste n'existe pas encore, on la crée
    if (listeTaches == null) {
        listeTaches = new ArrayList<Task>();
        maSession.setAttribute("taches", listeTaches);
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
    <p>✅ Test de la session et de la classe Task réussi (si rien ne plante, tout va bien)</p>

    <%
        // Petit test : on affiche combien de tâches il y a dans la session
        out.println("<p>Nombre de tâches en session : " + listeTaches.size() + "</p>");
    %>
</body>
</html>
