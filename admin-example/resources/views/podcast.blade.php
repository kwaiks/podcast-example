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
	                                        <li class="breadcrumb-item"><a href="#" class="breadcrumb-link">Podcast</a></li>
	                                    </ol>
	                                </nav>
	                            </div>
	                        </div>
	                    </div>
	                </div>
                    
                    <div class="row">
                    <div class="col-xl-12 col-lg-6 col-md-6 col-sm-12 col-12">
                        <div class="card">
                            <h5 class="card-header">Top 10 Podcasts
                            </h5>
                            <div class="card-body">
                                <canvas id="statistics"></canvas>
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
	                </div>
                    <div class="row">
                        <div class="col-xl-12 col-lg-6 col-md-12 col-sm-12 col-12">
                            <div class="card">
                                <h5 class="card-header">Podcast List</h5>
                                <div class="card-body">
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th scope="col">No</th>
                                                <th scope="col">Title</th>
                                                <th scope="col">Username</th>
                                                <th scope="col">Category</th>
                                                <th scope="col">Total Listener</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        @foreach($pods as $categories)
                                            <tr>
                                                <td>
                                                    <div>{{$loop->iteration}}</div>
                                                </td>
                                                <td>
                                                    <div>{{$categories->title}}</div>
                                                </td>
                                                <td>
                                                    <div>{{$categories->username}}</div>
                                                </td>
                                                <td>
                                                    <div>{{$categories->cat}}</div>
                                                </td>
                                                <td>
                                                    <div>{{$categories->click}}</div>
                                                </td>
                                            </tr>
                                            @endforeach
                                        </tbody>
                                    </table>
                                </div>
                                <div class="card-body">
                                <a href="{{route('podcast.excel')}}" class="btn btn-outline-primary btn-block btn-lg col-3 float-right">Export Data</a>
                                </div>
                            </div>
                        </div>
                        </div>
                        </div>
                    </div>
                    <script>
                                window.onload = function(){
                                    var ctx1 = $("#statistics")
                                    var data1 = {
                                        labels: [
                                            <?php foreach ($podchart as $key) {
                                                echo "'".$key->title."',";
                                            }
                                                ?>
                                        ],
                                        datasets:[{
                                            label: "# of votes",
                                            data:[
                                                <?php foreach ($podchart as $key) {
                                                echo "'".$key->click."',";
                                            }
                                                ?>
                                            ],
                                            backgroundColor:[
                                                "#DEB887",
                                                "#A9A9A9",
                                                "#CDA776",
                                                "#989898",
                                                "#FFFAAA",
                                                "#BA12D3",
                                                "#EA255B",
                                            ],
                                            borderColor: [
                                            "#CDA776",
                                            "#989898",
                                            ],
                                            borderWidth: [1, 1, 1, 1, 1]
                                        }]
                                    };
                                        var options = {
                                        responsive: true,
                                        title: {
                                        display: true,
                                        position: "top",
                                        fontSize: 18,
                                        fontColor: "#111"
                                        },
                                        legend: {
                                        display: true,
                                        position: "bottom",
                                        labels: {
                                            fontColor: "#333",
                                            fontSize: 16
                                        }
                                        }
                                    };
                                    var chart1 = new Chart(ctx1, {
                                        type: "doughnut",
                                        data: data1,
                                        options: options
                                    });
                                };
                                </script>
@endsection