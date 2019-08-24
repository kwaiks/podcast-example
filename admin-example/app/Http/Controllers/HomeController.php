<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Session;
use DB;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(){
        $topplayed = DB::table('categories')->join('podcastlist', 'categories.cat','=','podcastlist.cat')->join('userlist','userlist.id','=','podcastlist.userid')->orderBy('podcastlist.click','desc')->get()->first();
        $topcat = DB::table('categories')->select('categories.clicks', 'categories.cat', DB::raw('count(podcastlist.title) as totalpod'))->leftJoin('podcastlist', 'podcastlist.cat', '=', 'categories.cat')->groupBy('categories.cat')->orderBy('categories.clicks','desc')->get()->first();
        $topuser = DB::table('userlist')->leftJoin('podcastlist','userlist.id','=','podcastlist.userid')->select("*",DB::raw("SUM(click) as totalist"), DB::raw("COUNT(title) as totalpod"))->groupBy('userlist.id')->orderBy('totalpod','desc')->get()->first();
        $totalpodcast = DB::table('podcastlist')->count();
        $totalcategories = DB::table('categories')->count();
        $totaluser = DB::table('userlist')->count();
        $totallistener = DB::table('podcastlist')->sum('click');
        $birth = DB::table('userlist')->select(DB::raw("CASE WHEN (DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(birthdate, '%Y') - (DATE_FORMAT(NOW(), '00-%m-%d') < DATE_FORMAT(birthdate, '00-%m-%d'))) < 15 THEN '<15'
        WHEN (DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(birthdate, '%Y') - (DATE_FORMAT(NOW(), '00-%m-%d') < DATE_FORMAT(birthdate, '00-%m-%d'))) <= 20 THEN '15 - 20'
        WHEN (DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(birthdate, '%Y') - (DATE_FORMAT(NOW(), '00-%m-%d') < DATE_FORMAT(birthdate, '00-%m-%d'))) <= 35 THEN '26 - 35'
        WHEN (DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(birthdate, '%Y') - (DATE_FORMAT(NOW(), '00-%m-%d') < DATE_FORMAT(birthdate, '00-%m-%d'))) <= 50 THEN '36 - 50'
        WHEN (DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(birthdate, '%Y') - (DATE_FORMAT(NOW(), '00-%m-%d') < DATE_FORMAT(birthdate, '00-%m-%d'))) > 50 THEN '>50' END AS age, COUNT(*) as total"))->groupBy('age')->orderBy('total','desc')->get()->first();
        // echo "<pre>";
        // echo print_r($topplayed);
        // echo "</pre>";
        return view ('home',compact('topplayed','topcat','topuser','totalpodcast','totalcategories','totallistener','totaluser', 'birth'));
    }

    public function logout(){
        Session::flush();
        return redirect('login')->with('alert','You Are Logout Now!. Please Login Again');
    }
}
