<?php

namespace App\Http\Controllers;

use App\Models\livraison;
use Illuminate\Http\Request;

class LivraisonController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
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
        $livraison = livraison::where('NumLivraison',$id)->first();
        return $livraison;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, livraison $livraison)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(livraison $livraison)
    {
        //
    }
}
