<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class conducteur extends Model
{
    use HasFactory;

    protected $fillable = [
       'CDC_ID',
       'NbrDemandesAcc'
    ];
}
