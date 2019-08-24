<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\categoriesModel;
use Session;

class NewCatController extends Controller
{
    public function index(){
        $aww = categoriesModel::orderBy('id','asc')->get();
        // echo '<pre>';
        // echo print_r($aww);
        // echo '</pre>';
        return view ('catindex',compact('aww'));
    }

    public function add(){
        return view('newcat');
    }

    public function insert(Request $request){
        $this->validate($request,[
            'cat' => 'required'
        ]);
        $data = 0;
        
            categoriesModel::create([
                'cat' => $request['cat'],
            ]);
        

            // echo '<pre>';
            // echo print_r($data);
            // echo '</pre>';
        Session::flash('success_msg','Category Uploaded!');
        return redirect()->route('catindex');
    }

    public function edit($id){
        $get = categoriesModel::find($id);
        return view('catedit',['cat' => $get]);
    }

    // public function update(Request $request,$id){
    //     $this->validate([
    //         'cat' => 'required',
    //         'image' => 'required|mimes:jpeg,jpg,bmp,png'
    //     ]);

    //     $catData = $request->all();
    //     categoriesModel::find($id)->update($catData);
    //     Session::flash('success_msg','Category Updated!');
    //     return redirect()->route('catindex');
    // }

    public function delete($id){
        $del = categoriesModel::find($id);
        $del->delete();
        Session::flash('danger_msg','Category Deleted!');
        return redirect()->route('catindex');
    }
    //
}
