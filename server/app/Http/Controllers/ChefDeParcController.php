<?php

namespace App\Http\Controllers;

use App\Models\chef_de_parc;
use Illuminate\Http\Request;

class ChefDeParcController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $chefDeParc=chef_de_parc::all();
        return response($chefDeParc,200);
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
        $chefDeParc = chef_de_parc::where('CDP_ID', $id)->first();
    
        if (!$chefDeParc) {
            return response()->json(['message' => 'Chef de parc not found.'], 404);
        }
    
        return response()->json($chefDeParc, 200);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, chef_de_parc $chef_de_parc)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(chef_de_parc $chef_de_parc)
    {
        //
    }
}
