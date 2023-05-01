<?php

namespace App\Http\Controllers;

use App\Models\utilisateur;
use Illuminate\Http\Request;

class UtilisateurController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $utilisateur=utilisateur::all();
        return response($utilisateur,200);
    }

    public function getUserRoleByEmail($email)
{
    $user = utilisateur::where('E-mail', $email)->first();
    if ($user) {
        return $user;
    } else {
        return 'User not found';
    }
}

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
    
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, utilisateur $utilisateur)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(utilisateur $utilisateur)
    {
        //
    }
}
