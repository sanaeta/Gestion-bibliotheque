<%@ page contentType="text/html;charset=UTF-8" %> 
<%@ taglib uri="jakarta.tags.core" prefix="c" %> 
<!DOCTYPE html> 
<html>
<head>
    <title>Formulaire Adhérent</title>
    <jsp:include page="/includes/header.jsp" />
</head>
<body>
    <jsp:include page="/includes/navbar.jsp" />

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm border-0 p-4">
                    <h2 class="h5 fw-bold text-uppercase text-secondary border-bottom pb-3 mb-4">
                        <c:choose>
                            <c:when test="${not empty membre.id}">Modifier l'Adhérent</c:when>
                            <c:otherwise>Ajouter un Adhérent</c:otherwise>
                        </c:choose>
                    </h2>

                    <form action="${pageContext.request.contextPath}/admin/membres" method="post">
                        <%-- On garde l'ID caché pour la modification --%>
                        <input type="hidden" name="id" value="${membre.id}">
                        
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-muted text-uppercase">Nom Complet</label>
                            <input name="nom" class="form-control" value="${membre.nom}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label small fw-bold text-muted text-uppercase">Adresse Email</label>
                            <input name="email" type="email" class="form-control" value="${membre.email}" required>
                        </div>
                        
                        <c:if test="${empty membre.id}">
                            <div class="mb-4">
                                <label class="form-label small fw-bold text-muted text-uppercase">Mot de passe</label>
                                <input name="password" type="password" class="form-control" required>
                            </div>
                        </c:if>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary fw-bold text-uppercase py-3" style="background-color: #4f46e5; border:none;">
                                Enregistrer
                            </button> 
                            <a href="${pageContext.request.contextPath}/admin/membres" class="btn btn-link text-muted text-decoration-none small fw-bold uppercase mt-2">Annuler</a> 
                        </div> 
                    </form> 
                </div> 
            </div>
        </div>
    </div> 
</body> 
</html>