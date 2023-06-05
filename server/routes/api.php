<?php

use App\Http\Controllers\CarsController;
use App\Http\Controllers\ConteneurController;
use App\Http\Controllers\DemandeController;
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

 

Route::get('/utilisateur',[UtilisateurController::class, 'index']);
Route::get('/utilisateur/{email}', [UtilisateurController::class, 'getUserRoleByEmail']);
Route::put('/utilisateur/{email}/{pw}', [UtilisateurController::class, 'UpdatePW']);

Route::get('/modulesuivis',[ModulesuiviController::class, 'index']);
Route::post('/modulesuivis',[ModulesuiviController::class, 'store']);
Route::put('/modulesuivis/{id}/{x}/{y}',[ModulesuiviController::class, 'update']);
Route::put('/modulesuivis/status/{id}',[ModulesuiviController::class, 'updateStatus']);
Route::get('/modulesuivis/{id}',[ModulesuiviController::class, 'show']);

Route::get('/cdp',[ChefDeParcController::class, 'index']);
Route::get('/cdp/{id}',[ChefDeParcController::class, 'show']);

Route::get('/parcs',[ParcController::class, 'index']);
Route::get('/parc',[ParcController::class, 'parcdispo']);

Route::get('/admin/{id}',[AdminController::class, 'show']);

Route::get('/conteneur',[ConteneurController::class, 'index']);
Route::get('/conteneur/modulesuivi/{id}',[ConteneurController::class, 'function1']);
Route::get('/conteneur/numparc/{id}',[ConteneurController::class, 'function2']);
Route::put('conteneurs/attache/{conteneur}/{modNum}', [ConteneurController::class, 'function3']);
Route::put('conteneurs/detache/{conteneur}', [ConteneurController::class, 'function4']);
Route::get('conteneurs/{cont_id}', [ConteneurController::class, 'function5']);
Route::get('/conteneur/nbr',[ConteneurController::class, 'function6']);
Route::post('/conteneur',[ConteneurController::class, 'store']);
Route::put('/conteneur/{cont_id}/{parc}',[ConteneurController::class, 'update']);
Route::put('/conteneur/pointeur/{cont_id}/{status}',[ConteneurController::class, 'update2']);

Route::post('/demande',[DemandeController::class, 'store']);
Route::delete('/demande/annuler/{demande}',[DemandeController::class, 'destroy']);
Route::get('/demandes',[DemandeController::class, 'index']);
Route::get('/demande/{id}',[DemandeController::class, 'show']);
Route::get('/demandes/0',[DemandeController::class, 'function3']);
Route::get('/demandes/chef/{cdp}',[DemandeController::class, 'function1']);
Route::get('/demandes/conducteur/{cdc}',[DemandeController::class, 'function2']);
Route::get('/demandes/conducteur/nbr/{cdc}',[DemandeController::class, 'function10']);
Route::put('/demandes/conducteur/accepte/{demande}/{cdc}',[DemandeController::class, 'function4']);
Route::put('/demandes/conducteur/cours/{demande}',[DemandeController::class, 'function5']);
Route::put('/demandes/conducteur/termine/{demande}',[DemandeController::class, 'function6']);
Route::put('/demandes/conducteur/cancel/{demande}',[DemandeController::class, 'function7']);
Route::put('/demandes/conducteur/add/{cdp}/{cdc}/{date}/{heure}/{cont}',[DemandeController::class, 'function8']);
Route::get('/demande/conteneur/{id}',[DemandeController::class, 'function11']);
Route::get('/Demande/{id}',[DemandeController::class, 'function9']);

Route::get('/debarquement/{id}',[DebarquementController::class, 'show']);
Route::get('/embarquement/{id}',[EmbarquementController::class, 'show']);
Route::get('/livraison/{id}',[LivraisonController::class, 'show']);
Route::get('/visite/{id}',[VisiteController::class, 'show']);

Route::get('/debarquement',[DebarquementController::class, 'index']);

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
