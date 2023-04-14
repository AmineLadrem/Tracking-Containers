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

Route::post('/zones',[ZoneController::class, 'store']);
Route::get('/zones',[ZoneController::class, 'index']);

Route::post('/parcs',[ParcController::class, 'store']);
Route::get('/parcs',[ParcController::class, 'index']);


Route::post('/visites',[VisitesController::class, 'store']);
Route::get('/visites',[VisitesController::class, 'index']);

Route::post('/embarquements',[EmbarquementController::class, 'store']);
Route::get('/embarquements',[EmbarquementController::class, 'index']);

Route::post('/debarquements',[DebarquementController::class, 'store']);
Route::get('/debarquements',[DebarquementController::class, 'index']);

Route::post('/livraisons',[LivraisonController::class, 'store']);
Route::get('/livraisons',[LivraisonController::class, 'index']);

Route::post('/modulesuivis',[ModulesuiviController::class, 'store']);
Route::get('/modulesuivis',[ModulesuiviController::class, 'index']);
Route::post('/modulesuivis/{id}',[ModulesuiviController::class, 'update']);

Route::post('/conteneurs',[ConteneurController::class, 'store']);
Route::get('/conteneurs',[ConteneurController::class, 'index']);
Route::post('/conteneurs/{id}',[ConteneurController::class, 'update']);

Route::post('/deplacements',[DeplacementController::class, 'store']);
Route::get('/deplacements',[DeplacementController::class, 'index']);




Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
