<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h2>Gestion des Adhérents</h2>
<table border="1">
    <tr><th>ID</th><th>Nom</th><th>Email</th><th>Actions</th></tr>
    <c:forEach items="${membres}" var="m">
        <tr>
            <td>${m.id}</td><td>${m.nom}</td><td>${m.email}</td>
            <td><a href="membres?action=delete&id=${m.id}">Supprimer</a></td>
        </tr>
    </c:forEach>
</table>