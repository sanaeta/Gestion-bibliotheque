<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mon Profil - Bibliothèque</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f8fafc; font-family: 'Inter', sans-serif; }
        .profile-header {
            background: linear-gradient(135deg, #4f46e5 0%, #8c7ae6 100%);
            padding: 60px 0;
            color: white;
            text-align: center;
        }
        .profile-card {
            background: white;
            border-radius: 20px;
            margin-top: -50px;
            padding: 40px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            border: none;
        }
        .info-label { font-size: 12px; font-weight: bold; color: #64748b; text-transform: uppercase; letter-spacing: 1px; }
        .info-value { font-size: 16px; font-weight: 600; color: #1e293b; margin-bottom: 20px; }
        .btn-update { background: #4f46e5; color: white; border-radius: 10px; padding: 12px; font-weight: bold; border: none; width: 100%; transition: 0.3s; }
        .btn-update:hover { background: #4338ca; transform: translateY(-2px); }
    </style>
</head>
<body>

    <!-- On inclut la Navbar de l'étudiant C -->
    <jsp:include page="/includes/navbar.jsp" />

    <div class="profile-header">
        <div class="container">
            <i class="fa-solid fa-circle-user fa-5x mb-3"></i>
            <h1 class="fw-bold text-uppercase">Mon Profil</h1>
            <p class="opacity-75">Gérez vos informations personnelles</p>
        </div>
    </div>

    <div class="container pb-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="profile-card">
                    
                    <c:if test="${not empty param.success}">
                        <div class="alert alert-success border-0 shadow-sm mb-4">
                            <i class="fa-solid fa-check-circle me-2"></i> Profil mis à jour avec succès !
                        </div>
                    </c:if>

                    <form action="profil" method="post">
                        <div class="row">
                            <div class="col-md-12">
                                <label class="info-label">Nom Complet</label>
                                <input type="text" name="nom" class="form-control info-value py-2" value="${userSession.nom}" required>
                            </div>
                            
                            <div class="col-md-12">
                                <label class="info-label">Adresse Email</label>
                                <input type="email" name="email" class="form-control info-value py-2" value="${userSession.email}" required>
                            </div>

                            <div class="col-md-12">
                                <label class="info-label">Nouveau Mot de passe (laisser vide pour ne pas changer)</label>
                                <input type="password" name="password" class="form-control info-value py-2" placeholder="••••••••">
                            </div>

                            <div class="col-md-12 mt-3">
                                <div class="p-3 bg-light rounded-3 mb-4">
                                    <div class="d-flex justify-content-between">
                                        <span class="info-label">Type de compte</span>
                                        <span class="badge ${userSession.role == 'ADMIN' ? 'bg-danger' : 'bg-primary'} text-uppercase">
                                            ${userSession.role}
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12">
                                <button type="submit" class="btn-update shadow-sm">
                                    <i class="fa-solid fa-floppy-disk me-2"></i> ENREGISTRER LES MODIFICATIONS
                                </button>
                            </div>
                        </div>
                    </form>
                    
                    <div class="text-center mt-4">
                        <a href="logout" class="text-danger fw-bold text-decoration-none small">
                            <i class="fa-solid fa-right-from-bracket me-1"></i> SE DÉCONNECTER
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>