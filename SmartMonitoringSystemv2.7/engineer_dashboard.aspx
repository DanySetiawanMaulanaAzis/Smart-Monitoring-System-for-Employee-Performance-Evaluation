<%@ Page MasterPageFile="~/Site.Master" Title="Smart Monitoring System" Language="C#" AutoEventWireup="true" CodeBehind="engineer_dashboard.aspx.cs" Inherits="SmartMonitoringSystemv2._7.engineer_dashboard" Async="true" %>


<asp:Content runat="server" ID="content1" ContentPlaceHolderID="head">
    <!-- CSS DataTables -->
    <link href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.dataTables.min.css" rel="stylesheet">

    <!-- JS DataTables -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>

    <!-- JS DataTables Buttons -->
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>

    <!-- Library untuk membuat file Excel -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>

    <%--LINK UNTUK APACHE ECHARTS--%>
    <script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>



    <style>
        /* Material Design Styling untuk tabel */
        #userTable {
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
            overflow: hidden;
            transition: box-shadow 0.3s ease;
        }

            /* Hover effect pada tabel */
            #userTable tbody tr:hover {
                background-color: #f1f1f1;
                cursor: pointer;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }

            /* Styling untuk baris data */
            #userTable tbody tr {
                background-color: #ffffff;
                border-bottom: 1px solid #ddd;
            }

            /* Padding dan spacing cell tabel */
            #userTable th, #userTable td {
                padding: 16px 24px;
                text-align: left;
                font-size: 1rem;
            }

            /* Styling Header tabel */
            #userTable th {
                font-weight: 500;
                background-color: #FFFFFF;
                color: black;
            }

            /* Baris data genap dengan latar belakang lebih terang */
            #userTable tbody tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            /* Menambah transisi pada hover baris */
            #userTable tbody tr {
                transition: background-color 0.3s ease;
            }

            /* Menambah shadow saat hover */
            #userTable td {
                transition: box-shadow 0.2s ease;
            }

                #userTable td:hover {
                    box-shadow: inset 0 0 10px rgba(0, 0, 0, 0.1);
                }

        /* Styling untuk card header */
        .card-header {
            border-bottom: 2px solid #ddd;
        }

        /* Set font family dan mengatur gaya teks */
        #userTable {
            font-family: 'Roboto', sans-serif;
        }
    </style>



</asp:Content>



