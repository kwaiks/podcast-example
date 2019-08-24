<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class categoriesModel extends Model
{
    protected $table ='categories';
    protected $fillable = ['cat','clicks','image'];
}
