<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('conteneurs', function (Blueprint $table) {
            $table->string('Cont_ID', 30)->primary();
            $table->string('Cont_Type', 5);
            $table->double('Cont_Poids');
            $table->string('Cont_Status', 15);
            $table->integer('NumLivraison');
            $table->unsignedBigInteger('NumLivraison');
            $table->unsignedBigInteger('NumEmbarquement');
            $table->unsignedBigInteger('NumDebarquement');
            $table->unsignedBigInteger('NumVisite');
            $table->integer('NumParc');
            $table->integer('Admin_ID');
            $table->foreign('NumParc')->references('NumParc')->on('parcs');
            $table->foreign('Admin_ID')->references('ID')->on('admins');
            $table->foreign('ModNum')->references('ModNum')->on('modulesuivis');
            $table->foreign('NumLivraison')->references('NumLivraison')->on('livraisons');
            $table->foreign('NumEmbarquement')->references('NumEmbarquement')->on('embarquements');
            $table->foreign('NumDebarquement')->references('NumDebarquement')->on('debarquements');
            $table->foreign('NumVisite')->references('NumVisite')->on('visites');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('conteneurs');
    }
};
