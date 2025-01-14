<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Membership extends Model
{
    use HasFactory;

    protected $table = 'memberships';

    protected $fillable = [
        'packageName',
        'price',
        'description',
        'imageURL',
    ];

    public function users()
    {
        return $this->hasMany(Users::class, 'idMember');
    }
}
