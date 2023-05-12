<?php

namespace App\Http\Controllers;
use App\Models\conteneur;
use App\Models\modulesuivi;
use Illuminate\Http\Request;

class ConteneurController extends Controller
{
    public function index()
    {
        $conteneur=Conteneur::all();
        return response($conteneur,200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $conteneurValidation=$request->validate([
            'Cont_ID'=>['required'],
            'Cont_Type'=>['required'],
            'Cont_Poids'=>['required'],
            'Cont_Status'=>['required'],
            'ModNum'=>['required'],
            'NumLivraison'=>['required'],
            'NumEmbarquement'=>['required'],
            'NumDebarquement'=>['required'],
            'NumVisite'=>['required'],
            'NumParc'=>['required'],
            'Admin_ID'=>['required'],
            
        ]);
        $conteneur=Conteneur::create([
            
            'Cont_ID'=>$conteneurValidation['Cont_ID'],
            'Cont_Type'=>$conteneurValidation['Cont_Type'],
            'Cont_Poids'=>$conteneurValidation['Cont_Poids'],
            'Cont_Status'=>$conteneurValidation['Cont_Status'],
            'ModNum'=>$conteneurValidation['ModNum'],
            'NumLivraison'=>$conteneurValidation['NumLivraison'],
            'NumEmbarquement'=>$conteneurValidation['NumEmbarquement'],
            'NumDebarquement'=>$conteneurValidation['NumDebarquement'],
            'NumVisite'=>$conteneurValidation['NumVisite'],
            'NumParc'=>$conteneurValidation['NumParc'],
            'Admin_ID'=>$conteneurValidation['Admin_ID'],

            ]);
    }

    /**
     * Display the specified resource.
     */
    public function show(conteneur $conteneur)
    {
        //
    }

    public function function1($id)
    {
        $conteneur = Conteneur::where('ModNum',$id)->first();
        return $conteneur;
    }

    public function function2($numParc)
    {
        $conteneurs = Conteneur::where('NumParc', $numParc)->get();

        return response()->json($conteneurs);
    }


    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, conteneur $conteneur)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(conteneur $conteneur)
    {
        //
    }
}
