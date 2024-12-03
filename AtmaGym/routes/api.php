<?php
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\TrainerController;
use App\Http\Controllers\EquipmentController;
use App\Http\Controllers\MembershipController;
use App\Http\Controllers\PaymentController;
use App\Http\Controllers\UsersController;

// Rute untuk mendapatkan pengguna yang terautentikasi
Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

// Rute untuk login pengguna
Route::post('/users/login', [UsersController::class, 'login']);

// Rute untuk mendapatkan pengguna berdasarkan email
Route::get('/users/email/{email}', [UsersController::class, 'showByEmail']);

// Rute API Resource
Route::apiResource('trainer', TrainerController::class);
Route::apiResource('equipment', EquipmentController::class);
Route::apiResource('membership', MembershipController::class);
Route::apiResource('payment', PaymentController::class);
Route::apiResource('users', UsersController::class);
