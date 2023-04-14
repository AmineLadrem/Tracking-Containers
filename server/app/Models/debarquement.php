<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class debarquement extends Model
{
    use HasFactory;
    protected $fillable=[
        'NumDebarquement',
        'DateDebarquement',
        'HeureDebarquement'
     
    ];
}
