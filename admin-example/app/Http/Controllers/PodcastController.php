<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Excel;
use DB;

class PodcastController extends Controller
{
    public function index(){
        $pods = DB::table('podcastlist')->join('userlist','userlist.id','=','podcastlist.userid')->orderBy('podcastlist.id','asc')->get()->toArray();
        $podchart = DB::table('podcastlist')->join('userlist','userlist.id','=','podcastlist.userid')->orderBy('podcastlist.id','asc')->limit(10)->get()->toArray();
        return view ('podcast', compact('pods','podchart'));
    }//

    public function excel(){
        $pods = DB::table('podcastlist')->join('userlist','userlist.id','=','podcastlist.userid')->orderBy('podcastlist.id','asc')->get()->toArray();
        $pods_array[] = array('No','Title', 'Username', 'Category', 'Total Listener');
        $no = 1;
        foreach($pods as $categories){
            $pods_array[] = array(
                'No' => $no++,
                'Title' => $categories->title,
                'Username' => $categories->username,
                'Category' => $categories->cat,
                'Total Listener' => $categories->click
            );
            }
            Excel::create('Podcast Statistics', function($excel) use ($pods_array){
                $excel->setTitle('Podcast Statistics');
                $excel->sheet('Podcast Statistics', function($sheet) use($pods_array){
                        $sheet->fromArray($pods_array, null, 'A1', false, false);
                    });
            })->download('xlsx');
    }
}
