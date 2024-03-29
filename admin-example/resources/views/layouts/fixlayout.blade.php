<!doctype html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="../assets/vendor/bootstrap/css/bootstrap.min.css">
    <link href="../assets/vendor/fonts/circular-std/style.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/libs/css/style.css">
    <link rel="stylesheet" href="../assets/vendor/fonts/fontawesome/css/fontawesome-all.css">
    <link rel="stylesheet" href="../assets/vendor/charts/morris-bundle/morris.css">
    <link rel="stylesheet" href="../assets/vendor/fonts/material-design-iconic-font/css/materialdesignicons.min.css">
    <title>Podcast Admin</title>
</head>

<body>
    <!-- ============================================================== -->
    <!-- main wrapper -->
    <!-- ============================================================== -->
    <div class="dashboard-main-wrapper">
	    <!-- ============================================================== -->
	    <!-- navbar -->
	    <!-- ============================================================== -->
	    <div class="dashboard-header">
	        <nav class="navbar navbar-expand-lg bg-white fixed-top">
	            <a class="navbar-brand">Admin Panel</a>
	            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	                <span class="navbar-toggler-icon"></span>
	            </button>
	            <div class="collapse navbar-collapse " id="navbarSupportedContent">
	                <ul class="navbar-nav ml-auto navbar-right-top">
	                    <li class="nav-item dropdown nav-user">
	                        <a class="nav-link nav-user-img" href="#" id="navbarDropdownMenuLink2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="assets/images/avatar-1.jpg" alt="" class="user-avatar-md rounded-circle"></a>
	                        <div class="dropdown-menu dropdown-menu-right nav-user-dropdown" aria-labelledby="navbarDropdownMenuLink2">
	                            <div class="nav-user-info">
	                                <h5 class="mb-0 text-white nav-user-name">Admin</h5>
	                            </div>
	                            <a class="dropdown-item" href="{{route('logout')}}"><i class="fas fa-power-off mr-2"></i>Logout</a>
	                        </div>
	                    </li>
	                </ul>
	            </div>
	        </nav>
	    </div>
	    <!-- ============================================================== -->
	    <!-- end navbar -->
	    <!-- ============================================================== -->
	    <!-- ============================================================== -->
	    <!-- left sidebar -->
	    <!-- ============================================================== -->
	    <div class="nav-left-sidebar sidebar-dark">
	        <div class="menu-list">
	            <nav class="navbar navbar-expand-lg navbar-light">
	                <a class="d-xl-none d-lg-none" href="#">Dashboard</a>
	                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	                    <span class="navbar-toggler-icon"></span>
	                </button>
	                <div class="collapse navbar-collapse" id="navbarNav">
	                    <ul class="navbar-nav flex-column">
	                        <li class="nav-divider">
	                            Menu
	                        </li>
	                        <li class="nav-item ">
	                            <a class="nav-link active" href="{{route('home')}}"><i class="fa fa-fw fa-user-circle"></i>Dashboard <span class="badge badge-success">6</span></a>
	                        </li>
	                        <li class="nav-item">
	                            <a class="nav-link" href="#" data-toggle="collapse" aria-expanded="false" data-target="#submenu-2" aria-controls="submenu-2"><i class="fa fa-fw fa-rocket"></i>Categories</a>
						    	<div id="submenu-2" class="collapse submenu" style="">
	                                <ul class="nav flex-column">
	                                    <li class="nav-item">
	                                        <a class="nav-link" href="{{route('categories')}}">Statistics</a>
	                                    </li>
	                                    <li class="nav-item">
	                                        <a class="nav-link" href="{{route('catindex')}}">Manage Categories</a>
	                                    </li>
	                                </ul>
	                            </div>
							</li>
	                        <li class="nav-item">
	                            <a class="nav-link" href="{{route('podcast')}}"><i class="fas fa-fw fa-chart-pie"></i>Podcast</a>
	                        </li>
	                        <li class="nav-item ">
	                            <a class="nav-link" href="{{route('users')}}" ><i class="fab fa-fw fa-wpforms"></i>Users</a>
	                        </li>
	                    </ul>
	                </div>
	            </nav>
	        </div>
	    </div>
	    <!-- ============================================================== -->
	    <!-- end left sidebar -->
	    <!-- ============================================================== -->
	    <!-- ============================================================== -->
	    <!-- wrapper  -->
	    <!-- ============================================================== -->
        @yield('content')
		<div class="footer">
	                                <div class="container-fluid">
	                                    <div class="row">
	                                        <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
	                                           Copyright © 2018 Concept. All rights reserved. Dashboard by <a href="https://colorlib.com/wp/">Colorlib</a>.
	                                        </div>
	                                        <div class="col-xl-6 col-lg-6 col-md-6 col-sm-12 col-12">
	                                            <div class="text-md-right footer-links d-none d-sm-block">
	                                                <a href="javascript: void(0);">About</a>
	                                                <a href="javascript: void(0);">Support</a>
	                                                <a href="javascript: void(0);">Contact Us</a>
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                            <!-- ============================================================== -->
	                            <!-- end footer -->
	                            <!-- ============================================================== -->
	                        </div>
							<!-- ============================================================== -->
	                    <!-- end main wrapper  -->
	                    <!-- ============================================================== -->
	                    <!-- Optional JavaScript -->
	                    <!-- jquery 3.3.1 -->
	                    <script src="../assets/vendor/jquery/jquery-3.3.1.min.js"></script>
	                    <!-- bootstap bundle js -->
	                    <script src="../assets/vendor/bootstrap/js/bootstrap.bundle.js"></script>
	                    <!-- slimscroll js -->
	                    <script src="../assets/vendor/slimscroll/jquery.slimscroll.js"></script>
	                    <!-- main js -->
	                    <script src="../assets/libs/js/main-js.js"></script>
	                    <!-- morris-chart js -->
	                    <script src="../assets/vendor/charts/morris-bundle/raphael.min.js"></script>
	                    <script src="../assets/vendor/charts/morris-bundle/morris.js"></script>
	                    <script src="../assets/vendor/charts/morris-bundle/morrisjs.html"></script>
	                    <!-- chart js -->
	                    <script src="../assets/vendor/charts/charts-bundle/Chart.bundle.js"></script>
	                    <script src="../assets/vendor/charts/charts-bundle/chartjs.js"></script>
	                    <!-- dashboard js -->
	                    <script src="../assets/libs/js/dashboard-influencer.js"></script>
        </body>
 
</html>