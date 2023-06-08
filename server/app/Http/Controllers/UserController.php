<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
   public function register(Request $request){
//return $request->all(); //return all data from request

$userdata= $request->validate([
    'name' => ['required', 'string', 'max:5'],
    'email' => ['required', 'email', 'unique:users,email'],
    'password' => 'required|min:6',
]);

$user= User::create([
    'name' => $userdata['name'],
    'email' => $userdata['email'],
    'password' => Hash::make($userdata['password']),
]);
return response($user,201);
   }

   public function login(Request $request){
    $userdata= $request->validate([
        'email' => ['required', 'email'],
        'password' => 'required|min:6',
    ]);
    $user=User::Where('email',$userdata['email'])->first();
    if(!$user){
        return response(['message'=>'User not found'],404);
    }
    return response($user,201);
   }
}
