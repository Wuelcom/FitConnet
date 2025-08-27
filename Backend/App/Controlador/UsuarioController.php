<?php
require_once __DIR__ . "/../Modelo/Usuario.php";
require_once __DIR__ . "/../Modelo/database.php";

class UsuarioController {

    public function registrar($nombre, $correo, $contrasena, $rol) {
        $db = (new Database())->getConnection();
        $usuario = new Usuario($db);

        $usuario->nombre = $nombre;
        $usuario->correo_electronico = $correo;
        $usuario->contrasena = $contrasena;
        $usuario->rol = strtolower($rol); // siempre minúsculas
        // DEBUG
        // echo "ROL EN CONTROLADOR: " . $usuario->rol; exit;


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
