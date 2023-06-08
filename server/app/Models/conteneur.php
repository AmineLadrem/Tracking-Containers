<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class conteneur extends Model
{
    use HasFactory;
    protected $fillable=[
        'Cont_ID',
        'Cont_Type',
        'Cont_Poids',
        'Cont_Status',
        'ModNum',
        'NumLivraison',
        'NumEmbarquement',
        'NumDebarquement',
        'NumVisite',
        'NumParc',
        'Admin_ID',

     
    ];
}
