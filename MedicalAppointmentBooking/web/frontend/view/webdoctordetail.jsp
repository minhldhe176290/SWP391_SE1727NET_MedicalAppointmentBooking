<%-- 
    Document   : webdoctordetail
    Created on : Oct 7, 2023, 9:50:29 PM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>MABS</title>
        <!-- favicon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/frontend/template/assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <!-- SLIDER -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/template/assets/css/tiny-slider.css"/>
        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/select2.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="frontend/template/assets/css/flatpickr.min.css">
        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
        <style>
            #home{
                background-image: url("frontend/template/assets/images/bg/backgroundclinic.jpg") ;
            }
            .header{
                margin-bottom: 150px;
                background-color: #D9D9D9;
            }
            .doctor{
                display: flex;
                margin-left: 13%;
                margin-bottom: 20px;
            }
            .doctor-content{
                margin: auto;
            }
            .doctor-content h2 {
                color:#516FDC;
            }
            .doctor-content h6{
                color:grey;
            }
            .doctor-content span{
                color:#516FDC;
            }
            .doctor-content p{
                font-weight: bold;
            }
            ul {
                list-style-type: none;
                margin: 0;
                padding: 0;
                overflow: hidden;
            }
            li {
                float: left;
            }
            li a {
                display: block;
                color:black;
                text-align: center;
                padding: 14px 16px;
                text-decoration: none;

            }

            li a:hover {
                background-color: #516FDC;
                color:white;
            }
            .content{
                margin-left: 13%;
            }
            .header-content {
                justify-content: center;
            }
            .header-content {
                text-align: center;
                padding: 20px 0;
            }

            .header-content ul {
                display: flex;
                justify-content: center;
                list-style-type: none;
                margin: 0;
                padding: 0;
            }

            .header-content li {
                margin: 0 20px; /* Khoảng cách giữa các mục menu */
            }

            .header-content a {
                text-decoration: none;
                color: black;
            }

            .header-content a:hover {
                background-color: #516FDC;
                color: white;
            }
            .overview-content{
                margin-left: 30px;
                padding-bottom: 20px;
            }
            .overview-content h6{
                color:blue;
                font-weight: lighter;
            }
            .overview-content {
                display: block;
            }
        </style>
    </head>
    <body>
        <div class="header">
            <jsp:include page="/frontend/common/header.jsp" />
        </div>
        <div>

        </div>
        <div class="col-md-9 border-0 rounded shadow doctor">
            <div class="col-xl-4 col-lg-4 col-md-5 position-relative doctor-img">
                <img src="data:image/jpg;base64,${doctor.image}" width="300" height="360"/>
            </div>
            <div class="col-xl-8 col-lg-8 col-md-7">
                <div class="p-lg-5 p-4 doctor-content">
                    <h4>Good Morning !</h4>

                    <h2>Dr. ${doctor.fullName}</h2>

                    <h6>Great doctor if you need your family member to get effective immediate assistance,</h6>
                    <h6>emergency treatment or a simple consultation</h6>
                    <p>You have <span>? patients</span> remaining today!</p>
                </div>
            </div>

        </div>
        <div class="content">
            <div class="col-md-9 border-0 rounded shadow">
                <div class="header-content">
                    <ul>
                        <li><a id="overview-link" class="active" href="#Overview">Overview</a></li>
                        <li><a href="#Experience">Experience</a></li>
                        <li><a href="#Reviews">Reviews</a></li>
                        <li><a href="#Timetable">Timetable</a></li>
                    </ul>
                </div>
                <div class="overview-content">
                    <h5>${doctor.fullName}</h5>
                    <h6>${doctor.position}</h6>
                    <br><!-- comment -->
                    <p>${doctor.description}</p>
                    <h5>Speciality:</h5>
                    <p>${doctor.speciality}</p>
                </div>
            </div>

        </div>




        <script>
            // Lấy thẻ "Overview" và phần nội dung "overview-content"
            var overviewLink = document.getElementById("overview-link");
            var overviewContent = document.querySelector(".overview-content");

            // Xác định sự kiện click cho thẻ "Overview"
            overviewLink.addEventListener("click", function (e) {
                e.preventDefault(); // Ngăn chặn điều hướng mặc định

                // Kiểm tra trạng thái hiển thị của nội dung
                if (overviewContent.style.display === "none") {
                    overviewContent.style.display = "block"; // Hiển thị nếu đang ẩn
                } else {
                    overviewContent.style.display = "none"; // Ẩn nếu đang hiển thị
                }
            });
        </script>
    </body>
    <footer>
        <jsp:include page="/frontend/common/footer.jsp" />
    </footer>
</html>






