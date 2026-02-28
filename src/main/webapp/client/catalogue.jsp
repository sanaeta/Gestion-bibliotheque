<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <jsp:include page="/includes/header.jsp" />
    <title>Emprunter des livres</title>
</head>
<body class="bg-light">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="container mt-5">
        <%-- Titre de la section --%>
        <div class="mb-5">
            <h2 class="h4 fw-bold text-uppercase border-start border-4 border-primary ps-3" style="border-color: #8c7ae6 !important;">
                Emprunter un ouvrage
            </h2>
        </div>

        <div class="row g-4">
            <c:forEach items="${livres}" var="l">
                <div class="col-md-3">
                    <%-- Exactement le même design de carte que le Dashboard --%>
                    <div class="card xml-card shadow-sm border-0 p-4 bg-white h-100">
                        <div class="d-flex flex-column h-100">
                            
                            <%-- 1. NOM DU LIVRE (En haut) --%>
                            <div class="mb-4">
                                <p class="text-muted small fw-bold text-uppercase mb-1">Titre de l'ouvrage</p>
                                <h5 class="fw-bold text-dark mb-0">${l.titre}</h5>
                            </div>
                            
                            <%-- 2. BOUTON EMPRUNTER (En bas) --%>
                            <div class="mt-auto">
                                <c:choose>
                                    <c:when test="${l.quantiteDispo > 0}">
                                        <form action="${pageContext.request.contextPath}/emprunter" method="post" class="m-0">
                                            <input type="hidden" name="livreId" value="${l.id}">
                                            <button type="submit" class="btn btn-primary w-100 bg-main-purple border-0 fw-bold py-3 shadow-sm text-uppercase" style="font-size: 11px; letter-spacing: 1px; border-radius: 10px;">
                                                <i class="fa-solid fa-plus-circle me-2"></i> Emprunter
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-light w-100 text-muted fw-bold py-3 text-uppercase" style="font-size: 11px; border-radius: 10px;" disabled>
                                            Indisponible
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>