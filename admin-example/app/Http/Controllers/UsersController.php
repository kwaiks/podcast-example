<?php

namespace App\Http\Controllers;

use DB;
use Excel;
use Illuminate\Http\Request;

class UsersController extends Controller
{
    public function index(){
        $user = DB::table('userlist')->leftJoin('podcastlist','userlist.id','=','podcastlist.userid')->select("*",DB::raw("SUM(click) as totalist"), DB::raw("COUNT(title) as totalpod"))->groupBy('userlist.id')->get()->toArray();
        $userchart = DB::table('podcastlist')->join('userlist','userlist.id','=','podcastlist.userid')->select("*",DB::raw("SUM(click) as totalist"), DB::raw("COUNT(title) as totalpod"))->groupBy('userid')->limit(10)->get()->toArray();
        $birthchart = DB::table('userlist')->select(DB::raw("CASE WHEN (DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(birthdate, '%Y') - (DATE_FORMAT(NOW(), '00-%m-%d') < DATE_FORMAT(birthdate, '00-%m-%d'))) < 15 THEN '<15'
        WHEN (DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(birthdate, '%Y') - (DATE_FORMAT(NOW(), '00-%m-%d') < DATE_FORMAT(birthdate, '00-%m-%d'))) <= 20 THEN '15 - 20'
        WHEN (DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(birthdate, '%Y') - (DATE_FORMAT(NOW(), '00-%m-%d') < DATE_FORMAT(birthdate, '00-%m-%d'))) <= 35 THEN '26 - 35'
        WHEN (DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(birthdate, '%Y') - (DATE_FORMAT(NOW(), '00-%m-%d') < DATE_FORMAT(birthdate, '00-%m-%d'))) <= 50 THEN '36 - 50'
        WHEN (DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(birthdate, '%Y') - (DATE_FORMAT(NOW(), '00-%m-%d') < DATE_FORMAT(birthdate, '00-%m-%d'))) > 50 THEN '>50' END AS age, COUNT(*) as total"))->groupBy('age')->get()->toArray();
        // echo "<pre";
        // print_r($birthchart);
        // echo "</pre>";
        
        return view ('users',compact('user','userchart','birthchart'));
    }////

    public function excel(){
        $user = DB::table('userlist')->leftJoin('podcastlist','userlist.id','=','podcastlist.userid')->select("*",DB::raw("SUM(click) as totalist"), DB::raw("COUNT(title) as totalpod"))->groupBy('userlist.id')->get()->toArray();
        $user_array[] = array('No','Username', 'Email', 'Gender', 'Birthdate', 'Total Podcast', 'Total Listener');
        $no = 1;
        foreach($user as $categories){
            $user_array[] = array(
                'No' => $no++,
                'Username' => $categories->username,
                'Email' => $categories->email,
                'Gender' => $categories->gender,
                'Birthdate' => $categories->birthdate,
                'Total Podcast' => $categories->totalpod,
                'Total Listener' => $categories->totalist
            );
            }
            Excel::create('Users Statistics', function($excel) use ($user_array){
                $excel->setTitle('Users Statistics');
                $excel->sheet('Users Statistics', function($sheet) use($user_array){
                        $sheet->fromArray($user_array, null, 'A1', true, false);
                    });
            })->download('xlsx');
    }
}
