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
    <h2>Iniciar Sesión</h2>
    <?php if (isset($error)): ?>
        <p style="color:red;"><?php echo htmlspecialchars($error); ?></p>
    <?php endif; ?>

    <form method="POST" action="login.php">
        <label>Correo:</label>
        <input type="email" name="correo" required><br>

        <label>Contraseña:</label>
        <input type="password" name="password" required><br>

        <button type="submit">Ingresar</button>
    </form>
</body>
</html>
