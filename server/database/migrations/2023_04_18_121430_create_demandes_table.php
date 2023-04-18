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
        Schema::create('demandes', function (Blueprint $table) {
            $table->integer('CDP_ID');
            $table->integer('CDC_ID');
            $table->primary(['CDC_ID', 'CDP_ID']);
            $table->date('DateDemande');
            $table->time('HeureDemande');
            $table->foreign('CDC_ID')->references('CDC_ID')->on('conducteurs');
            $table->foreign('CDP_ID')->references('CDP_ID')->on('chef_de_parcs');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('demandes');
    }
};
