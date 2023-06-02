<?php

namespace App\Http\Controllers;

use App\Models\modulesuivi;
use Illuminate\Http\Request;

class ModulesuiviController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $modulesuivis=Modulesuivi::all();
        return response($modulesuivis,200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $moduleValidation=$request->validate([
            'ModNum'=>['required','numeric'],
            'ModBatterie'=>['required','numeric'],
            
        ]);
        $module=ModuleSuivi::create([
            'ModNum'=>$moduleValidation['ModNum'],
            'ModStatus'=> 'Inactive', 
            'ModBatterie'=> $moduleValidation['ModBatterie'], 
            'PositionX'=> 0, 
            'PositionY'=> 0, 
            
            ]);
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        $module = modulesuivi::findOrFail($id);
        return $module;
    }
    

    /**
     * Update the specified resource in storage.
     */
    public function update($id,$x,$y)
    {
        $affectedRows =modulesuivi::where('ModNum',$id)->update(['PositionX' =>$x,'PositionY' =>$y]);
        if ($affectedRows > 0) {
            return response()->json([
                'success' => true,
                'message' => 'Location updated successfully'
            ]);
        } else {
            return response()->json([
                'success' => false,
                'message' => 'Location not updated'
            ]);
        }
    }

    public function updateStatus($id)
    {
   
        $affectedRows =modulesuivi::where('ModNum',$id)->first();
    
        if ($affectedRows['ModStatus'] == 'Inactive' && $affectedRows['ModNum'] !=0) {
            $affectedRows =modulesuivi::where('ModNum',$id)->update(['ModStatus' =>'Active']);
        } else if ($affectedRows['ModStatus'] == 'Active' && $affectedRows['ModNum'] !=0) {
            $affectedRows =modulesuivi::where('ModNum',$id)->update(['ModStatus' =>'Inactive','PositionX' =>0,'PositionY' =>0]);
        }
       
           
    }
  

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(modulesuivi $modulesuivi)
    {
        //
    }
}