<asp:Content runat="server" ID="content2" ContentPlaceHolderID="main">
    <div class="my-3 my-md-5">
        <div class="container-fluid">
            <div class="page-header">
                <%--<h1 class="page-title">Dashboard</h1>--%>
            </div>
            <div class="row row-cards">
               
                <%--tabel Total Task Completed--%>
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center flex-wrap">
                            <h3 class="card-title">Total Task Completed</h3>
                            <div class="filter-section d-flex align-items-end">
                                <div class="mr-2">
                                    <label for="startDate">Start Date:</label>
                                    <input type="date" id="startDate1" class="form-control">
                                </div>
                                <div class="mr-2">
                                    <label for="endDate">End Date:</label>
                                    <input type="date" id="endDate1" class="form-control">
                                </div>
                                <button type="button" id="filterButton1" class="btn btn-primary">Filter</button>
                            </div>
                            
                        </div>
                        <div id="totalChart" style="height: 500px;"></div>
                    </div>
                </div>
                <%--tabel Total Task Completed--%>



                <%--tabel Employee Performance--%>
                <div class="col-lg-6">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center flex-wrap">
                            <h3 class="card-title">Employee Performance</h3>
                            <div class="filter-section d-flex align-items-end">
                                <div class="mr-2">
                                    <label for="startDate">Start Date:</label>
                                    <input type="date" id="startDate2" class="form-control">
                                </div>
                                <div class="mr-2">
                                    <label for="endDate">End Date:</label>
                                    <input type="date" id="endDate2" class="form-control">
                                </div>
                                <button type="button" id="filterButton2" class="btn btn-primary">Filter</button>
                            </div>
                            
                        </div>
                        <div id="userPerformanceChart" style="height: 500px;"></div>
                    </div>
                </div>
                <%--tabel User Performance--%>
            </div>

            <%-- Tabel User --%>
            <div class="row row-cards row-deck">
                <div class="col-12">
                    <div class="card" style="border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
                        <div class="card-header" style="background-color: #FFFFFF; color: black; padding: 16px;">
                            <h3 class="card-title" style="font-size: 1.125rem; margin: 0;">Employee Monitoring Dashboard Performance</h3>
                        </div>
                        <div class="table-responsive">
                            <table id="userTable" class="display table table-striped" style="width: 100%; border-collapse: collapse; font-family: 'Roboto', sans-serif; background-color: white; border-radius: 8px; overflow: hidden;">
                                <thead>
                                    <tr style="background-color: #FFFFFF; color: black; font-weight: 500; text-align: left; border-bottom: 1px solid #ddd;">
                                        <th style="padding: 16px 24px; font-size: 1rem;">Username</th>
                                        <th style="padding: 16px 24px; font-size: 1rem;">Finished Today</th>
                                        <th style="padding: 16px 24px; font-size: 1rem;">Average Workmanship</th>
                                        <th style="padding: 16px 24px; font-size: 1rem;">Total Workshipman</th>
                                        <%--disini prediksi pekerjaan yang diselesaikan besok menggunakan LSTM--%>
                                        <%--disini prediksi performa karyawan menggunakan Random Forest Classifier--%>
                                        <th style="padding: 16px 24px; font-size: 1rem;">Tomorrow's Performance Forecast</th>
                                        <th style="padding: 16px 24px; font-size: 1rem;">Performance</th>
                                        
                                    </tr>
                                </thead>
                                <tbody id="userTableBody" runat="server">
                                    <!-- Data rows will be inserted here by DataTables -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <%-- Tabel User --%>
        </div>
    </div>


    <script>
        $(document).ready(function () {

            // Inisialisasi DataTables
            const dataTable = $('#userTable').DataTable({
                dom: 'Bfrtip',
                buttons: [
                    {
                        extend: 'excelHtml5',
                        text: 'Excel',
                        title: 'Work Log',
                        exportOptions: {
                            modifier: {
                                page: 'all'
                            }
                        }
                    }
                ]
            });



            const totalChartDom = document.getElementById("totalChart");
            const totalChart = echarts.init(totalChartDom);
            const userPerformanceChartDom = document.getElementById("userPerformanceChart");
            const userPerformanceChart = echarts.init(userPerformanceChartDom);

            // Default saat halaman pertama kali dibuka
            loadTotalChart(null, null);
            loadUserPerformanceChart(null, null);

            // Tombol filter chart 1
            $('#filterButton1').on('click', function () {
                const start = $('#startDate1').val();
                const end = $('#endDate1').val();
                loadTotalChart(start, end);
            });

            // Event filter berdasarkan tanggal
            $('#filterButton2').on('click', function () {
                const startDate = $('#startDate2').val();
                const endDate = $('#endDate2').val();

                if (startDate && endDate) {
                    loadUserPerformanceChart(startDate, endDate);
                } else {
                    // Jika salah satu kosong, tetap panggil semua data
                    loadUserPerformanceChart(null, null);
                }
            });


            function loadTotalChart(startDate, endDate) {
                fetch("engineer_dashboard.aspx/GetCompletedTasksData", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({
                        startDate: startDate || null,
                        endDate: endDate || null
                    })
                })
                    .then(res => res.json())
                    .then(data => {
                        const dates = data.d.dates;
                        const completedTasks = data.d.completedTasks;

                        totalChart.setOption({
                            tooltip: { trigger: "axis", axisPointer: { type: "shadow" } },
                            xAxis: { type: "category", data: dates, axisLabel: { rotate: 45 } },
                            yAxis: { type: "value" },
                            series: [
                                {
                                    name: "Total",
                                    type: "bar",
                                    data: completedTasks,
                                    itemStyle: { color: "#5470C6" },
                                    label: { show: true, position: 'inside', color: "#fff" }
                                },
                                {
                                    name: "Tasks (Line)",
                                    type: "line",
                                    data: completedTasks,
                                    smooth: true,
                                    itemStyle: { color: "#FF5733", width: 2 },
                                    symbol: "circle",
                                    symbolSize: 8,
                                    tooltip: {
                                        show: false
                                    }
                                }
                            ]
                        });
                    });
            }


            function loadUserPerformanceChart(startDate, endDate) {
                const userPerformanceChartDom = document.getElementById("userPerformanceChart");
                const userPerformanceChart = echarts.init(userPerformanceChartDom);

                fetch("engineer_dashboard.aspx/GetUserPerformanceData", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({ startDate: startDate, endDate: endDate }) // <--- Kirim parameter
                })
                    .then(response => response.json())
                    .then(data => {
                        const usernames = data.d.usernames;
                        const totalCompletedTasks = data.d.totalCompletedTasks;

                        const userPerformanceChartOption = {
                            
                            tooltip: {
                                trigger: "axis",
                                axisPointer: { type: "shadow" }
                            },
                            xAxis: {
                                type: "category",
                                data: usernames,
                                axisLabel: { rotate: 45 }
                            },
                            yAxis: {
                                type: "value"
                            },
                            series: [
                                {
                                    name: "Total",
                                    type: "bar",
                                    data: totalCompletedTasks,
                                    itemStyle: { color: "#91CC75" },
                                    label: {
                                        show: true,
                                        position: 'inside',
                                        color: "#fff"
                                    }
                                }
                            ]
                        };

                        userPerformanceChart.setOption(userPerformanceChartOption);
                    })
                    .catch(error => console.error("Error fetching user performance data:", error));
            }
        });
    </script>


</asp:Content>


