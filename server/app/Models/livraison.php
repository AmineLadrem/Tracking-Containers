<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class livraison extends Model
{
    use HasFactory;
    protected $fillable=[
        'NumLivraison',
        'DateLivraison',
        'HeureLivraison',
     
    ];
}
