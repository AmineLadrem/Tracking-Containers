<?php

namespace App\Http\Controllers;

use App\Models\demande;

use App\Models\parc;
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

            if ($demande) {
                return response()->json(['status' => 'success'], 200);
            } else {
                return response()->json(['status' => 'error'], 500);
            }


    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        $demande = Demande::where('Cont_ID', $id)
        ->where(function ($query) {
            $query->where('Status', 'En Attente')
                ->orWhere('Status', 'En Cours')
                ->orWhere('Status', 'Acceptée');
        })
        ->first();
       if($demande){
        return response()->json(200);
       }
         else{
            return response()->json(500);
         }
    }

    public function function1($cdpId)
    {
        $demandes = Demande::where('CDP_ID', $cdpId)->get();
    
        return response()->json($demandes);
    }

    public function function2($cdcId)
    {
        $demandes = Demande::where('CDC_ID', $cdcId)
        ->orderByRaw("FIELD(Status, 'Acceptée', 'En cours', 'Terminée')")
        ->get();

    foreach ($demandes as $demande) {
        $conteneur = Conteneur::where('Cont_ID', $demande['Cont_ID'])->first();
        $demande['ModNum'] = $conteneur['ModNum'];
        $demande['ParcDepart'] = $conteneur['NumParc'];
    }

    

    return response()->json($demandes);

    }

    public function function10($cdcId)
    {
        $demandes = Demande::where('CDC_ID', $cdcId)->get();
    
        $accepteCount = 0;
        $enCoursCount = 0;
        $termineeCount = 0;
    
        foreach ($demandes as $demande) {
            switch ($demande->Status) {
                case 'Acceptée':
                    $accepteCount++;
                    break;
                case 'En Cours':
                    $enCoursCount++;
                    break;
                case 'Terminée':
                    $termineeCount++;
                    break;
            }
        }
    
        $counts = [
            'accepteCount' => $accepteCount,
            'enCoursCount' => $enCoursCount,
            'termineeCount' => $termineeCount,
        ];
    
        return response()->json($counts);
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
    
    
    public function function5($demande)
    {
        $demandes = Demande::where('DemNum', $demande)->update(['Status' => 'En Cours']) ;
 
        return response()->json($demandes);
    }

    public function function6($demande)
    {
        $demandes = Demande::where('DemNum', $demande)->update(['Status' => 'Terminée']) ;
       
        return response()->json($demandes);
    }
    public function function7($demande)
    {
        $demandes = Demande::where('DemNum', $demande)->update(['Status' => 'En Attente', 'CDC_ID' => 0]) ;
 
        return response()->json($demandes);
    }

    public function function8($cdp,$cdc,$date,$heure,$cont )
    {
        $parc = Parc::where('nbrdispo', '>', 0)->where('Zone_ID', 1)->first();
        Demande::create([
            
            'CDP_ID'=>$cdp,
            'CDC_ID'=>$cdc,
            'DateDemande'=>$date,
            'HeureDemande'=>$heure,
            'Cont_ID'=>$cont,
            'ParcDest'=>$parc['NumParc'],
            'Status'=>'En Attente',
             
            ]);
            Parc::where('NumParc', $parc['NumParc'])->decrement('NbrDispo');
    }

    public function function9($id)
    {
        $demande = Demande::where('DemNum', $id)->first();
       if($demande){
        return response()->json( $demande);
       }
         else{
            return response()->json(500);
         }
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
    public function destroy( $demande)
    {
        $demandes = Demande::where('DemNum', $demande)->delete( ) ;
    }
}
