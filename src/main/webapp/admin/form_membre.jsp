<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="/includes/navbar.jsp" />
    <div class="container mt-5">
        <div class="card shadow-sm mx-auto" style="max-width: 500px; border-radius: 15px;">
            <div class="card-header text-white text-center py-4" style="background: #4f46e5; border-radius: 15px 15px 0 0;">
                <h4 class="m-0">${not empty membre ? 'MODIFIER' : 'AJOUTER'} UN ADHÉRENT</h4>
            </div>
            <div class="card-body p-4">
                <form action="membres" method="post">
                    <!-- ID caché si c'est une modification -->
                    <input type="hidden" name="id" value="${membre.id}">
                    
                    <div class="mb-3">
                        <label class="form-label fw-bold">NOM COMPLET</label>
                        <input type="text" name="nom" class="form-control" value="${membre.nom}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">EMAIL</label>
                        <input type="email" name="email" class="form-control" value="${membre.email}" required>
                    </div>
                    
                    <!-- On ne demande le mot de passe que pour un nouveau membre -->
                    <c:if test="${empty membre}">
                        <div class="mb-4">
                            <label class="form-label fw-bold">MOT DE PASSE</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>
                    </c:if>

                    <button type="submit" class="btn btn-primary w-100 fw-bold py-2" style="background: #4f46e5;">ENREGISTRER</button>
                    <a href="membres" class="btn btn-link w-100 mt-2 text-muted text-decoration-none">Annuler</a>
                </form>
            </div>
        </div>
    </div>
</body>
</html>