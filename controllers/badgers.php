<?php

class badgers extends Controller
{
    public $requires_auth = true;

    function edit_post()
    {
        if (!empty($_POST['contact_info_commit'])) {
            $private_client = $_POST['private_client'];
            $validatePhone = filter_var($private_client['phone'], FILTER_VALIDATE_INT);

            $errors[] = !empty($private_client['first_name'])                                               ? NULL : 'Eesnimi ei tohi olla tühi';
            $errors[] = !empty($private_client['last_name'])                                                ? NULL : 'Perenimi ei tohi olla tühi';
            if (!empty($private_client['phone'])) {
                $errors[] = $validatePhone && preg_match('/^\+?\d+$/', $private_client['phone'])            ? NULL : 'Telefoninumber on valel kujul';
            }
        }

        if (!empty($_POST['password_commit'])) {
            $private_client = $_POST['private_client'];
            $errors[] = $private_client['password'] == $private_client['password_confirmation']             ? NULL : 'Parool ja parooli kinnitus on erinevad.'; //check if password and password_confirmation matc
            $errors[] = !empty($private_client['password'])                                                 ? NULL : 'Parooli määramine on kohustuslik';

            $private_client['salt'] = substr(md5(rand()), 0, 10);
            $private_client['password_hash'] = sha1($private_client['salt'] . $private_client['password']);
            unset($private_client['password_confirmation']);
            unset($private_client['password']);
        }
        $error = $this->errors = array_filter($errors, 'strlen');
        $this->error_title = 'Andmete uuendamine ebaõnnestus';

        // If no alerts then update data in database
        if (isset($error) && empty($error)) {
            update('clients', $private_client, "id={$_SESSION['user_id']}");
            if (isset($private_client['first_name'])){
                $_SESSION['first_name']= ucfirst(strtolower($private_client['first_name']));
}
            if (isset($private_client['last_name'])){
                $_SESSION['last_name']= ucfirst(strtolower($private_client['last_name']));
}
            header('Location: /pm/badgers/details?update=success');
            exit();
        }
        unset($errors);
    }

    function details()
    {
        $this->user = get_first("SELECT * FROM clients WHERE id='{$_SESSION['user_id']}'");
    }

    function edit()
    {
        $this->user = get_first("SELECT * FROM clients WHERE id='{$_SESSION['user_id']}'");
    }

    function index()
    {

    }


}