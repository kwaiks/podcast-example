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
	                            <h3 class="mb-2">Infulencer Dashboard Template </h3>
	                            <div class="page-breadcrumb">
	                                <nav aria-label="breadcrumb">
	                                    <ol class="breadcrumb">
	                                        <li class="breadcrumb-item"><a href="#" class="breadcrumb-link">Dashboard</a></li>
	                                    </ol>
	                                </nav>
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
	                    <div class="row">
	                        <!-- ============================================================== -->
	                        <!-- four widgets   -->
	                        <!-- ============================================================== -->
	                        <!-- ============================================================== -->
	                        <!-- total views   -->
	                        <!-- ============================================================== -->
	                        <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
	                            <div class="card">
	                                <div class="card-body">
	                                    <div class="d-inline-block">
	                                        <h5 class="text-muted">Top Played Podcast</h5>
	                                        <h2 class="mb-0">{{$topplayed->title}}</h2>
                                            <h3 class="mb-0">By {{$topplayed->username}}</h3>
                                            <span class="mb-0">{{$topplayed->cat}} Category</span><br/>
                                            <span class="mb-0">Played {{$topplayed->click}} times</span>
	                                    </div>
	                                    <div class="float-right icon-circle-medium  icon-box-xl  mt-1">
                                            <img src="../assets/images/avatar-2.jpg" alt="" class="rounded-circle user-avatar-xl">
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
	                            <div class="card">
	                                <div class="card-body">
	                                    <div class="d-inline-block">
	                                        <h5 class="text-muted">Top Played Category</h5>
	                                        <h2 class="mb-0">{{$topcat->cat}}</h2>
                                            <br/>
                                            <span class="mb-0">Played {{$topcat->clicks}} times</span><br/>
                                            <span class="mb-0">{{$topcat->totalpod}} Podcast</span>
	                                    </div>
	                                    <div class="float-right icon-circle-medium  icon-box-xl  mt-1">
                                            <img src="../assets/images/avatar-2.jpg" alt="" class="rounded-circle user-avatar-xl">
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                        <!-- ============================================================== -->
	                        <!-- end total earned   -->
	                        <!-- ============================================================== -->
	                    </div>

                        <div class="row">
	                        <!-- ============================================================== -->
	                        <!-- four widgets   -->
	                        <!-- ============================================================== -->
	                        <!-- ============================================================== -->
	                        <!-- total views   -->
	                        <!-- ============================================================== -->
	                        <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-6">
	                            <div class="card">
	                                <div class="card-body">
	                                    <div class="d-inline-block">
	                                        <h5 class="text-muted">Top User</h5>
	                                        <h2 class="mb-0">{{$topuser->username}}</h2>
                                            <br/>
											<span class="mb-0">{{$topuser->totalpod}} Podcast</span><br/>
											<span class="mb-0">{{$topuser->totalist}} Listeners</span>
	                                    </div>
	                                    <div class="float-right icon-circle-medium  icon-box-xl  mt-1">
                                            <img src="../assets/images/avatar-2.jpg" alt="" class="rounded-circle user-avatar-xl">
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-6">
	                            <div class="card">
	                                <div class="card-body">
	                                    <div class="d-inline-block">
	                                        <h5 class="text-muted">Most Listeners Age</h5>
	                                        <h2 class="mb-0">{{$birth->age}} Years</h2>
                                            <br/>
                                            <span class="mb-0">{{$birth->total}} Persons</span><br/>
	                                    </div>
	                                    <div class="float-right icon-circle-medium  icon-box-xl  mt-1">
                                            <img src="../assets/images/avatar-2.jpg" alt="" class="rounded-circle user-avatar-xl">
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                        <!-- ============================================================== -->
	                        <!-- end total earned   -->
	                        <!-- ============================================================== -->
	                    </div>
						
						<div class="row">
						<div class="col-xl-12 col-lg-6 col-md-6 col-sm-12 col-12">
	                            <div class="card">
	                                <div class="card-body">
	                                    <div class="d-inline-block">
	                                        <h5 class="text-muted">Other Statistics</h5>
	                                        <span class="mb-0">{{$totalpodcast}} Total Podcasts</span><br/>
                                            <span class="mb-0">{{$totalcategories}} Categories</span>
                                            <br/>
                                            <span class="mb-0">{{$totallistener}} Total Listeners</span><br/>
                                            <span class="mb-0">{{$totaluser}} Total Users</span>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
						</div>
	                        <!-- ============================================================== -->
	                        <!-- end campaign activities   -->
	                        <!-- ============================================================== -->
	                    </div>

@endsection