<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Formulaire Adhérent</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-[#f8fafc]">
    <jsp:include page="/includes/navbar.jsp" />

    <main class="p-8">
        <div class="max-w-xl mx-auto bg-white p-8 border rounded shadow-sm mt-10">
            <h2 class="text-xl font-bold uppercase mb-6 text-gray-700 border-b pb-4">
                <c:choose>
                    <c:when test="${not empty membre}">Modifier l'Adhérent</c:when>
                    <c:otherwise>Ajouter un Adhérent</c:otherwise>
                </c:choose>
            </h2>

            <form action="${pageContext.request.contextPath}/admin/membres" method="post" class="space-y-4">
                <input type="hidden" name="id" value="${membre.id}">
                
                <div>
                    <label class="text-[10px] font-bold text-gray-400 uppercase">Nom Complet</label>
                    <input name="nom" class="w-full border p-3 rounded mt-1 focus:outline-indigo-500" value="${membre.nom}" required />
                </div>

                <div>
                    <label class="text-[10px] font-bold text-gray-400 uppercase">Adresse Email</label>
                    <input name="email" type="email" class="w-full border p-3 rounded mt-1 focus:outline-indigo-500" value="${membre.email}" required />
                </div>
                
                <c:if test="${empty membre}">
                    <div>
                        <label class="text-[10px] font-bold text-gray-400 uppercase">Mot de passe</label>
                        <input name="password" type="password" class="w-full border p-3 rounded mt-1 focus:outline-indigo-500" required />
                    </div>
                </c:if>

                <div class="pt-4">
                    <button type="submit" class="w-full bg-[#4f46e5] text-white font-bold py-3 rounded uppercase text-sm shadow-md hover:bg-indigo-700">
                        Enregistrer
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/membres" class="block text-center text-xs font-bold text-gray-400 uppercase mt-4 hover:text-gray-600">Annuler</a>
                </div>
            </form>
        </div>
    </main>
</body>
</html>