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
        Schema::create('utilisateurs', function (Blueprint $table) {
            $table->integer('ID')->autoIncrement();
            $table->string('Nom', 20);
            $table->string('Prenom', 20);
            $table->string('Role', 30);
            $table->string('Adresse', 50);
            $table->integer('tel');
            $table->string('MotPass', 16);
            $table->string('Shift', 30);

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('utilisateurs');
    }
};
