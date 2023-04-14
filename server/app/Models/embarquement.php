<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class embarquement extends Model
{
    use HasFactory;
    protected $fillable=[
        'NumEmbarquement',
        'DateEmbarquement',
        'HeureEmbarquement'
     
    ];
}
