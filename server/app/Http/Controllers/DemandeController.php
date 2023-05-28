<?php

namespace App\Http\Controllers;

use App\Models\demande;
use App\Models\conteneur;
use App\Models\conducteur;
use App\Models\modulesuivi;
use Illuminate\Http\Request;

class DemandeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $demande=Demande::all();
        return response($demande,200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $demandeValidation=$request->validate([
            'CDP_ID'=>['required'],
            'CDC_ID'=>['required'],
            'DateDemande'=>['required'],
            'HeureDemande'=>['required'],
            'Cont_ID'=>['required'],
            'ParcDest'=>['required'],
            'Status'=>['required'],
         
            
        ]);
        $demande=Demande::create([
            
            'CDP_ID'=>$demandeValidation['CDP_ID'],
            'CDC_ID'=>$demandeValidation['CDC_ID'],
            'DateDemande'=>$demandeValidation['DateDemande'],
            'HeureDemande'=>$demandeValidation['HeureDemande'],
            'Cont_ID'=>$demandeValidation['Cont_ID'],
            'ParcDest'=>$demandeValidation['ParcDest'],
            'Status'=>$demandeValidation['Status'],
             
            ]);
    }

    /**
     * Display the specified resource.
     */
    public function show(demande $demande)
    {
        //
    }

    public function function1($cdpId)
    {
        $demandes = Demande::where('CDP_ID', $cdpId)->get();
    
        return response()->json($demandes);
    }

    public function function2($cdcId)
    {
        $demandes = Demande::where('CDC_ID', $cdcId)->get();
        foreach ($demandes as $demande) {
            $conteneur = Conteneur::where('Cont_ID', $demande['Cont_ID'])->first();
    
            $demande['ModNum'] = $conteneur['ModNum'];
            $demande['ParcDepart'] = $conteneur['NumParc'];
        }
    
        return response()->json($demandes);
    }
    
    public function function3()
    {
        $demandes = Demande::where('CDC_ID', 0)->where('Status', 'En Attente')->get();
        if ($demandes->isEmpty()) {
            return null;
        }
        foreach ($demandes as $demande) {
            $conteneur = Conteneur::where('Cont_ID', $demande['Cont_ID'])->first();
    
            $demande['ModNum'] = $conteneur['ModNum'];
            $demande['ParcDepart'] = $conteneur['NumParc'];
        }
    
        return response()->json($demandes);
    }

    public function function4($demande, $conducteur)
    {
        $demandes = Demande::where('DemNum', $demande)->update(['CDC_ID' => $conducteur,'Status' => 'Acceptée']) ;
        Conducteur::where('CDC_ID', $conducteur)->increment('NbrDemandesAcc');
        return response()->json($demandes);
    }
    
    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, demande $demande)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(demande $demande)
    {
        //
    }
}
