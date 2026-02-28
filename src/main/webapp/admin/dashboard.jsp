<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <jsp:include page="/includes/header.jsp" />
    <title>liste des ouvrages</title>
</head>
<body>
    <%-- 1. La Navbar commune --%>
    <jsp:include page="/includes/navbar.jsp" />
    <%-- BANDEAU DE BIENVENUE PERSONNALISÉ --%>
<div class="container mt-4">
    <div class="p-4 mb-5 shadow-sm border-0 rounded-4 text-white d-flex align-items-center justify-content-between" 
         style="background: linear-gradient(135deg, #4f46e5 0%, #8c7ae6 100%);">
        <div>
            <h2 class="fw-bold mb-1">Bienvenue, ${userSession.nom} ! </h2>
            <p class="mb-0 opacity-75">
                <c:choose>
                    <c:when test="${userSession.role == 'ADMIN'}">
                        Vous êtes sur votre espace de gestion. 
                    </c:when>
                    <c:otherwise>
                        Heureux de vous revoir ! Quel livre souhaitez-vous découvrir aujourd'hui ?
                    </c:otherwise>
                </c:choose>
            </p>
        </div>
        <div class="d-none d-md-block">
            <span class="badge bg-white text-primary px-3 py-2 rounded-pill fw-bold text-uppercase" style="font-size: 10px; color: #4f46e5 !important;">
                Rôle : ${userSession.role}
            </span>
        </div>
    </div>
</div>

    <div class="container mt-5">
        
        <c:choose>
            <%-- ================= CAS ADMIN : STATISTIQUES ================= --%>
            <c:when test="${userSession.role == 'ADMIN'}">
                <div class="d-flex align-items-center mb-4">
                    <i class="fa-solid fa-chart-line text-main-indigo fs-2 me-3"></i>
                    <h2 class="h4 fw-bold text-uppercase mb-0">Tableau de Bord Administrateur</h2>
                </div>

                <div class="row g-4">
                    <!-- Carte Livres -->
                    <div class="col-md-4">
                        <div class="card xml-card shadow-sm border-0 p-4 bg-white border-bottom border-4" style="border-color: #8c7ae6 !important;">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="text-muted small fw-bold text-uppercase mb-1">Total Ouvrages</p>
                                    <h2 class="fw-bold mb-0">${nbLivres}</h2>
                                </div>
                                <div class="bg-main-purple p-3 rounded-circle text-white shadow-sm">
                                    <i class="fa-solid fa-book fs-4"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Carte Membres -->
                    <div class="col-md-4">
                        <div class="card xml-card shadow-sm border-0 p-4 bg-white border-bottom border-4" style="border-color: #8c7ae6 !important;">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="text-muted small fw-bold text-uppercase mb-1">Adhérents Actifs</p>
                                    <h2 class="fw-bold mb-0">${nbMembres}</h2>
                                </div>
                                <div class="bg-main-purple p-3 rounded-circle text-white shadow-sm">
                                    <i class="fa-solid fa-users fs-4"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Carte Emprunts -->
                    <div class="col-md-4">
                        <div class="card xml-card shadow-sm border-0 p-4 bg-white border-bottom border-4" style="border-color: #8c7ae6 !important;">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="text-muted small fw-bold text-uppercase mb-1">Emprunts en cours</p>
                                    <h2 class="fw-bold mb-0">${nbEmprunts}</h2>
                                </div>
                                <div class="bg-main-purple p-3 rounded-circle text-white shadow-sm">
                                    <i class="fa-solid fa-clock-rotate-left fs-4"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>

            <%-- ================= CAS ADHÉRENT : TABLEAU DE BORD (CONSULTATION) ================= --%>
<c:otherwise>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="h4 fw-bold text-uppercase mb-0">Liste des ouvrages</h2>
            <p class="text-muted small">Consultez l'ensemble de nos ouvrages et leur disponibilité</p>
        </div>
        
        <%-- Barre de recherche --%>
        <form action="livres" method="get" class="d-flex w-25">
            <input type="hidden" name="action" value="dashboard">
            <input type="text" name="search" class="form-control form-control-sm me-2 rounded-pill ps-3" placeholder="Rechercher...">
            <button class="btn btn-sm btn-primary bg-main-purple border-0 rounded-circle shadow-sm">
                <i class="fa-solid fa-magnifying-glass"></i>
            </button>
        </form>
    </div>

    <div class="row g-4">
        <c:forEach items="${livres}" var="l">
            <div class="col-md-3">
                <div class="card xml-card h-100 shadow-sm border-0 bg-white p-2">
                    <div class="card-body text-center">
                        <%-- Icône du livre --%>
                        <div class="bg-light rounded-3 py-4 mb-3">
                            <i class="fa-solid fa-book-open fa-3x text-main-indigo opacity-50"></i>
                        </div>
                        
                        <%-- Infos du livre --%>
                        <h6 class="fw-bold text-dark mb-1 text-truncate" title="${l.titre}">${l.titre}</h6>
                        <p class="text-muted small mb-3">${l.auteur}</p>
                        
                        <%-- Disponibilité (Badge) --%>
                        <div class="pt-3 border-top">
                            <c:choose>
                                <c:when test="${l.quantiteDispo > 0}">
                                    <span class="badge bg-success-subtle text-success rounded-pill px-3 py-2 w-100">
                                        <i class="fa-solid fa-check me-1"></i> ${l.quantiteDispo} DISPONIBLES
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-danger-subtle text-danger rounded-pill px-3 py-2 w-100">
                                        <i class="fa-solid fa-xmark me-1"></i> EN RUPTURE
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</c:otherwise>
                                       
        </c:choose>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>