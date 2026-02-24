<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion des Adhérents - Bibliothèque</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome (Icones) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8fafc;
            color: #1e293b;
        }

        /* En-tête avec dégradé brillant */
        .page-header {
            background: linear-gradient(135deg, #4f46e5 0%, #8c7ae6 100%);
            padding: 40px 0;
            margin-bottom: -50px; /* Effet de chevauchement */
            color: white;
        }

        /* Carte contenant le tableau */
        .content-card {
            background: white;
            border-radius: 15px;
            border: none;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            padding: 30px;
        }

        /* Style du tableau */
        .table {
            vertical-align: middle;
        }
        .table thead {
            background-color: #f1f5f9;
            text-transform: uppercase;
            font-size: 11px;
            letter-spacing: 1px;
            color: #64748b;
        }
        .table tbody tr:hover {
            background-color: #f8fafc;
        }

        /* Badges et Boutons */
        .badge-id {
            background-color: #eef2ff;
            color: #4f46e5;
            font-weight: 600;
            padding: 5px 10px;
            border-radius: 6px;
        }
        .btn-action {
            width: 32px;
            height: 32px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            transition: 0.3s;
            text-decoration: none;
        }
        .btn-edit { background: #e0f2fe; color: #0369a1; }
        .btn-delete { background: #fee2e2; color: #b91c1c; }
        .btn-edit:hover { background: #0369a1; color: white; }
        .btn-delete:hover { background: #b91c1c; color: white; }

        /* Barre de recherche */
        .search-bar {
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            padding-left: 40px;
        }
        .search-container { position: relative; }
        .search-container i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
        }
    </style>
</head>
<body>

    <!-- Header Section -->
    <div class="page-header text-center">
        <div class="container">
            <h1 class="fw-bold text-uppercase tracking-widest">Gestion des Adhérents</h1>
            <p class="opacity-75">Administrez les membres de votre bibliothèque</p>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container mt-5 pb-5">
        <div class="content-card">
            
            <!-- Barre d'outils (Recherche + Ajout) -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div class="search-container w-50">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text" class="form-control search-bar" placeholder="Rechercher un membre par nom ou email...">
                </div>
                <a href="nouveau_membre.jsp" class="btn btn-primary px-4 py-2 fw-bold shadow-sm" style="background: #4f46e5; border-radius: 10px; border: none;">
                    <i class="fa-solid fa-plus me-2"></i> AJOUTER UN MEMBRE
                </a>
            </div>

            <!-- Tableau moderne -->
            <div class="table-responsive">
                <table class="table border-0">
                    <thead>
                        <tr>
                            <th class="border-0">ID</th>
                            <th class="border-0">Nom complet</th>
                            <th class="border-0">Email</th>
                            <th class="border-0 text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Utilisation de JSTL pour boucler sur les membres -->
                        <c:forEach items="${membres}" var="m">
                            <tr>
                                <td><span class="badge-id">#${m.id}</span></td>
                                <td class="fw-bold text-dark">${m.nom} ${m.prenom}</td>
                                <td class="text-muted">${m.email}</td>
                                <td class="text-center">
                                    <a href="membres?action=edit&id=${m.id}" class="btn-action btn-edit me-2" title="Modifier">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                    </a>
                                    <a href="membres?action=delete&id=${m.id}" class="btn-action btn-delete" 
                                       title="Supprimer" onclick="return confirm('Supprimer cet adhérent ?')">
                                        <i class="fa-solid fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <!-- Message si la liste est vide -->
                        <c:if test="${empty membres}">
                            <tr>
                                <td colspan="4" class="text-center py-5 text-muted">
                                    <i class="fa-solid fa-users-slash d-block mb-3 fs-1"></i>
                                    Aucun adhérent trouvé.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>