<?php
// Ruta raíz del proyecto (sube desde /Backend/app/Controlador)
$rootPath = realpath(__DIR__ . "/../../../");

// Incluir modelo y base de datos
require_once $rootPath . "/Backend/app/Modelo/Usuario.php";
require_once $rootPath . "/Backend/app/Database/Database.php";

class UsuarioController {

    public function registrar($nombre, $correo, $contrasena, $rol) {
        $db = (new Database())->getConnection();
        $usuario = new Usuario($db);

        $usuario->nombre = $nombre;
        $usuario->correo_electronico = $correo;
        $usuario->contrasena = password_hash($contrasena, PASSWORD_BCRYPT); // 🔐 encriptación
        $usuario->rol = strtolower($rol); // siempre minúsculas

        return $usuario->crear();
    }

    public function login($correo, $contrasena) {
        $db = (new Database())->getConnection();
        $usuario = new Usuario($db);
        $datos = $usuario->buscarPorCorreo($correo);

        if ($datos && password_verify($contrasena, $datos['contrasena'])) {
            return $datos;
        }
        return false;
    }
}
?>
