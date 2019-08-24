@extends('layouts.fixlayout')
@section('content')
<div class="dashboard-wrapper">
	        <div class="dashboard-influence">
	            <div class="container-fluid dashboard-content">
	                <!-- ============================================================== -->
	                <!-- pageheader  -->
	                <!-- ============================================================== -->
	                <div class="row">
                    <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6">
                        <div class="card">
                            <h5 class="card-header">Top 10 Users Listener
                            </h5>
                            <div class="card-body">
                                <canvas id="statistics"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6 col-6">
                        <div class="card">
                            <h5 class="card-header">Users Age Range
                            </h5>
                            <div class="card-body">
                                <canvas id="statistics1"></canvas>
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
                                                <th scope="col">Username</th>
                                                <th scope="col">Email</th>
                                                <th scope="col">Gender</th>
                                                <th scope="col">Birthdate</th>
												<th scope="col">Total Podcast</th>
                                                <th scope="col">Total Listener</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        @foreach($user as $categories)
                                            <tr>
                                                <td>
                                                    <div>{{$loop->iteration}}</div>
                                                </td>
                                                <td>
                                                    <div>{{$categories->username}}</div>
                                                </td>
                                                <td>
                                                    <div>{{$categories->email}}</div>
                                                </td>
                                                <td>
                                                    <div>{{$categories->gender}}</div>
                                                </td>
												<td>
                                                    <div>{{$categories->birthdate}}</div>
                                                </td>
												<td>
                                                    <div>{{$categories->totalpod}}</div>
                                                </td>
												<td>
                                                    <div>
													@if(is_null($categories->totalist))	
															0
													@else
														{{$categories->totalist}}
													@endif
													</div>
                                                </td>
                                            </tr>
                                            @endforeach
                                        </tbody>
                                    </table>
                                </div>
								<div class="card-body">
                                <a href="{{route('users.excel')}}" class="btn btn-outline-primary btn-block btn-lg col-3 float-right">Export Data</a>
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
                                            <?php foreach ($userchart as $key) {
                                                echo "'".$key->username."',";
                                            }
                                                ?>
                                        ],
                                        datasets:[{
                                            label: "# of votes",
                                            data:[<?php foreach ($userchart as $key) {
                                                echo "'".$key->totalist."',";
                                            }
                                                ?>],
                                            backgroundColor:[
                                                "#DEB887",
                                                "#A9A9A9",
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

                                    var ctx2 = $("#statistics1")
                                    var data2 = {
                                        labels: [
                                            <?php foreach ($birthchart as $key) {
                                                echo "'".$key->age."',";
                                            }
                                                ?>
                                        ],
                                        datasets:[{
                                            label: "# of votes",
                                            data:[<?php foreach ($birthchart as $key) {
                                                echo "'".$key->total."',";
                                            }
                                                ?>],
                                            backgroundColor:[
                                                "#DEB887",
                                                "#A9A9A9",
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
                                    var chart2 = new Chart(ctx2, {
                                        type: "doughnut",
                                        data: data2,
                                        options: options
                                    });
                                };
                                </script>
@endsection