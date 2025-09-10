<?php
class Database {
    private $host = "localhost";
    private $db_name = "FitConnet";
    private $username = "root";
    private $password = "";
    public $conn;

    public function getConnection() {
        $this->conn = null;
        try {
            $this->conn = new PDO(
                "mysql:host={$this->host};dbname={$this->db_name};charset=utf8",
                $this->username,
                $this->password,
                [
                    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, //  errores más claros
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, // resultados como array asociativo
                    PDO::ATTR_EMULATE_PREPARES => false // consultas preparadas seguras
                ]
            );
        } catch (PDOException $exception) {
            die("❌ Error de conexión: " . $exception->getMessage());
        }
        return $this->conn;
    }
}
?>
