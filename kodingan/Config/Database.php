<?php

class Database
{
    protected $host = '127.0.0.1';
    protected $port = '5432';
    protected $dbname = 'postgres';
    protected $user = 'postgres';
    protected $password = 'luthfi109';

    public function __construct(){
        $this->connection =
            pg_connect("host=$this->host port=$this->port dbname=$this->dbname
                        user=$this->user password=$this->password");
            pg_query("SET SEARCH_PATH TO si_sidang");
    }

    public function getConnection(){
        return $this->connection;
    }

    public static function query($string){
        $db = new Database();
        $query = pg_query($db->getConnection(),$string);
        return $query;
    }

    public static function insert($string){
        $query = self::query($string);
        return $query;
    }

    public static function result($query){
        $query = self::query($query);
        $result = array();

        while($row = pg_fetch_assoc($query)){
            array_push($result,$row);
        }
        return $result;
    }


}