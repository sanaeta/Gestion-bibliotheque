<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<style>
    /* Styles pour copier exactement ton design React/Tailwind avec Bootstrap */
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

<!-- SECTION 1 : HEADER (Logo + Déconnexion) -->
<header class="main-header d-flex justify-content-between align-items-center px-5">
    <div class="d-flex align-items-center">
        <i class="fa-solid fa-book-bookmark fs-1 me-3" style="color: #4f46e5;"></i>
        <span class="logo-text">Bibliothèque <span style="color: #4f46e5;">En Ligne</span></span>
    </div>
    
    <div class="d-flex align-items-center">
        <span class="me-4 small text-muted fw-bold text-uppercase">
            <i class="fa-regular fa-circle-user me-1"></i> ${userSession.nom}
        </span>
        <form action="http://localhost:8080/gestion-bibliotheque/login.jsp" method="post" class="m-0">
            <a href="/logout" 
   class="btn btn-danger btn-sm fw-bold text-uppercase px-4 shadow-sm" 
   style="font-size: 10px; border-radius: 8px; text-decoration: none; display: inline-block;">
    Déconnexion
</a>
        </form>
    </div>
</header>

<!-- SECTION 2 : NAVBAR DYNAMIQUE (Logique des rôles) -->
<nav class="sub-nav">
    <div class="container-fluid d-flex justify-content-end p-0 px-md-5 h-100">
        
        <!-- LIEN COMMUN : Tableau de bord -->
        <a href="http://localhost:8080/gestion-bibliotheque/dashboard" class="nav-link-custom">Tableau de bord</a>

        <c:choose>
            <%-- LOGIQUE SI BIBLIOTHÉCAIRE (ADMIN) --%>
            <c:when test="${userSession.role == 'ADMIN'}">
                <a href="http://localhost:8080/gestion-bibliotheque/admin/membres" class="nav-link-custom">
                    <i class="fa-solid fa-users-gear me-2"></i> Adhérents
                </a>
                <a href="http://localhost:8080/gestion-bibliotheque/gestion-livres" class="nav-link-custom">
                    <i class="fa-solid fa-book-stack me-2"></i> Gestion Livres
                </a>
            </c:when>

            <%-- LOGIQUE SI ADHÉRENT (ADHERENT) --%>
            <c:otherwise>
                <a href="http://localhost:8080/gestion-bibliotheque/mes-emprunts" class="nav-link-custom">
                    <i class="fa-solid fa-box-archive me-2"></i> Mes Livres
                </a>
                <a href="http://localhost:8080/gestion-bibliotheque/catalogue" class="nav-link-custom">
                    <i class="fa-solid fa-magnifying-glass me-2"></i> Emprunter
                </a>
            </c:otherwise>
        </c:choose>

        <!-- LIEN COMMUN : Profil -->
        <a href="http://localhost:8080/gestion-bibliotheque/profil.jsp" class="nav-link-custom">
            <i class="fa-solid fa-user-pen me-2"></i> Profil
        </a>
    </div>
</nav>