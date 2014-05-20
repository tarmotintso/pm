<?php

class registrations extends Controller
{

    function form_post()
    {
//        session_start();
//
//        $_SESSION += $_POST;
        // Take inserted data from form
        $client = $_POST['client'];
        $validateEmail = filter_var($client['email'],FILTER_VALIDATE_EMAIL);
        $validatePhone = filter_var($client['phone'],FILTER_VALIDATE_INT);

        // Validate form data
        $errors[0] = !empty($client['email'])                                           ? NULL : 'E-mail ei tohi olla tühi';  //if $_POST $client[] is empty
        if (!empty($client['email'])) {
        $errors[1] = $validateEmail && preg_match('/@.+\./', $client['email'])          ? NULL : 'E-mail on vigane e-maili aadress';
        }
        $errors[2] = empty(get_one("SELECT email
                                   FROM clients
                                   WHERE email='{$client['email']}'
                                     AND type = 'PrivateClient'
                                   LIMIT 1"))                                           ? NULL : 'Sellise e-mailiga kasutaja on juba olemas';
        if (!empty($client['phone'])) {
            $errors[3] = $validatePhone && preg_match('/^\+?\d+$/', $client['phone'])   ? NULL : 'Telefoninumber on valel kujul';
        }
        $errors[4] = $client['password'] == $client['password_confirmation']            ? NULL : 'Parool ja parooli kinnitus on erinevad.'; //check if password and password_confirmation matc
        $errors[5] = !empty($client['first_name'])                                      ? NULL : 'Eesnimi ei tohi olla tühi';
        $errors[6] = !empty($client['last_name'])                                       ? NULL : 'Perenimi ei tohi olla tühi';
        $errors[7] = !empty($client['password'])                                        ? NULL : 'Parooli määramine on kohustuslik';

        $errors[8] = strlen($client['email']) <=100                                     ? NULL : 'Email on liiga pikk (lubatud kuni 100 tähemärki)';
        $errors[9] = strlen($client['phone']) <=30                                      ? NULL : 'Telefoninumber on liiga pikk (lubatud kuni 30 tähemärki)';
        $errors[10] = strlen($client['first_name']) <=50                                ? NULL : 'Eesnimi on liiga pikk (lubatud kuni 50 tähemärki)';
        $errors[11] = strlen($client['last_name'])  <=50                                ? NULL : 'Perenimi on liiga pikk (lubatud kuni 50 tähemärki)';

        $error = $this->errors = array_filter($errors,'strlen');
        $this->error_title = 'Registreerimine ebaõnnestus';

        // Prepare password and salt
        $client['salt'] = substr(md5(rand()), 0, 10);
        $client['type'] = 'PrivateClient';
        $client['password_hash'] = sha1($client['salt'].$client['password']);
        unset($client['password_confirmation']);
        unset($client['password']);

        // If no alerts then insert data into database
        if (isset($error) && empty($error))
        {
            insert('clients', $client);
            header('Location: /pm/registrations');
            exit();
        }
        unset($errors);

    }

    function form()
    {

    }

    function index()
    {

    }

}