<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('auth.login');
});

Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');
Route::get('/categories', 'CategoriesController@index')->name('categories');
Route::get('/users', 'UsersController@index')->name('users');
Route::get('/podcast', 'PodcastController@index')->name('podcast');
Route::get('/new', 'NewCatController@index')->name('newcat');
Route::get('/logout', 'HomeController@logout')->name('logout');

Route::get('/categories/excel', 'CategoriesController@excel')->name('categories.excel');
Route::get('/podcast/excel', 'PodcastController@excel')->name('podcast.excel');
Route::get('/users/excel', 'UsersController@excel')->name('users.excel');

Route::get('/addcat','NewCatController@add')->name('addcat');
Route::get('/editcat/{id}','NewCatController@edit')->name('editcat');
Route::get('/deletecat/{id}','NewCatController@delete')->name('deletecat');
Route::post('/updatecat/{id}','NewCatController@update')->name('updatecat');
Route::post('/insertcat','NewCatController@insert')->name('insertcat');
Route::get('/catindex','NewCatController@index')->name('catindex');
