<?php
session_start();
require_once "C:/xampp/htdocs/FitConnet/Backend/App/Controlador/UsuarioController.php";



if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $nombre = $_POST['nombre'] ?? '';
    $correo = $_POST['correo'] ?? '';
    $contrasena = $_POST['password'] ?? '';
    $rol = $_POST['rol'] ?? 'usuario';

    $controller = new UsuarioController();
    $registrado = $controller->registrar($nombre, $correo, $contrasena, $rol);

    if ($registrado) {
        $_SESSION['usuario'] = [
            'nombre' => $nombre,
            'correo_electronico' => $correo,
            'rol' => strtolower($rol)
        ];

        if (strtolower($rol) === 'admin') {
            header("Location: administrador.php");
        } else {
            header("Location: usuario.php");
        }
        exit;
    } else {
        $error = "No se pudo registrar el usuario. El correo ya existe o hay un error.";
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro</title>
    <link rel="stylesheet" href="../frontend/css/registro.css">
</head>
<body>
<div class="register-container">
    <div class="form-section">
        <div class="logo">
            <img src="../img/logo.png" alt="Logo Fitconnet">
            <h1>Fitconnet</h1>
        </div>

        <div class="form-box">
            <h2><i>Crear Cuenta</i></h2>

            <?php if (isset($error)): ?>
                <div class="error-msg" style="color:red; text-align:center; margin-bottom:10px;">
                    <?= htmlspecialchars($error) ?>
                </div>
            <?php endif; ?>

            <form id="registerForm" method="POST" autocomplete="off" novalidate>
                <label for="nombre">Nombre</label>
                <input type="text" id="nombre" name="nombre" required>

                <label for="correo">Correo electrónico</label>
                <input type="email" id="correo" name="correo" required>

                <label for="password">Contraseña</label>
                <input type="password" id="password" name="password" required>

                <label for="rol">Registrarse como:</label>
                <select id="rol" name="rol">
                    <option value="usuario">Usuario</option>
                    <option value="admin">Administrador</option>
                </select>

                <input type="submit" value="Registrarse">
            </form>
        </div>

        <button class="facebook-btn">
            <img src="../img/facebook.png" alt="Facebook">
            Registrarse con Facebook
        </button>
    </div>
    <div class="image-section"></div>
</div>
<script src="../frontend/js/registro.js"></script>
</body>
</html>
