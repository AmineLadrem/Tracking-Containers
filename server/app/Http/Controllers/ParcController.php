<?php

namespace App\Http\Controllers;

use App\Models\parc;
use Illuminate\Http\Request;

class ParcController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $parc=Parc::all();
        return response($parc,200);
    }
    public function parcdispo($id)
    {
        $parc = Parc::where('nbrdispo', '>', 0)->where('Zone_ID', 1)->first();

        if ($parc) {
            return response()->json($parc);
        } else {
            return response()->json(['message' => 'Aucun parc est disponible'], 404);
        }
    }

    public function parcdec($id)
    { 
        
        if ($id!=0) {
            $parc = Parc::where('NumParc', $id)->decrement('NbrDispo');
        }
    }
    public function parcinc($id)
    {
        Parc::where('NumParc',$id)->increment('NbrDispo');
    }
   
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(parc $parc)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, parc $parc)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(parc $parc)
    {
        //
    }
}
