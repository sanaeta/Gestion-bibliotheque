<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Bibliothèque</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome (pour l'icône livre) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background-color: #f8fafc; /* Fond gris très léger comme sur la photo */
            display: flex;
            align-items: center;
            justify-content: center;
            min-vh-100;
            height: 100vh;
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .login-card {
            width: 100%;
            max-width: 450px;
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            border: none;
        }

        .login-header {
            background-color: #4f46e5; /* La couleur bleue/indigo de l'image */
            padding: 40px 20px;
            text-align: center;
            color: white;
        }

        .login-header i {
            font-size: 70px;
            margin-bottom: 15px;
        }

        .login-header h2 {
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            font-size: 24px;
            margin: 0;
        }

        .login-body {
            padding: 40px;
        }

        /* Sélecteur de rôle (Adhérent / Bibliothécaire) */
        .role-selector {
            display: flex;
            background-color: #f1f5f9;
            padding: 5px;
            border-radius: 12px;
            margin-bottom: 30px;
        }

        .role-btn {
            flex: 1;
            border: none;
            padding: 10px;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            border-radius: 8px;
            background: transparent;
            color: #64748b;
            transition: all 0.3s;
        }

        .role-btn.active {
            background: white;
            color: #4f46e5;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        /* Champs de saisie */
        .form-control {
            border-radius: 10px;
            padding: 15px;
            border: 1px solid #e2e8f0;
            margin-bottom: 20px;
            font-size: 15px;
        }

        .form-control:focus {
            border-color: #4f46e5;
            box-shadow: none;
        }

        /* Bouton Se Connecter */
        .btn-submit {
            background-color: #4f46e5;
            color: white;
            width: 100%;
            padding: 15px;
            border-radius: 10px;
            font-weight: 700;
            text-transform: uppercase;
            border: none;
            letter-spacing: 1px;
            transition: background 0.3s;
        }

        .btn-submit:hover {
            background-color: #4338ca;
        }
    </style>
</head>
<body>

    <div class="login-card shadow">
        <!-- Partie Bleue du haut -->
        <div class="login-header">
            <i class="fa-solid fa-book"></i>
            <h2>Connexion</h2>
        </div>

        <!-- Formulaire -->
        <div class="login-body">
            <form action="login" method="post">
                
                <!-- Sélecteur de rôle -->
                <div class="role-selector">
                    <button type="button" id="btnAdherent" class="role-btn active" onclick="setRole('ADHERENT')">Adhérent</button>
                    <button type="button" id="btnBiblio" class="role-btn" onclick="setRole('ADMIN')">Bibliothécaire</button>
                </div>

                <!-- Champ caché pour envoyer le rôle à la Servlet -->
                <input type="hidden" name="role" id="roleInput" value="ADHERENT">

                <input type="email" name="email" class="form-control" placeholder="Email" required>
                
                <input type="password" name="password" class="form-control" placeholder="Mot de passe" required>

                <button type="submit" class="btn-submit">Se connecter</button>

                <% if(request.getParameter("error") != null) { %>
                    <div class="text-danger text-center mt-3 small">Email ou mot de passe incorrect</div>
                <% } %>
            </form>
        </div>
    </div>

    <script>
        function setRole(role) {
            // Mise à jour de la valeur du champ caché
            document.getElementById('roleInput').value = role;

            // Gestion visuelle des boutons
            if (role === 'ADHERENT') {
                document.getElementById('btnAdherent').classList.add('active');
                document.getElementById('btnBiblio').classList.remove('active');
            } else {
                document.getElementById('btnBiblio').classList.add('active');
                document.getElementById('btnAdherent').classList.remove('active');
            }
        }
    </script>

</body>
</html>