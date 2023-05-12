<?php

use App\Http\Controllers\CarsController;
use App\Http\Controllers\ConteneurController;
use App\Http\Controllers\DebarquementController;
use App\Http\Controllers\DeplacementController;
use App\Http\Controllers\EmbarquementController;
use App\Http\Controllers\LivraisonController;
use App\Http\Controllers\ModulesuiviController;
use App\Http\Controllers\ParcController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\ZoneController;
use App\Http\Controllers\VisiteController;
use App\Http\Controllers\ChefDeParcController;
use App\Http\Controllers\ConducteurController;
use App\Http\Controllers\PointeurController;
use App\Http\Controllers\UtilisateurController;
use App\Http\Controllers\AdminController;

use App\Models\Cars;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Psy\Context;

Route::get('/',function(){
    return ['Hello' => 'World']; //json format , hello= key, world = value
});

Route::post('/user/register', [UserController::class, 'register']);
Route::post('/user/login', [UserController::class, 'login']);

Route::get('/cars',[CarsController::class, 'index']);
Route::post('/cars',[CarsController::class, 'store']);
Route::get('/cars/{id}',[CarsController::class, 'show']);
Route::put('/cars/{id}',[CarsController::class, 'update']);
Route::delete('/cars/{id}',[CarsController::class, 'destroy']);

Route::get('/utilisateur',[UtilisateurController::class, 'index']);
Route::get('/utilisateur/{email}', [UtilisateurController::class, 'getUserRoleByEmail']);
Route::get('/modulesuivis',[ModulesuiviController::class, 'index']);
Route::post('/modulesuivis',[ModulesuiviController::class, 'store']);
Route::get('/modulesuivis/{id}',[ModulesuiviController::class, 'show']);

Route::get('/cdp',[ChefDeParcController::class, 'index']);
Route::get('/cdp/{id}',[ChefDeParcController::class, 'show']);

Route::get('/admin/{id}',[AdminController::class, 'show']);

Route::get('/conteneur',[ConteneurController::class, 'index']);
Route::get('/conteneur/modulesuivi/{id}',[ConteneurController::class, 'function1']);
Route::get('/conteneur/numparc/{id}',[ConteneurController::class, 'function2']);
Route::post('/conteneur',[ConteneurController::class, 'store']);


Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
