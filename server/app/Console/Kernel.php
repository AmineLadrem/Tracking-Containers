<?php

namespace App\Console;

use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Http;
use App\Models\debarquement;
use App\Models\conteneur;
class Kernel extends ConsoleKernel
{

    
    protected function schedule(Schedule $schedule): void
    {
        $schedule->call(function () {
            DB::table('Modulesuivis')
                ->where('ModNum', '<>', 0) // Exclude rows where ModNum = 0
                ->decrement('ModBatterie', 0.3472);
        })->hourly();
      
        $schedule->call(function () {
            $debarquements = debarquement::whereDate('DateDebarquement', Carbon::now())->get();
$cont_IDs = '';

foreach ($debarquements as $debarquement) {
    $cont_ID = $debarquement->NumDebarquement;
    $conteneurs = conteneur::where('NumDebarquement', $cont_ID)->get();
    foreach ($conteneurs as $conteneur) {
        $cont_IDs =$cont_IDs. $conteneur->Cont_ID."-";
    }
     
}
            $jsonBody = [
                "registration_ids" =>  [
                    "dvAfx1V4TZqW9tUIf7CaNv:APA91bFUozXUQhxK87uzHsRDOfkbD2u_F5tGNJkes_y1mO6znsJPTUMNhOEoo3ANfQ7mI9BVRL0TpSiKePsUr_7BJOxtakb0DhBA3gcCn-OdpOXfHC64nkqZXxwe3L_sLiiA7HsTl-wD",
                    "f0by3vd1TqqGCWMpByqNiy:APA91bGjlzlXLOwrk8j3X9ydsLvLsWDIbWle726SRAiw3Sb-i2mYvuz9oLRni-R3fME38tJ5W97jBRMsgsi9xXPXsN4GbrY5bO47ZniOW5qJsVcB0WjlvJ0_sjpGtmP0DFS71nbTpDPs"
                  ],
                "notification" => [
                    "title" => "Alerte",
                    "body" => "Deplacer Ces conteneurs".$cont_IDs." \n vers la zone du debarquement",
                    "content_available" => true,
                    "android" => [
                        "style" => "bigtext",
                        "priority" => "high",
                        "bigTextStyle" => [
                            "contentTitle" => "Déplacement d'un conteneur a été détecté",
                            "summaryText" => "Alerte",
                            "bigText" => "Detailed description of the alert goes here."
                        ]
                    ]
                ]
            ];

            $serverKey = "AAAAN-J_R3k:APA91bEzx_24yCRNQau9alc5v4Y7mhmO9lxQOn7G143Rvfd-rC4LoDdfDBpR9HkCfgjd53IadcrMaWPjQHCo-GrPG5hZEQKiebcoO4BfkFDqV3_Thzp-PfSBYZFuyVNzAiD3rcb2r8tB";
            $fcmUrl = "https://fcm.googleapis.com/fcm/send";

            $response = Http::withHeaders([
                'Content-Type' => 'application/json; charset=UTF-8',
                'Authorization' => 'key=' . $serverKey,
            ])->post($fcmUrl, $jsonBody);
    
                
        })->daily();
    }
    

    /**
     * Register the commands for the application.
     */
    protected function commands(): void
    {
        $this->load(__DIR__.'/Commands');
        

        require base_path('routes/console.php');
    }
}
