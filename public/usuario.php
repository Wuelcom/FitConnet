<?php
// frontend/public/usuario.php
session_start();

// Validar si está logueado como usuario
if (!isset($_SESSION['usuario']) || $_SESSION['rol'] !== 'user') {
    header("Location: login.php");
    exit();
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FitConnet - Usuario</title>
    <link rel="stylesheet" href="../css/FitConnet.css">
    <script defer src="../js/FitConnet.js"></script>
</head>
<body>
    <header class="section1">
        <div class="left-group"> 
            <div class="menu-container">
                <div class="menu-button">☰ Menú</div>
                <div class="menu-content">
                    <a href="#">Inicio</a>
                    <a href="#">Nuestros Servicios</a>
                    <a href="#">Planes</a>
                    <a href="#">Contacto</a>
                </div>
            </div>
            <img src="../img/logo.png" class="logo" alt="Logo Gimnasio">
        </div>
        <div class="center-buttons">
            <button>Inicio</button>
            <button>Nuestros Servicios</button>
            <button>Nuestros Planes</button>
            <button>Contacto</button>
        </div>
        <div class="right-buttons">
            <button id="chatIA">Chatear con la IA</button>
            <button id="perfil">Perfil</button>
            <a href="../backend/app/Controlador/Logout.php">
                <button id="cerrarSesion">Cerrar Sesión</button>
            </a>
        </div>
    </header>

    <section class="section2">
        <h1>Bienvenido <?= $_SESSION['usuario']; ?> a FitConnet</h1>
        <img src="../img/Seccion2.png" alt="Gimnasio" class="background-img">
    </section>

    <section class="section3">
        <h2>Nuestros Planes</h2>
        <div class="planes-container">
            <div class="plan">
                <img src="../img/plan1.jpg" alt="Plan 1">
                <p>Plan 1 - 1 mes - $50</p>
                <button>Comprar</button>
            </div>
            <div class="plan">
                <img src="../img/plan2.jpg" alt="Plan 2">
                <p>Plan 2 - 3 meses - $140</p>
                <button>Comprar</button>
            </div>
            <div class="plan">
                <img src="../img/plan3.jpg" alt="Plan 3">
                <p>Plan 3 - 6 meses - $270</p>
                <button>Comprar</button>
            </div>
        </div>
    </section>

    <section class="section4">
        <h2>Nuestros Servicios</h2>
        <div class="carousel">
            <div class="carousel-item">
                <img src="../img/ejercicio1.jpg" alt="Ejercicio en casa">
                <p>Ejercicios en casa</p>
                <button>Ver más</button>
            </div>
            <div class="carousel-item">
                <img src="../img/ejercicio2.jpg" alt="Ejercicio en gym">
                <p>Ejercicios en gym</p>
                <button>Ver más</button>
            </div>
            <div class="carousel-item">
                <img src="../img/ejercicio3.jpg" alt="Calistenia">
                <p>Calistenia</p>
                <button>Ver más</button>
            </div>
        </div>
    </section>

    <section class="section7">
        <h2>Contacto</h2>
        <div class="contact-info">
            <p>📧 Correo: contacto@fitconnet.com</p>
            <p>📞 Teléfono: +123 456 7890</p>
        </div>
    </section>

    <footer class="section8">
        <img src="../img/Logo.jpg" class="footer-logo" alt="Logo del pie de página">
        <div class="footer-text">
            <ul>
                <li><strong>Horarios de Atención:</strong></li>
                <li>Lunes a Viernes: 6:00 AM - 10:00 PM</li>
                <li>Sábados y Domingos: 8:00 AM - 6:00 PM</li>
            </ul>
            <ul>
                <li>© 2025 FitConnet - Todos los derechos reservados.</li>
            </ul>
        </div>
    </footer>
</body>
</html>