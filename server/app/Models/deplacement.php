<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class deplacement extends Model
{
    use HasFactory;
    protected $fillable = [
        'CDC_ID',
        'Cont_ID',
        'DateDep',
        'HeureDep',
     ];
}
