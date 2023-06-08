<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class visite extends Model
{
    use HasFactory;

    protected $fillable=[
        'NumVisite',
        'DateVisite',
        'HeureVisite'
     
    ];
} 
