<?php
/**
 * Created by PhpStorm.
 * User: henno
 * Date: 9/16/13
 * Time: 11:17 PM
 */

class Application
{
    public $auth = null;
    public $params = null;
    public $action = 'index';
    public $controller = DEFAULT_CONTROLLER;

    function __construct()
    {
        ob_start();
        session_start();

        $this->initialize_translation();
        $this->load_common_functions();
        $this->set_base_url();
        $this->load_config();
        $this->process_uri();
        $this->handle_routing();

        $this->auth = new Auth;
        $this->init_db();


        // Instantiate controller

        if (!file_exists("controllers/$this->controller.php"))
            error_out("<b>Error:</b> File <i>controllers/{$this->controller}.php</i> does not exist.");
        require "controllers/$this->controller.php";

        if (!class_exists($this->controller, false))
            error_out("<b>Error:</b>
				File  <i>controllers/{$this->controller}.php</i> exists but class <i>{$this->controller}</i> does not. You probably copied the file but forgot to rename the class in the copy.");
        $controller = new $this->controller;

        // Make request and auth properties available to controller
        $controller->controller = $this->controller;
        $controller->action = $this->action;
        $controller->params = $this->params;
        $controller->auth = $this->auth;

        // Check if the user has extended Controller
        if (!isset($controller->requires_auth)) {
            $errors[] = 'You forgot the "<i>extends Controller</i>" part for the class <i>' . $controller->controller . '</i> in controllers/' . $controller->controller . '.php</i>. Fix it.';
            require 'templates/error_template.php';
            exit();
        }

        //Authenticate user, if user actively logs in or if controller requires it
        if ( (isset($_POST['email']) && isset($_POST['password']) ) || $controller->requires_auth && !$controller->auth->logged_in) {
            if (!$controller->auth->require_auth()) {
                $controller->errors=$controller->auth->errors;
                $controller->controller='login';
                $controller->action='index';
            }
        }

        // Run the action
        if (!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest' && method_exists($controller, $controller->action . '_ajax')) {
            $action_name = $controller->action . '_ajax';
            $controller->$action_name();
            exit();
        } else {
            // Check for and process POST ( executes $action_post() )
            if (isset($_POST) && !empty($_POST) && method_exists($controller, $controller->action . '_post')) {
                $action_name = $controller->action . '_post';
                if (!$controller->skip_main_action) {
                    $controller->$action_name();
                }
            }

            // Proceed with regular action processing ( executes $action() )
            if (!method_exists($controller, $controller->action))
                error_out("<b>Error:</b>
				The action <i>{$controller->controller}::{$controller->action}()</i> does not exist.
				Open <i>controllers/{$controller->controller}.php</i> and add method <i>{$controller->action}()</i>");
            $controller->{$controller->action}();
            $controller->render($controller->template);
        }

    }

    private function load_common_functions()
    {
        require 'system/functions.php';

    }

    private function set_base_url()
    {
        $s = & $_SERVER;
        $ssl = (!empty($s['HTTPS']) && $s['HTTPS'] == 'on') ? true : false;
        $sp = strtolower($s['SERVER_PROTOCOL']);
        $protocol = substr($sp, 0, strpos($sp, '/')) . (($ssl) ? 's' : '');
        $port = $s['SERVER_PORT'];
        $port = ((!$ssl && $port == '80') || ($ssl && $port == '443')) ? '' : ':' . $port;
        $host = isset($s['HTTP_X_FORWARDED_HOST']) ? $s['HTTP_X_FORWARDED_HOST'] : isset($s['HTTP_HOST']) ? $s['HTTP_HOST'] : $s['SERVER_NAME'];
        $uri = $protocol . '://' . $host . $port . dirname($_SERVER['SCRIPT_NAME']);
        define('BASE_URL', rtrim($uri, '/') . '/');
    }

    private function load_config()
    {


        // Load config file or bail out
        if (file_exists('config.php')) {
            require 'config.php';
        } else {
            error_out('No config.php. Please make a copy of config.sample.php and name it config.php and configure it.');
        }
    }

    private function process_uri()
    {
        if (isset($_SERVER['PATH_INFO'])) {
            if ($path_info = explode('/', $_SERVER['PATH_INFO'])) {
                array_shift($path_info);
                $this->controller = isset($path_info[0]) ? array_shift($path_info) : DEFAULT_CONTROLLER;
                $this->action = isset($path_info[0]) && !empty($path_info[0]) ? array_shift($path_info) : 'index';
                $this->params = isset($path_info[0]) ? $path_info : NULL;
            }
        }
    }

    private function handle_routing()
    {
        // Support organizers/8-tallinn
        if($this->controller=='organizers' and strpos($this->action,'-')>0){
            list($this->params[0],$city_name) = explode('-',$this->action);
            $this->action = 'view';
        }
    }

    private function init_db()
    {
        require 'system/database.php';
    }

    private function initialize_translation()
    {
        require 'classes/gettext.php';
        require 'classes/streams.php';
        if (isset($_GET['lang'])) {
            $lang = $_GET['lang'];

            // register the session and set the cookie
            $_SESSION['lang'] = $lang;

            setcookie('lang', $lang, time() + (3600 * 24 * 30));
        } elseif (isset($_SESSION['lang'])) {
            $lang = $_SESSION['lang'];
        } elseif (isset($_COOKIE['lang'])) {
            $lang = $_COOKIE['lang'];
        } else { $lang = 'et_EE';
            $_SESSION['lang'] = $lang;
        }

        $streamer = new FileReader('locale/' . $lang . '/LC_MESSAGES/piletimaailm.mo');
        $GLOBALS['w'] = new gettext_reader($streamer, false);

    }

}
