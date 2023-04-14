<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class parc extends Model
{
    use HasFactory;
    protected $fillable=[
        'NumParc',
        'NomParc',
        'Zone_ID'
     
    ];
}
