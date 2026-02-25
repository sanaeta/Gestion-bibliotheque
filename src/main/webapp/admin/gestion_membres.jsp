<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f8fafc; }
        .header-bg { background: linear-gradient(135deg, #4f46e5 0%, #8c7ae6 100%); padding: 60px 0; color: white; text-align: center; margin-bottom: -40px; }
        .card-main { background: white; border-radius: 15px; border: none; padding: 30px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); }
    </style>
</head>
<body>
    <jsp:include page="/includes/navbar.jsp" /> <!-- Intégration de la navbar de l'étudiant C -->

    <div class="header-bg"><h1 class="fw-bold text-uppercase">Gestion des Adhérents</h1></div>

    <div class="container pb-5">
        <div class="card-main">
            <div class="d-flex justify-content-between mb-4">
                <form action="membres" method="get" class="w-50 d-flex">
                    <input type="text" name="search" class="form-control me-2" placeholder="Rechercher par nom...">
                    <button type="submit" class="btn btn-outline-primary"><i class="fa-solid fa-magnifying-glass"></i></button>
                </form>
                <button class="btn btn-primary shadow-sm" style="background:#4f46e5; border:none;">+ AJOUTER UN MEMBRE</button>
            </div>

            <table class="table align-middle">
                <thead class="table-light"><tr><th>ID</th><th>Nom</th><th>Email</th><th class="text-center">Actions</th></tr></thead>
                <tbody>
                    <c:forEach items="${membres}" var="m">
                        <tr>
                            <td><span class="badge bg-light text-primary">#${m.id}</span></td>
                            <td class="fw-bold">${m.nom}</td>
                            <td class="text-muted">${m.email}</td>
                            <td class="text-center">
                                <a href="#" class="btn btn-sm btn-light text-primary me-2"><i class="fa-solid fa-pen"></i></a>
                                <a href="membres?action=delete&id=${m.id}" class="btn btn-sm btn-light text-danger" onclick="return confirm('Supprimer ?')"><i class="fa-solid fa-trash"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>