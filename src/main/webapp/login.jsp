<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f8fafc; height: 100vh; display: flex; align-items: center; justify-content: center; font-family: 'Inter', sans-serif; }
        .login-card { width: 420px; background: white; border-radius: 20px; overflow: hidden; box-shadow: 0 15px 35px rgba(0,0,0,0.1); }
        .login-header { background: linear-gradient(135deg, #4f46e5 0%, #8c7ae6 100%); padding: 40px; text-align: center; color: white; }
        .role-selector { display: flex; background: #f1f5f9; padding: 5px; border-radius: 12px; margin-bottom: 25px; }
        .role-btn { flex: 1; border: none; padding: 10px; font-size: 11px; font-weight: bold; text-transform: uppercase; border-radius: 8px; background: transparent; color: #64748b; }
        .role-btn.active { background: white; color: #4f46e5; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        .btn-submit { background: #4f46e5; color: white; width: 100%; padding: 14px; border-radius: 12px; font-weight: bold; border: none; text-transform: uppercase; letter-spacing: 1px; }
    </style>
</head>
<body>
    <div class="login-card shadow">
        <div class="login-header"><i class="fa-solid fa-book-open fa-4x mb-3"></i><h2 class="fw-bold">CONNEXION</h2></div>
        <div class="p-5">
            <form action="login" method="post">
                <div class="role-selector">
                    <button type="button" id="btnAdh" class="role-btn active" onclick="setR('ADHERENT')">Adhérent</button>
                    <button type="button" id="btnLib" class="role-btn" onclick="setR('ADMIN')">Bibliothécaire</button>
                </div>
                <input type="hidden" name="role" id="roleInput" value="ADHERENT">
                <div class="mb-3"><input type="email" name="email" class="form-control p-3" placeholder="Email" required></div>
                <div class="mb-4"><input type="password" name="password" class="form-control p-3" placeholder="Mot de passe" required></div>
                <button type="submit" class="btn-submit">Se connecter</button>
                <% if(request.getParameter("error") != null) { %> <div class="text-danger text-center mt-3 small">Identifiants incorrects</div> <% } %>
            </form>
        </div>
    </div>
    <script>
        function setR(r){
            document.getElementById('roleInput').value = r;
            document.getElementById('btnAdh').classList.toggle('active', r === 'ADHERENT');
            document.getElementById('btnLib').classList.toggle('active', r === 'ADMIN');
        }
    </script>
</body>
</html>