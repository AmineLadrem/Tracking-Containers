<?php

namespace App\Http\Controllers;
use App\Models\Conteneur;
use App\Models\modulesuivi;
use Illuminate\Http\Request;

class ConteneurController extends Controller
{
    public function index()
    {
        $Conteneur=Conteneur::all();
        return response($Conteneur,200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $ConteneurValidation=$request->validate([
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
        $Conteneur=Conteneur::create([
            
            'Cont_ID'=>$ConteneurValidation['Cont_ID'],
            'Cont_Type'=>$ConteneurValidation['Cont_Type'],
            'Cont_Poids'=>$ConteneurValidation['Cont_Poids'],
            'Cont_Status'=>$ConteneurValidation['Cont_Status'],
            'ModNum'=>$ConteneurValidation['ModNum'],
            'NumLivraison'=>$ConteneurValidation['NumLivraison'],
            'NumEmbarquement'=>$ConteneurValidation['NumEmbarquement'],
            'NumDebarquement'=>$ConteneurValidation['NumDebarquement'],
            'NumVisite'=>$ConteneurValidation['NumVisite'],
            'NumParc'=>$ConteneurValidation['NumParc'],
            'Admin_ID'=>$ConteneurValidation['Admin_ID'],

            ]);
    }

    /**
     * Display the specified resource.
     */
    public function show(Conteneur $Conteneur)
    {
        //
    }

    public function function1($id)
    {
        $Conteneur = Conteneur::where('ModNum',$id)->first();
        return $Conteneur;
    }

    public function function2($numParc)
    {
        $Conteneurs = Conteneur::where('NumParc', $numParc)->get();

        return response()->json($Conteneurs);
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
            $affectedRows =Conteneur::where('Cont_ID',$cont_id)->update(['ModNum' =>0,'Cont_Status'=>'livré','NumParc'=>0]);
        }
        elseif($status=='En cours d\'embarquement'){
            $affectedRows =Conteneur::where('Cont_ID',$cont_id)->update(['ModNum' =>0,'Cont_Status'=>'embarqué','NumParc'=>0]);
        }   
        else {
            $affectedRows =Conteneur::where('Cont_ID',$cont_id)->update(['ModNum' =>0]);
        }  
        modulesuivi::where('ModNum',$modnum)->update(['ModStatus' =>'Inactive','PositionX'=>0,'PositionY'=>0]);
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
        $Conteneurs = Conteneur::where('Cont_ID', $cont_id)->first();

        return response()->json($Conteneurs);
    }


    /**
     * Update the specified resource in storage.
     */
    public function update($cont_id,$parc)
    {
      
    if($parc==1  || $parc==2 ){
         
      
       Conteneur::where('Cont_ID', $cont_id)->update(['Cont_Status'=>'débarqué','NumParc'=>$parc]);
    }
    elseif($parc>=3 || $parc<=8){
         Conteneur::where('Cont_ID', $cont_id)->update(['Cont_Status'=>'En cours d\'embarquement','NumParc'=>$parc]);
    }
    elseif($parc>=9 || $parc<=13){
         Conteneur::where('Cont_ID', $cont_id)->update(['Cont_Status'=>'En cours de livraison','NumParc'=>$parc]);
    }
    elseif($parc>=14 || $parc<=18){
        Conteneur::where('Cont_ID', $cont_id)->update(['Cont_Status'=>'stocké','NumParc'=>$parc]);
    }
    elseif($parc>=19 || $parc<=24){
         Conteneur::where('Cont_ID', $cont_id)->update(['Cont_Status'=>'En cours de visite','NumParc'=>$parc]);
    }

    

}

public function function6()
{
    $Conteneurs = Conteneur::where('Cont_Status', 'À bord')
                          ->where('ModNum', 0)
                          ->get(['Cont_ID']);

    $count = $Conteneurs->count();
    $ConteneurIDs = $Conteneurs->pluck('Cont_ID');

    return response()->json([
        'count' => $count,
        'ConteneurIDs' => $ConteneurIDs,
    ], 200);
}
 


 


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Conteneur $Conteneur)
    {
        //
    }
}
