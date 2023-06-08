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
        Schema::create('modulesuivis', function (Blueprint $table) {
            $table->integer('ModNum')->primary();
            $table->string('ModStatus')->nullable(false);
            $table->double('ModBatterie')->nullable(false);
            $table->double('PositionX')->nullable(false);
            $table->double('PositionY')->nullable(false);
            $table->double('PositionH')->nullable(false);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('modulesuivis');
    }
};
