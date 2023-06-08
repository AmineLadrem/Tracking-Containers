<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class demande extends Model
{
    use HasFactory;
    protected $fillable=[
        'CDP_ID',
        'CDC_ID',
        'DateDemande',
        'HeureDemande',
        'Cont_ID',
        'ParcDest',
        'Status'
     
    ];
}
