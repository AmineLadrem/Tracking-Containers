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
        Schema::create('pointeurs', function (Blueprint $table) {
            $table->integer('Pointeur_ID');
            $table->primary('Pointeur_ID');
            $table->foreign('Pointeur_ID')->references('ID')->on('utilisateurs');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pointeurs');
    }
};
