<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class modulesuivi extends Model
{
    use HasFactory;

    protected $fillable=[
        'ModNum',
        'ModStatus',
        'ModBatterie',
        'PositionX',
        'PositionY',
        'PositionH',
    ];
}
