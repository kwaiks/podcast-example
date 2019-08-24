<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\categoriesModel;
use DB;
use Excel;
use App\podcastModel;
class CategoriesController extends Controller
{
    public function index(){
        
        $cats = DB::table('categories')->select('categories.clicks', 'categories.cat', DB::raw('count(podcastlist.title) as totalpod'))->leftJoin('podcastlist', 'podcastlist.cat', '=', 'categories.cat')->groupBy('categories.cat')->orderBy('categories.id')->get()->toArray();
        $chart2 = DB::table('categories')->get()->toArray();
        // foreach ($chart as $value) 
        //     $array1[] = $value->cat;

        //     $info = array(
        //         'firstname' => 'John',
        //         'lastname' => 'Cena',
        //         'from' => 'USA'
        //         );
    
        // $data = array();
        // foreach ($chart as $row ) {
        //     $data[] = $row;
        // }
        // $result = json_encode($data);
        // echo "<pre";
        // print_r($cats);
        // echo "</pre>";
        return view ('categories',compact('cats','chart2'));
    }

    public function excel(){
        $cats = DB::table('categories')->select('categories.clicks', 'categories.cat', DB::raw('count(podcastlist.title) as totalpod'))->leftJoin('podcastlist', 'podcastlist.cat', '=', 'categories.cat')->groupBy('categories.cat')->orderBy('categories.id','asc')->get()->toArray();
        $cats_array[] = array('No', 'Category', 'Total Podcast', 'Total Listener');
        $no = 1;
        foreach($cats as $categories){
            $cats_array[] = array(
                'No' => $no++,
                'Category' => $categories->cat,
                'Total Podcast' => $categories->totalpod,
                'Total Listener' => $categories->clicks
            );
            }
            Excel::create('Category Statistics', function($excel) use ($cats_array){
                $excel->setTitle('Category Statistics');
                $excel->sheet('Category Statistics', function($sheet) use($cats_array){
                        $sheet->fromArray($cats_array, null, 'A1', false, false);
                    });
            })->download('xlsx');
    }
}
