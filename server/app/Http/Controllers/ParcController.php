<?php

namespace App\Http\Controllers;

use App\Models\parc;
use Illuminate\Http\Request;

class ParcController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $parc=Parc::all();
        return response($parc,200);
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
    public function show(parc $parc)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, parc $parc)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(parc $parc)
    {
        //
    }
}
