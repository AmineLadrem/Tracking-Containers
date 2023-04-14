<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class chef_de_parc extends Model
{
    use HasFactory;
    protected $fillable = [
        'CDP_ID',
        'NumParc'
    ];
}
