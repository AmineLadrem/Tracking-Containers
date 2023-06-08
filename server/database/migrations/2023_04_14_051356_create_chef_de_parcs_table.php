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
        Schema::create('chef_de_parcs', function (Blueprint $table) {
            
            $table->integer('CDP_ID')->primary();
            $table->integer('NumParc');
            $table->foreign('CDP_ID')->references('ID')->on('utilisateurs');
            $table->foreign('NumParc')->references('NumParc')->on('parcs');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('chef_de_parcs');
    }
};
