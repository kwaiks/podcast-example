@extends('layouts.fixlayout')
@section('content')

<div class="dashboard-wrapper">
	        <div class="dashboard-influence">
	            <div class="container-fluid dashboard-content">
	                <!-- ============================================================== -->
	                <!-- pageheader  -->
	                <!-- ============================================================== -->
	                <div class="row">
	                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
	                        <div class="page-header">
	                            <h3 class="mb-2">Edit Category</h3>
	                            <div class="page-breadcrumb">
	                                <nav aria-label="breadcrumb">
	                                    <ol class="breadcrumb">
										<li class="breadcrumb-item"><a href="{{route('catindex')}}" class="breadcrumb-link">Categories</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">Edit</li>    
										</ol>
	                                </nav>
	                            </div>
							</div>
							<div class="card">
								<h5 class="card-header">Edit Category</h5>
								<div class="card-body">
									<form action="{{route('editcat',$cat->id)}}" method="POST" enctype="multipart/form-data">
										{{csrf_field()}}
										<div class="form-group">
											<label for="inputText" class="col-form-label">Nama Kategori</label>
											<input type="text" id="cat" name="cat" class="form-control" required="required" placeholder="{{$cat->cat}}">
										</div>
										<div class="form-group">
											<button class="btn btn-primary" type="submit">Submit</button>
										</div>
									</form>
								</div>
							</div>
	                    </div>
	                </div>
	                <!-- ============================================================== -->
	                <!-- end pageheader  -->
	                <!-- ============================================================== -->
	                <!-- ============================================================== -->
	                <!-- content  -->
	                <!-- ============================================================== -->
	                <!-- ============================================================== -->
	                <!-- influencer profile  -->
	                <!-- ============================================================== -->
	                
	                    <!-- ============================================================== -->
	                    <!-- end influencer profile  -->
	                    <!-- ============================================================== -->
	                    <!-- ============================================================== -->
	                    <!-- widgets   -->
	                    <!-- ============================================================== -->
	                    

                        
	                    
	                        <!-- ============================================================== -->
	                        <!-- end campaign activities   -->
	                        <!-- ============================================================== -->
	            </div>
            </div>
</div>

@endsection