<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Connexion - Bibliothèque</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <h2 class="text-center mb-4">Bibliothèque - Login</h2>
            <div class="card p-4 shadow-sm">
                <form action="login" method="post">
                    <div class="mb-3">
                        <label>Email :</label>
                        <input type="email" name="email" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label>Mot de passe :</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Se connecter</button>
                </form>
                <% if(request.getAttribute("erreur") != null) { %>
                    <div class="alert alert-danger mt-3"><%= request.getAttribute("erreur") %></div>
                <% } %>
            </div>
        </div>
    </div>
</div>
</body>
</html>