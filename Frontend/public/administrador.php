<?php
// frontend/public/administrador.php
session_start();

$rootPath = realpath(__DIR__ . "/../../");

// Validar rol administrador
if (!isset($_SESSION['usuario']) || $_SESSION['usuario']['rol'] !== 'administrador') {
    header("Location: login.php");
    exit();
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FitConnet - Administrador</title>
    <link rel="stylesheet" href="../css/FitConnet.css">
    <script defer src="../js/FitConnet.js"></script>
</head>
<body>
    <header class="section1">
        <div class="left-group"> 
            <div class="menu-container">
                <div class="menu-button">☰ Menú</div>
                <div class="menu-content">
                    <a href="#">Panel</a>
                    <a href="#">Usuarios</a>
                    <a href="#">Planes</a>
                    <a href="#">Reportes</a>
                </div>
            </div>
            <img src="../img/logo.png" class="logo" alt="Logo Gimnasio">
        </div>
        <div class="center-buttons">
            <button>Panel</button>
            <button>Usuarios</button>
            <button>Planes</button>
            <button>Reportes</button>
        </div>
        <div class="right-buttons">
            <button id="perfil">Perfil</button>
            <!-- Cerrar sesión -->
            <a href="../../Backend/app/Controlador/Logout.php">
                <button id="cerrarSesion">Cerrar Sesión</button>
            </a>
        </div>
    </header>

    <section class="section2">
        <h1>Bienvenido <?= htmlspecialchars($_SESSION['usuario']['nombre']); ?> (Administrador)</h1>
        <img src="../img/admin_dashboard.png" alt="Panel Administrador" class="background-img">
    </section>

    <section class="section3">
        <h2>Gestión</h2>
        <div class="planes-container">
            <div class="plan">
                <img src="../img/gestion_usuarios.jpg" alt="Gestión de usuarios">
                <p>Gestión de usuarios</p>
                <button>Entrar</button>
            </div>
            <div class="plan">
                <img src="../img/gestion_planes.jpg" alt="Gestión de planes">
                <p>Gestión de planes</p>
                <button>Entrar</button>
            </div>
            <div class="plan">
                <img src="../img/configuraciones.jpg" alt="Configuraciones">
                <p>Configuraciones</p>
                <button>Entrar</button>
            </div>
            <div class="plan">
                <img src="../img/reportes.jpg" alt="Reportes">
                <p>Reportes</p>
                <button>Entrar</button>
            </div>
        </div>
    </section>

    <footer class="section8">
        <img src="../img/Logo.jpg" class="footer-logo" alt="Logo del pie de página">
        <div class="footer-text">
            <ul>
                <li><strong>Soporte Técnico:</strong></li>
                <li>Correo: soporte@fitconnet.com</li>
                <li>Teléfono: +123 456 7899</li>
            </ul>
            <ul>
                <li>© 2025 FitConnet - Todos los derechos reservados.</li>
            </ul>
        </div>
    </footer>
</body>
</html>
