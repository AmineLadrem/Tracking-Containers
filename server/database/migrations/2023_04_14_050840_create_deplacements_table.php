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
        Schema::create('deplacements', function (Blueprint $table) {
            $table->integer('CDC_ID');
            $table->string('Cont_ID');
            $table->primary(['CDC_ID', 'Cont_ID']);
            $table->date('DateDep');
            $table->time('HeureDep');
            $table->foreign('CDC_ID')->references('CDC_ID')->on('conducteurs');
            $table->foreign('Cont_ID')->references('Cont_ID')->on('conteneurs');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('deplacements');
    }
};
