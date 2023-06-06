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


    
    public function function3(string $cont_id,$mod_num)
    {
        $container=Conteneur::where('Cont_ID',$cont_id)->first();
        $status=$container->Cont_Status;
        if($status=='livré'){
            $affectedRows =Conteneur::where('Cont_ID',$cont_id)->update(['ModNum' =>0,'Cont_Status'=>'En cours de visite']);
        }
        $affectedRows =Conteneur::where('Cont_ID',$cont_id)->update(['ModNum' =>$mod_num]);
        modulesuivi::where('ModNum',$mod_num)->update(['ModStatus' =>'Active']);
        if ($affectedRows > 0) {
            return response()->json([
                'success' => true,
                'message' => 'ModNum updated successfully'
            ]);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Failed to update ModNum'
            ]);
        }
    }

    public function function4(string $cont_id)
    {
        $container=Conteneur::where('Cont_ID',$cont_id)->first();
        $modnum=$container->ModNum;
        $status=$container->Cont_Status;
        if($status=='En cours de livraison'){
            $affectedRows =Conteneur::where('Cont_ID',$cont_id)->update(['ModNum' =>0,'Cont_Status'=>'livré']);
        }
        elseif($status=='En cours d\'embarquement'){
            $affectedRows =Conteneur::where('Cont_ID',$cont_id)->update(['ModNum' =>0,'Cont_Status'=>'embarqué']);
        }   
        else {
            $affectedRows =Conteneur::where('Cont_ID',$cont_id)->update(['ModNum' =>0]);
        }
        
        modulesuivi::where('ModNum',$modnum)->update(['ModStatus' =>'Inactive']);
        if ($affectedRows > 0) {
            return response()->json([
                'success' => true,
          
                'message' => 'ModNum updated successfully'
            ]);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Failed to update ModNum'
            ]);
        }
    }

    public function function5($cont_id)
    {
        $conteneurs = Conteneur::where('Cont_ID', $cont_id)->first();

        return response()->json($conteneurs);
    }


    /**
     * Update the specified resource in storage.
     */
    public function update($cont_id,$parc)
    {
        print($cont_id);
        print($parc);
    if($parc==1 &&$parc==2 ){
       Conteneur::where('Cont_ID', $cont_id)->update(['Cont_Status'=>'débarqué','NumParc'=>$parc]);
    }
    elseif($parc>=3 && $parc<=8){
         Conteneur::where('Cont_ID', $cont_id)->update(['Cont_Status'=>'En cours d\'embarquement','NumParc'=>$parc]);
    }
    elseif($parc>=9 && $parc<=13){
         Conteneur::where('Cont_ID', $cont_id)->update(['Cont_Status'=>'En cours de livraison','NumParc'=>$parc]);
    }
    elseif($parc>=14 && $parc<=18){
        Conteneur::where('Cont_ID', $cont_id)->update(['Cont_Status'=>'stocké','NumParc'=>$parc]);
    }
    elseif($parc>=19 && $parc<=24){
         Conteneur::where('Cont_ID', $cont_id)->update(['Cont_Status'=>'En cours de visite','NumParc'=>$parc]);
    }

    

}

public function function6()
{
    $conteneurs = Conteneur::where('Cont_Status', 'À bord')
                          ->where('ModNum', 0)
                          ->get(['Cont_ID']);

    $count = $conteneurs->count();
    $conteneurIDs = $conteneurs->pluck('Cont_ID');

    return response()->json([
        'count' => $count,
        'conteneurIDs' => $conteneurIDs,
    ], 200);
}
 


 


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(conteneur $conteneur)
    {
        //
    }
}
