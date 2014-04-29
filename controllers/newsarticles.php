<?php

class newsarticles extends Controller
{

    function index()
    {
        $this->events = get_all("SELECT * FROM small_piletimaailm.events WHERE type='Event' and state='on_sale'");
    }

}