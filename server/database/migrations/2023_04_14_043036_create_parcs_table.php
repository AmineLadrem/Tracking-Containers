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
        Schema::create('parcs', function (Blueprint $table) {
            $table->integer('NumParc')->primary();
            $table->string('NomParc', 30);
            $table->string('Zone_ID',6);
            $table->foreign('Zone_ID')->references('Zone_ID')->on('zones');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('parcs');
    }
};
