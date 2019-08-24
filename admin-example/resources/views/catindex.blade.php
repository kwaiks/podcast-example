@extends('layouts.fixlayout')
@section('content')
<div class="dashboard-wrapper">
    <div class="dashboard-influence">
        <div class="container-fluid dashboard-content">
            <div class="row">
                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                    <div class="page-header">
                        <h3 class="mb-2">Manage Categories</h3>
                        <div class="page-breadcrumb">
                            <nav aria-label="breadcrumb">
	                                    <ol class="breadcrumb">
										<li class="breadcrumb-item"><a href="" class="breadcrumb-link">Categories</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">Manage Categories</li>    
										</ol>
	                                </nav>
                        </div>
                    </div> 
                    <div class="card">
                                <h1 class="card-header">Category List

                                <div class="col-md-2 col-sm-12 coml-xs-12 form-group float-right">
                                    <a href="{{route('addcat')}}" class="btn btn-primary"> Add Category</a>
                                </div>
                                
                                </h1>
                                <div class="card-body">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th scope="col">No.</th>
                                                <th scope="col">Category Name</th>
                                                <th scope="col">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            @foreach($aww as $data)
                                            <tr>
                                                <td>
                                                    <div>{{$loop->iteration}}</div>
                                                </td>
                                                <td>
                                                    <div>{{$data->cat}}</div>
                                                </td>
                                                <td>
                                                    <div>
                                                        <!-- <a href="{{route('editcat',$data->id)}}" class="fa fa-edit btn btn-warning"> Edit</a> -->
                                                        <a href="{{route('deletecat',$data->id)}}" class="fa fa-trash btn btn-danger" onclick="return confirm('Are You Sure Want To Delete This ?')"> Delete</a>
                                                    </div>
                                                </td>
                                            </tr>
                                            @endforeach
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection