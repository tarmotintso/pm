<?php

class Controller
{
    public $template = 'master';
    public $requires_auth = false;
    public $errors = array();
    public $error_title = '';
    public $skip_main_action = false;

    function render($template)
    {
        // Make controller variables available to view
        extract(get_object_vars($this));

        // Load alerts
        $this->errors = is_array($this->errors) ? array_filter($this->errors) : NULL; //filter out null values from array
        if (!empty($this->errors)) {
            ob_start();
            include 'views/alerts/flash_error.php';
            $errors2 = ob_get_clean();
        }

        // Load view
        require 'templates/' . $template . '_template.php';
    }


} 
