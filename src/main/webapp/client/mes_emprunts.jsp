<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Mes Emprunts | Bibliothèque</title>
    <%-- 1. On inclut le style Bootstrap et FontAwesome --%>
    <jsp:include page="/includes/header.jsp" />
</head>
<body>

    <%-- 2. On inclut la barre de navigation dynamique --%>
    <jsp:include page="/includes/navbar.jsp" />

    <div class="container mt-5 fade-in">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="h4 fw-bold text-uppercase text-dark">
                <i class="fa-solid fa-box-archive text-main-indigo me-2"></i>
                Mes Emprunts en Cours
            </h2>
            <span class="badge bg-main-purple px-3 py-2 text-uppercase">${emprunts.size()} Livres</span>
        </div>
        
        <%-- Affichage des messages d'erreur ou de succès --%>
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${sessionScope.message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <% session.removeAttribute("message"); %>
        </c:if>

        <%-- 3. Le Tableau avec le style de ton code React --%>
        <div class="card shadow-sm border-0 overflow-hidden">
            <table class="table table-hover mb-0">
                <thead class="table-light">
                    <tr style="font-size: 10px; color: #6b7280;" class="text-uppercase fw-bold">
                        <th class="p-4">Titre de l'ouvrage</th>
                        <th class="p-4">Date de sortie</th>
                        <th class="p-4">Retour Prévu</th>
                        <th class="p-4 text-center">Actions</th>
                    </tr>
                </thead>
                <tbody class="align-middle">
                    <c:forEach items="${emprunts}" var="e">
                        <tr>
                            <td class="p-4">
                                <div class="fw-semibold text-dark">${e.livre.titre}</div>
                                <div class="text-muted small">${e.livre.auteur}</div>
                            </td>
                            <td class="p-4 text-muted">${e.dateEmprunt}</td>
                            <td class="p-4">
                                <span class="text-danger fw-medium">${e.dateRetourPrevue}</span>
                            </td>
                            <td class="p-4 text-center">
                                <form action="retourner" method="post">
                                    <input type="hidden" name="empruntId" value="${e.id}">
                                    <button type="submit" class="btn btn-warning btn-sm fw-bold text-uppercase text-white px-4 shadow-sm" style="font-size: 10px;">
                                        <i class="fa-solid fa-arrow-rotate-left me-1"></i> Rendre
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty emprunts}">
                        <tr>
                            <td colspan="4" class="p-5 text-center text-muted italic">
                                Vous n'avez aucun emprunt en cours pour le moment.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        
    </div>

    <%-- Bootstrap JS bundle --%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>