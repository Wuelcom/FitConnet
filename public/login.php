<?php
session_start();
require_once __DIR__ . "/../backend/app/Controlador/UsuarioController.php";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $correo = $_POST['correo'] ?? '';
    $contrasena = $_POST['password'] ?? '';

    $controller = new UsuarioController();
    $usuario = $controller->login($correo, $contrasena);

    if ($usuario) {
        $_SESSION['usuario'] = $usuario;

        // echo "ROL: " . htmlspecialchars($usuario['rol']);
        // exit;

        // Redirigir según el rol correcto
        if ($usuario['rol'] === 'admin') {
            header("Location: administrador.php");
        } else {
            header("Location: usuario.php");
        }
        //echo "Redirigiendo...";
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
                <div class="error-msg" style="color:red; text-align:center; margin-bottom:10px;"> <?= htmlspecialchars($error) ?> </div>
            <?php endif; ?>
            <form id="loginForm" method="POST" autocomplete="off" novalidate>
                <div class="username">
                    <input type="text" name="correo" id="correo" required>
                    <label for="correo">Correo electrónico</label>
                    <span id="correoErr" class="error-msg" hidden>Ingrese un correo válido</span>
                </div>
                <div class="contraseña">
                    <input type="password" name="password" id="password" required>
                    <label for="password">Contraseña</label>
                    <span id="passErr" class="error-msg" hidden>La contraseña es obligatoria</span>
                </div>
                <div class="recordar"><a href="#">¿Ha olvidado su contraseña?</a></div>
                <input type="submit" value="Iniciar">
                <div class="registrarse">
                    <a href="registro.php">Crear Cuenta</a>
                </div>
            </form>
        </div>
    </div>

    <div class="imagen-izquierda">
        <!-- Parte izquierda: imagen -->
        <div class="left">
            <img src="../img/gym-imagen.png" alt="Persona usando celular en el gimnasio">
        </div>

        <!-- Parte derecha: formulario -->
        <div class="formulario">
            <div class="logo">
                <img src="../img/logo.png" alt="Logo Fitconnet">
                <h1>Fitconnet</h1>
            </div>

            <div class="login-box"> 
                <h2><u>Login</u></h2>
                <form>
                    <label for="usuario">Usuario:</label>
                    <input type="text" id="usuario" name="usuario" required>

                    <label for="contrasena">Contraseña:</label>
                    <input type="password" id="contrasena" name="contrasena" required>

                    <div class="links">
                    <a href="#">¿Olvidaste la contraseña?</a>
                    <a href="../Register/Register.html">Crear cuenta</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="../frontend/js/login.js"></script>
</body>
</html>
