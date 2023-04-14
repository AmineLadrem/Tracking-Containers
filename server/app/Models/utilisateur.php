<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class utilisateur extends Model
{
    use HasFactory;

    protected $fillable=[
        'Nom',
        'Prenom',
        'Role',
        'Adresse',
        'Tel',
        'MotPasse',
        'Shift',
    ];
}
