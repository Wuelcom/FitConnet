<?php
class Usuario {
    private $conn;
    private $table_name = "usuarios";

    public $id_usuario;
    public $nombre;
    public $correo_electronico;
    public $contrasena;
    public $rol;

    public function __construct($db) {
        $this->conn = $db;
    }

    // Crear usuario
    public function crear() {
        $query = "INSERT INTO " . $this->table_name . " 
                  (nombre, correo_electronico, contrasena, rol) 
                  VALUES (:nombre, :correo_electronico, :contrasena, :rol)";
        $stmt = $this->conn->prepare($query);

        // Encriptar contraseña
        $this->contrasena = password_hash($this->contrasena, PASSWORD_BCRYPT);

        $stmt->bindParam(":nombre", $this->nombre);
        $stmt->bindParam(":correo_electronico", $this->correo_electronico);
        $stmt->bindParam(":contrasena", $this->contrasena);
        $stmt->bindParam(":rol", $this->rol);

        // DEBUG: Verifica el valor del rol antes de guardar
        // Quita esto después de probar
        // echo "ROL A GUARDAR: " . $this->rol; exit;

        return $stmt->execute();
    }

    // Buscar usuario por correo
    public function buscarPorCorreo($correo) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE correo_electronico = :correo LIMIT 1";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":correo", $correo);
        $stmt->execute();

        return $stmt->fetch(PDO::FETCH_ASSOC);
    }
}
?>
