<?php

namespace App\Http\Controllers;

use App\Models\debarquement;
use Illuminate\Http\Request;
use Carbon\Carbon;

class DebarquementController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
    $today = Carbon::now()->format('Y-m-d');
    $debarquement = debarquement::where('DateDebarquement', $today)->first();
    return response()->json($debarquement);
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
        $debarquement = debarquement::where('NumDebarquement',$id)->first();
        return $debarquement;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, debarquement $debarquement)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(debarquement $debarquement)
    {
        //
    }
}
