<?php

class newsarticles extends Controller
{

    function index()
    {
        $this->events = get_all("SELECT * FROM events WHERE type='event' and state='on_sale'");
    }

}