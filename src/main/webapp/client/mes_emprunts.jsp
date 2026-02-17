<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %> <!-- C'est l'import moderne -->
<!DOCTYPE html>
<html>
<head>
    <title>Mes Emprunts</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
    </style>
</head>
<body>

    <h1>Livres que j'ai empruntés</h1>

    <c:if test="${not empty message}">
        <p style="color:green;">${message}</p>
    </c:if>

    <table>
        <thead>
            <tr>
                <th>Titre du Livre</th>
                <th>Date d'emprunt</th>
                <th>Date de retour prévue</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${emprunts}" var="e">
                <tr>
                    <td>${e.livre.titre}</td>
                    <td>${e.dateEmprunt}</td>
                    <td>${e.dateRetourPrevue}</td>
                    <td>
                        <!-- On prépare le bouton retour pour plus tard -->
                        <form action="retourner" method="post">
                            <input type="hidden" name="empruntId" value="${e.id}">
                            <button type="submit">Rendre le livre</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <br>
    <a href="catalogue_test.jsp">Retour au catalogue</a>

</body>
</html>