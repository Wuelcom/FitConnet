<?php
session_start();
require_once __DIR__ . "/../../Backend/App/Controlador/UsuarioController.php";

// Si no hay sesión, redirigir al login
if (!isset($_SESSION['usuario'])) {
    header("Location: login.php");
    exit();
}

$usuario = $_SESSION['usuario'];
$mensaje = "";

// Procesar actualización
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $nombre = $_POST['nombre'] ?? $usuario['nombre'];
    $correo = $_POST['correo'] ?? $usuario['correo_electronico'];
    $nuevaPass = $_POST['password'] ?? "";

    $controller = new UsuarioController();

    // Si envió contraseña nueva, actualizar con ella
    if (!empty($nuevaPass)) {
        $hash = password_hash($nuevaPass, PASSWORD_BCRYPT);
    } else {
        $hash = $usuario['contrasena']; // mantener la misma
    }

    // Conexión directa a DB para actualizar (puedes pasarlo a un método en Usuario)
    $db = (new Database())->getConnection();
    $stmt = $db->prepare("UPDATE usuarios SET nombre = :nombre, correo_electronico = :correo, contrasena = :contrasena WHERE id_usuario = :id");
    $stmt->bindParam(":nombre", $nombre);
    $stmt->bindParam(":correo", $correo);
    $stmt->bindParam(":contrasena", $hash);
    $stmt->bindParam(":id", $usuario['id_usuario']);
    
    if ($stmt->execute()) {
        // Actualizar sesión
        $_SESSION['usuario']['nombre'] = $nombre;
        $_SESSION['usuario']['correo_electronico'] = $correo;
        $_SESSION['usuario']['contrasena'] = $hash;

        $mensaje = "Datos actualizados correctamente ✅";
    } else {
        $mensaje = "Error al actualizar los datos ❌";
    }
}

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Perfil - FitConnet</title>
    <link rel="stylesheet" href="../css/FitConnet.css">
</head>
<body>
    <header>
        <h1>Perfil de <?= htmlspecialchars($usuario['nombre']); ?></h1>
        <nav>
            <a href="usuario.php">Inicio</a>
            <?php if ($usuario['rol'] === 'admin'): ?>
                <a href="administrador.php">Panel Admin</a>
            <?php endif; ?>
            <a href="../backend/app/Controlador/Logout.php">Cerrar Sesión</a>
        </nav>
    </header>

    <main>
        <h2>Información de tu cuenta</h2>
        <?php if ($mensaje): ?>
            <p style="color:green;"><?= htmlspecialchars($mensaje); ?></p>
        <?php endif; ?>

        <form method="POST">
            <label for="nombre">Nombre:</label>
            <input type="text" name="nombre" id="nombre" value="<?= htmlspecialchars($usuario['nombre']); ?>" required><br><br>

            <label for="correo">Correo:</label>
            <input type="email" name="correo" id="correo" value="<?= htmlspecialchars($usuario['correo_electronico']); ?>" required><br><br>

            <label for="password">Nueva Contraseña (opcional):</label>
            <input type="password" name="password" id="password"><br><br>

            <button type="submit">Actualizar Datos</button>
        </form>
    </main>

    <footer>
        <p>© 2025 FitConnet</p>
    </footer>
</body>
</html>
