<?php
// backend/app/Controlador/Logout.php
session_start();

// Vaciar todas las variables de sesión
$_SESSION = [];

// Destruir la sesión por completo
session_destroy();

// Redirigir al login (sirve para usuarios y administradores)
header("Location: ../../../../Frontend/public/login.php");
exit();
