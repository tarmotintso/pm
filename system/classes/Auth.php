<?php

/**
 * Class auth authenticates user and permits to check if the user has been logged in
 * Automatically loaded when the controller has $requires_auth property.
 */
class Auth
{

    public $logged_in = FALSE;

    function __construct()
    {
        if (isset($_SESSION['user_id'])) {
            $this->logged_in = TRUE;
        }
    }

    /**
     * Verifies if the user is logged in and authenticates if not and POST contains username, else displays the login form
     * @return bool Returns true when the user has been logged in
     */
    function require_auth()
    {
        global $errors;

        // If user has already logged in...
        if ($this->logged_in) {
            return TRUE;
        }

        // Authenticate by POST data
        if (isset($_POST['email']) && isset($_POST['password'])) {
            $email = $_POST['email'];
            $password = $_POST['password'];
            $sql = "SELECT id,password_hash, salt, first_name, last_name
                         FROM clients
                         WHERE email='$email'";
            $user = get_first($sql);


            if (!empty($user) && sha1($user['salt'].$password) == $user['password_hash']) {
                $_SESSION['user_id'] = $user['id'];
                $_SESSION['first_name'] = ucfirst(strtolower($user['first_name'])); //ucfirst makes string first character uppercase
                $_SESSION['last_name'] = ucfirst(strtolower($user['last_name'])); //strtolower makes string lowercase
                $this->logged_in = true;
                header('Location: /pm');
                exit();
            } else {
                $this->error_title2 = 'Vigane kasutajanimi või parool';
                $this->errors[] = "Vigane kasutajanimi või parool";

            }
        }


    }

}
