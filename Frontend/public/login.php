<?php
session_start();
require_once "C:/xampp/htdocs/FitConnet/Backend/App/Controlador/UsuarioController.php";



if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $correo = $_POST['correo'] ?? '';
    $contrasena = $_POST['password'] ?? '';

    $controller = new UsuarioController();
    $usuario = $controller->login($correo, $contrasena);

    if ($usuario) {
        $_SESSION['usuario'] = $usuario;

        if ($usuario['rol'] === 'admin') {
            header("Location: administrador.php");
        } else {
            header("Location: usuario.php");
        }
        exit;
    } else {
        $error = "Correo o contraseña incorrectos";
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="../frontend/css/login.css">
</head>
<body>
<div class="formulario">
    <div class="campos">
        <h1>Inicio de sesión</h1>
        <?php if (isset($error)): ?>
            <div class="error-msg" style="color:red; text-align:center; margin-bottom:10px;">
                <?= htmlspecialchars($error) ?>
            </div>
        <?php endif; ?>

        <form id="loginForm" method="POST" autocomplete="off" novalidate>
            <div class="username">
                <input type="text" name="correo" id="correo" required>
                <label for="correo">Correo electrónico</label>
            </div>

            <div class="contraseña">
                <input type="password" name="password" id="password" required>
                <label for="password">Contraseña</label>
            </div>

            <input type="submit" value="Iniciar">
            <div class="registrarse">
                <a href="registro.php">Crear Cuenta</a>
            </div>
        </form>
    </div>
</div>
<script src="../frontend/js/login.js"></script>
</body>
</html>
