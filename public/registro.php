<?php
session_start();
require_once __DIR__ . "/../backend/app/Controlador/UsuarioController.php";

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    //var_dump($_POST); exit;
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
    <h2>Registro</h2>
    <?php if (isset($error)): ?>
        <p style="color:red;"><?php echo htmlspecialchars($error); ?></p>
    <?php endif; ?>

    <form method="POST" action="registro.php">
        <label>Nombre:</label>
        <input type="text" name="nombre" required><br>

        <label>Correo:</label>
        <input type="email" name="correo" required><br>

        <label>Contraseña:</label>
        <input type="password" name="password" required><br>

        <label>Rol:</label>
        <select name="rol">
            <option value="usuario">Usuario</option>
            <option value="admin">Administrador</option>
        </select><br><br>

        <button type="submit">Registrarse</button>
    </form>
</body>
</html>
