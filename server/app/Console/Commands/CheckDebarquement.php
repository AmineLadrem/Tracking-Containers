<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\debarquement;
use Carbon\Carbon;
use Illuminate\Support\Facades\Http;

 
class CheckDebarquement extends Command
{
    protected $signature = 'debarquement:check';

    protected $description = 'Check Debarquement and send API notification if condition is met';

    public function __construct()
    {
        parent::__construct();
    }

    public function handle()
    {
        $debarquements = debarquement::whereDate('DateDebarquement', Carbon::now())->get();

        foreach ($debarquements as $debarquement) {
            // Prepare the JSON body
            $jsonBody = [
                "registration_ids" =>  [
                    "dvAfx1V4TZqW9tUIf7CaNv:APA91bFUozXUQhxK87uzHsRDOfkbD2u_F5tGNJkes_y1mO6znsJPTUMNhOEoo3ANfQ7mI9BVRL0TpSiKePsUr_7BJOxtakb0DhBA3gcCn-OdpOXfHC64nkqZXxwe3L_sLiiA7HsTl-wD",
                    "f0by3vd1TqqGCWMpByqNiy:APA91bGjlzlXLOwrk8j3X9ydsLvLsWDIbWle726SRAiw3Sb-i2mYvuz9oLRni-R3fME38tJ5W97jBRMsgsi9xXPXsN4GbrY5bO47ZniOW5qJsVcB0WjlvJ0_sjpGtmP0DFS71nbTpDPs"
                  ],
                "notification" => [
                    "title" => "Alerte",
                    "body" => "Déplacement du conteneur CMAU 44588 a été détecté",
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

            if ($response->status() == 200) {
                $this->info("Notification sent successfully");
            } else {
                $this->error("Error sending notification. Status code: " . $response->status());
            }
        }
    }
}
