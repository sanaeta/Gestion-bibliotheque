<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%-- Style spécifique pour matcher l'app React --%>
<style>
    .main-header { height: 90px; background: white; }
    .sub-nav { background-color: #f2f2f2; border-bottom: 4px solid #8c7ae6; min-height: 55px; }
    .nav-link-custom { 
        font-size: 11px; font-weight: 700; text-transform: uppercase; 
        color: #6b7280 !important; padding: 18px 25px !important;
        transition: all 0.3s;
    }
    .nav-link-custom:hover { color: #8c7ae6 !important; background: rgba(0,0,0,0.02); }
    .nav-active { background-color: white !important; color: #111827 !important; border-bottom: 0; }
</style>

<!-- Partie Haute : Logo et Déconnexion -->
<header class="main-header shadow-sm d-flex justify-content-between align-items-center px-5">
    <div class="d-flex align-items-center">
        <i class="fa-solid fa-book-bookmark fs-1 text-primary me-3" style="color: #4f46e5 !important;"></i>
        <h1 class="h4 fw-bold mb-0 text-uppercase tracking-tighter">Bibliothèque En Ligne</h1>
    </div>
    
    <div class="d-flex align-items-center">
        <span class="me-3 small text-muted fw-bold text-uppercase">${userSession.nom}</span>
        <form action="${pageContext.request.contextPath}/logout" method="post">
            <button type="submit" class="btn btn-danger btn-sm fw-bold text-uppercase px-4 shadow-sm" style="font-size: 10px;">
                Déconnexion
            </button>
        </form>
    </div>
</header>

<!-- Partie Basse : Liens dynamiques selon le Rôle -->
<nav class="sub-nav shadow-sm">
    <div class="container-fluid d-flex justify-content-end p-0 px-md-5">
        
        <!-- LIENS POUR LE BIBLIOTHÉCAIRE -->
        <c:if test="${userSession.role == 'ADMIN'}">
            <a href="dashboard" class="nav-link nav-link-custom">Tableau de bord</a>
            <a href="membres" class="nav-link nav-link-custom">Adhérents</a>
            <a href="gestion-livres" class="nav-link nav-link-custom">Gestion Ouvrages</a>
        </c:if>

        <!-- LIENS POUR L'ADHÉRENT -->
        <c:if test="${userSession.role == 'ADHERENT'}">
            <a href="catalogue" class="nav-link nav-link-custom">Catalogue</a>
            <a href="mes-emprunts" class="nav-link nav-link-custom">Mes Emprunts</a>
        </c:if>

        <!-- LIEN COMMUN -->
        <a href="profil" class="nav-link nav-link-custom">Mon Profil</a>
    </div>
</nav>