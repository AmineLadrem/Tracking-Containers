<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class zone extends Model
{
    use HasFactory;

    protected $fillable=[
        'Zone_ID',
        'Zone_Nom',
        'Zone_Type'
     
    ];
}
