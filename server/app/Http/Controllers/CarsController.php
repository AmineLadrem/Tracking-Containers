<?php

namespace App\Http\Controllers;

use App\Models\Cars;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CarsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $cars=Cars::all();
        if(count($cars)<=0){
            return Response(['message'=>'No cars found'],200);
        }
     return response($cars,200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
       $carsValidation=$request->validate([
           'model'=>['required','string'],
           'prix'=>['required','numeric'],
           'description'=>['required','string','max:255'],
           'user_id'=>['required','numeric']
       ]);

       $cars=Cars::create([
       'model'=>$carsValidation['model'],
       'prix'=> $carsValidation['prix'], 
       'description'=> $carsValidation['description'], 
       'user_id'=> $carsValidation['user_id'], 
       ]);

       return response(['message'=>'cars created successfully'],201);
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
       $car=DB::table('cars')->JOIN('users','cars.user_id','=','users.id')->select('cars.*','users.name')->where('cars.id','=',$id)->get();
       return $car->FIRST();
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        $carsValidation=$request->validate([
            'model'=>['string'],
            'prix'=>['numeric'],
            'description'=>['string','max:255'],
            'user_id'=>['numeric']
        ]);
  $car=Cars::find($id);
  if(!$car){
    return Response(['message'=>'No cars found with id= $id'],404);
}
$car->update($carsValidation);
 

    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
       
        $car=Cars::find($id);
       
       $car->delete();
    }
}
