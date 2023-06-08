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
        return response()->json(['message' => 'User not found'], 404);
    }
}
public function UpdatePW(string $email, string $pw)
{
    $user = utilisateur::where('E-mail', $email)->update(['MotPass' => $pw]);
    if ($user > 0) {
        return response()->json([
            'success' => true,
            'message' => 'updated'
        ]);
    } else {
        return response()->json([
            'success' => false,
            'message' => 'failed'
        ]);
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
