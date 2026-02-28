<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/includes/header.jsp" />
    <title>Gestion des Livres</title>
</head>
<body class="bg-light">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="container mt-5">
        <div class="card shadow-sm border-0 p-4 rounded-4 bg-white">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="h4 fw-bold text-uppercase mb-0 text-dark">Liste des Ouvrages</h2>
                <%-- Bouton Ajouter --%>
                <a href="livres?action=add" class="btn btn-primary bg-main-purple border-0 fw-bold px-4 py-2" style="border-radius: 8px; font-size: 12px;">
                    + AJOUTER UN LIVRE
                </a>
            </div>

            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr class="small fw-bold text-muted text-uppercase">
                        <th>Titre</th>
                        <th>Auteur</th>
                        <th>ISBN</th>
                        <th class="text-center">Stock</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${livres}" var="l">
                        <tr>
                            <td class="fw-bold text-dark">${l.titre}</td>
                            <td class="text-muted">${l.auteur}</td>
                            <td><code>${l.isbn}</code></td>
                            <td class="text-center">
                                <span class="badge bg-light text-primary border px-3">${l.quantiteStock}</span>
                            </td>
                            <td class="text-center">
                                <%-- Bouton Modifier (SANS LE TIRÉ bleu) --%>
                                <a href="livres?action=edit&id=${l.id}" class="text-primary me-3 text-decoration-none">
                                    <i class="fa-solid fa-pen"></i>
                                </a>
                                <%-- Bouton Supprimer --%>
                                <a href="livres?action=delete&id=${l.id}" class="text-danger text-decoration-none" onclick="return confirm('Supprimer cet ouvrage ?')">
                                    <i class="fa-solid fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>