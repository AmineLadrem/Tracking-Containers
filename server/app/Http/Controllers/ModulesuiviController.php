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
            'ModStatus'=> 'Libre', 
            'ModBatterie'=> $moduleValidation['ModBatterie'], 
            'PositionX'=> 0, 
            'PositionY'=> 0, 
            'PositionH'=>0, 
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
    public function update(Request $request, modulesuivi $modulesuivi)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(modulesuivi $modulesuivi)
    {
        //
    }
}
