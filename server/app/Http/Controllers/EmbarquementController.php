<?php

namespace App\Http\Controllers;

use App\Models\embarquement;
use Illuminate\Http\Request;

class EmbarquementController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
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
        $embarquement = embarquement::where('NumEmbarquement',$id)->first();
        return $embarquement;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, embarquement $embarquement)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(embarquement $embarquement)
    {
        //
    }
}
