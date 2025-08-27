<?php
// frontend/public/administrador.php
session_start();

// Validar si está logueado como administrador
if (!isset($_SESSION['usuario']) || $_SESSION['rol'] !== 'admin') {
    header("Location: login.php");
    exit();
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Panel de Administrador</title>
  <link rel="stylesheet" href="../css/Admin.css">
  <script defer src="../js/Admin.js"></script>
</head>
<body>
  <!-- Barra de navegación -->
  <header class="navbar">
    <div class="logo-container">
      <img src="../img/logo.png" alt="FitConnet" class="logo">
    </div>

    <div class="menu-container">
      <button class="menu-btn">☰ Menú</button>
      <ul class="dropdown">
        <li><a href="#">Inicio</a></li>
        <li><a href="#">Nuestros servicios</a></li>
        <li><a href="#">Nuestros planes</a></li>
        <li><a href="#">Contáctanos</a></li>
      </ul>
    </div>

    <h1 class="navbar-title">FitConnet Control</h1>

    <div class="actions">
      <button>Chatear con la IA</button>
      <img src="../img/Profile_user.png" alt="Perfil" class="profile-pic">
      <a href="../backend/app/Controlador/Logout.php">
        <img src="../img/Cerrar_sesion.png" alt="Cerrar Sesión" class="logout-btn">
      </a>
    </div>
  </header>

  <!-- Contenido principal -->
  <main class="content">
    <h1>Bienvenido Administrador <?= $_SESSION['usuario']; ?></h1>

    <div class="carrusel-container">
      <button class="prev" onclick="moverCarrusel(-1)">&#10094;</button>
      <div class="carrusel">
        <div class="item">
          <img src="../img/Gestion_user.jpg" alt="Gestión de Usuarios">
          <h2>Gestión de Usuarios</h2>
        </div>
        <div class="item">
          <img src="../img/Gestion_planes.jpg" alt="Gestión de Planes">
          <h2>Gestión de Planes</h2>
        </div>
        <div class="item">
          <img src="../img/Configuracion.jpg" alt="Configuraciones">
          <h2>Configuraciones</h2>
        </div>
        <div class="item">
          <img src="../img/Reportes.jpg" alt="Reportes">
          <h2>Reportes</h2>
        </div>
      </div>
      <button class="next" onclick="moverCarrusel(1)">&#10095;</button>
    </div>
  </main>

  <script>
    const menuBtn = document.querySelector('.menu-btn');
    const dropdown = document.querySelector('.dropdown');

    menuBtn.addEventListener('click', (event) => {
      event.stopPropagation();
      dropdown.classList.toggle('show');
    });

    document.querySelectorAll('.dropdown a').forEach(link => {
      link.addEventListener('click', () => {
        dropdown.classList.remove('show');
      });
    });

    document.addEventListener('click', (event) => {
      if (!dropdown.contains(event.target) && !menuBtn.contains(event.target)) {
        dropdown.classList.remove('show');
      }
    });
  </script>
</body>
</html>