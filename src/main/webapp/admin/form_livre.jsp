<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/includes/header.jsp" />
    <title>Formulaire Livre</title>
</head>
<body class="bg-light">
    <jsp:include page="/includes/navbar.jsp" />

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm border-0 p-4 rounded-4">
                    <h2 class="h5 fw-bold text-uppercase text-secondary border-bottom pb-3 mb-4">
                        <c:choose>
                            <c:when test="${not empty livre.id}">Modifier l'ouvrage</c:when>
                            <c:otherwise>Ajouter un nouvel ouvrage</c:otherwise>
                        </c:choose>
                    </h2>

                    <form action="livres" method="post">
                        <input type="hidden" name="id" value="${livre.id}">
                        
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-muted text-uppercase">Titre du livre</label>
                            <input name="titre" class="form-control" value="${livre.titre}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label small fw-bold text-muted text-uppercase">Auteur</label>
                            <input name="auteur" class="form-control" value="${livre.auteur}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label small fw-bold text-muted text-uppercase">ISBN</label>
                            <input name="isbn" class="form-control" value="${livre.isbn}" required>
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label small fw-bold text-muted text-uppercase">Quantité en stock</label>
                            <input name="quantite" type="number" class="form-control" value="${livre.quantiteStock}" min="1" required>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary fw-bold text-uppercase py-3 bg-main-purple border-0 shadow">
                                Enregistrer les données
                            </button> 
                            <a href="livres?action=gestion" class="btn btn-link text-muted text-decoration-none small fw-bold">Annuler</a> 
                        </div> 
                    </form> 
                </div> 
            </div>
        </div>
    </div>
</body>
</html>