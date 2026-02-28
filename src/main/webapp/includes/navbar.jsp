<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<style>
    .main-header { height: 90px; background: white; border-bottom: 1px solid #e5e7eb; }
    .sub-nav { background-color: #f2f2f2; border-bottom: 4px solid #8c7ae6; min-height: 55px; }
    .nav-link-custom { 
        font-size: 11px; font-weight: 700; text-transform: uppercase; 
        color: #6b7280 !important; padding: 18px 25px !important;
        text-decoration: none; display: flex; align-items: center;
    }
    .nav-link-custom:hover { color: #8c7ae6 !important; background: rgba(0,0,0,0.02); }
    .nav-active { background-color: white !important; color: #111827 !important; }
    .logo-text { font-size: 20px; font-weight: 800; text-transform: uppercase; letter-spacing: -0.5px; }
</style>

<header class="main-header d-flex justify-content-between align-items-center px-5">
    <div class="d-flex align-items-center">
        <i class="fa-solid fa-book-bookmark fs-1 me-3" style="color: #4f46e5;"></i>
        <span class="logo-text">Bibliothéque <span style="color: #4f46e5;">En Ligne</span></span>
    </div>
    
    <div class="d-flex align-items-center">
        <span class="me-4 small text-muted fw-bold text-uppercase">
            <i class="fa-regular fa-circle-user me-1"></i> ${userSession.nom}
        </span>
        <form action="http://localhost:8080/gestion-bibliotheque/login.jsp" method="post" class="m-0">
            <button type="submit" class="btn btn-danger btn-sm fw-bold text-uppercase px-4 shadow-sm" style="font-size: 10px; border-radius: 8px;">
                Déconnexion
            </button>
        </form>
    </div>
</header>

<nav class="sub-nav">
    <div class="container-fluid d-flex justify-content-end p-0 px-md-5 h-100">
        
        <a href="${pageContext.request.contextPath}/livres?action=dashboard" class="nav-link-custom">Tableau de bord</a>

        <c:choose>
            <c:when test="${userSession.role == 'ADMIN'}">
                <a href="http://localhost:8080/gestion-bibliotheque/admin/membres" class="nav-link-custom">
                    <i class="fa-solid fa-users-gear me-2"></i> Adhérents
                </a>
                <a href="${pageContext.request.contextPath}/livres?action=gestion" class="nav-link-custom">
                    <i class="fa-solid fa-book-stack me-2"></i> Gestion Livres
                </a>
            </c:when>
            
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/mes-emprunts?action=mes_livres" class="nav-link-custom">
                    <i class="fa-solid fa-box-archive me-2"></i> Mes Livres
                </a>
                <a  href="${pageContext.request.contextPath}/livres?action=catalogue" class="nav-link-custom">
                    <i class="fa-solid fa-magnifying-glass me-2"></i> Emprunter
                </a>
            </c:otherwise>
        </c:choose>
        <!--  COMMUN : Profil -->
        <a href="http://localhost:8080/gestion-bibliotheque/profil.jsp" class="nav-link-custom">
            <i class="fa-solid fa-user-pen me-2"></i> Profil
        </a>
    </div>
</nav>
