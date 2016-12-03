<?php

class Auth
{

    public static function login($username,$password){
        $userLogin = new Mahasiswa($username);
        if(is_null($userLogin->getUsername())){
            echo json_encode(array('status' => false, 'message' => 'User Not Found'));
        } else {
            if($userLogin->getPassword() == $password){
                session_start();
                $_SESSION['login'] = true;
                $_SESSION['username'] = $username;
                echo json_encode(array('status' => true, 'user' => $userLogin->getUserData()));
            }
        }
    }

    public static function logout(){
        session_start();
        if(isset($_SESSION['login'])){
            unset($_SESSION['login']);
            unset($_SESSION['username']);
            echo json_encode(array('status' => true));
        } else {
            echo json_encode(array('status' => false, 'message' => 'User Not Login'));
        }
    }

    public static function check(){
        session_start();
        echo json_encode(array('status' => isset($_SESSION['login'])));
    }


    public static function getUserData()
    {
        session_start();
        if(isset($_SESSION['username']) && isset($_SESSION['login'])){
            $username = $_SESSION['username'];
            $userLogin = new Mahasiswa($username);
            echo json_encode(array('status' => true, 'user' => $userLogin->getUserData(), 'login' => true));
        } else {
            echo json_encode(array('status' => false, 'message' => 'Not valid', 'login' => false));
        }
    }
}