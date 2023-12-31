<%-- 
    Document   : service
    Created on : Sep 26, 2023, 11:34:47 PM
    Author     : PC
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>Services</title>
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/template/assets/css/flatpickr.min.css">
        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />

    </head>
    <body>

        <jsp:include page="/frontend/common/header.jsp" />
        <section class="bg-half-170 d-table w-100 mt-100" style="background: url('frontend/template/assets/images/bg/department.jpg') center center;">
            <div class="bg-overlay bg-overlay-dark">
                <div class="container">
                    <div class="row mt-5 justify-content-center">
                        <div class="col-12">
                            <div class="section-title text-center">
                                <h3 class="sub-title mb-4 text-white title-dark">Services</h3>
                                <p class="para-desc mx-auto text-white-50">Great doctor if you need your family member to get effective immediate assistance, emergency treatment or a simple consultation.</p>

                                <nav aria-label="breadcrumb" class="d-inline-block mt-3">
                                    <ul class="breadcrumb bg-light rounded mb-0 py-1 px-2">
                                        <li class="breadcrumb-item"><a href="home">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Services</li>
                                    </ul>
                                </nav>
                            </div>
                        </div><!--end col-->
                    </div><!--end row-->
                </div><!--end container-->
        </section><!--end section-->
        <div class="container">
            <div class="row">
                <div class="col-md-9">
                    <h3 class="title mt-5 text-primary">List Services</h3>
                </div>
            </div>
            <div class="row mb-5">
                <div class="col-md-4 d-flex align-items-center">
                    <form action="service?action=search" method="POST">
                        <div class="input-group">
                            <input type="text" name="keyword" id="searchInput" class="form-control border bg-light" placeholder="Search by name">
                            <button type="submit" class="btn btn-primary" id="searchButton">Search</button>
                        </div>
                        <c:choose>
                            <c:when test="${empty sList}">
                                <tr>
                                    <td colspan="1" class="h-5" style="font-size: 20px;">No services found with the given name.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${sList}" var="s">
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </form>
                </div>


                <div class="col-md-8 d-flex align-items-center justify-content-end">
                    <div class=" justify-content-end ">
                        <div class="selection-bar btn-success m-2 rounded-pill">
                            <select class="form-select form-control border rounded-pill bg-light" id="Filter" onchange="filter()">
                                <option selected >Filter By</option>
                                <c:forEach items="${requestScope.cateList}" var="c" >
                                    <option value=${c.sc_id} >${c.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class=" justify-content-end">
                        <div class="selection-bar btn-primary m-2 rounded-pill">
                            <select id="sortSelect" class="form-select form-control border rounded-pill bg-light" onchange="filter()" >
                                <option selected >Default Sort</option>
                                <option value="price">Price</option>
                                <option value="name">Name</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row custom-center">
                <div class="container mt-5 m-5">
                    <div class="row justify-content-center">

                        <c:forEach items="${requestScope.sList}" var="s" varStatus="loop">
                            <div class="col-md-4 mt-4">
                                <div class="card mb-4">
                                    <div class="card-img-container">
                                        <img src="data:image/jpg;base64,${s.service_image}" class="card-img-top" alt="${s.service_name}">
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title text-primary">${s.service_name}</h5>
                                        <div class="card-text">
                                            <p class="text-secondary">${s.service_description}</p>
                                        </div>
                                        <h5 class="text-muted">$${s.fee}</h5>
                                    </div>
                                    <div class="card-end">
                                        <a href="javascript:void(0);" onclick="viewServiceDetails(${s.service_id}, ${s.category_id})" class="btn btn-primary custom-button">Learn More</a>
                                        <a href="servicedetail?action=book-service&id=${s.service_id}"class="btn btn-success custom-button">Appointment Now</a>
                                    </div>
                                </div>

                            </div>
                            <c:if test="${loop.index % 3 == 3}">
                                <div class="w-100"></div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div><!--end row-->
            </div><!--end container-->
        </section><!--end section-->

        <div class="row text-end">
            <div class="col-12 mt-4">
                <ul class="pagination justify-content-end mb-5 mt-3 mt-sm-0">
                    <c:forEach begin="1" end="${num}" var="i">
                        <li class="page-item ${i == page ? 'active' : ''}">
                            <a class="page-link" href="${pageContext.request.contextPath}/service?action=view-all&page=${i}">
                                ${i}
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
    <jsp:include page="/frontend/common/footer.jsp" />

    <script>
        function viewServiceDetails(serviceId, categoryId) {
            var url = "servicedetail?action=view-detail&id=" + serviceId + "&category_id=" + categoryId;
            window.location.href = url;
        }
        
        function filter() {
        var category = document.getElementById("Filter").value;
                var sort = document.getElementById("sortSelect").value;
                var searchInput = document.getElementById("searchInput").value;
                var url = "manage-service?action=view-all"; // Default action

                if (category !== "Filter By") {
        url = "service?action=filter&category_id=" + category;
        } else if (searchInput.trim() !== "") {
        url = "service?action=search&keyword=" + searchInput;
        } else if (sort !== "Default Sort") {
        url = "service?action=sorted&by=feename&sort=" + sort;
        }

        window.location.href = url;
     

        }
        
    </script>


    <style>
        .custom-center {
            justify-content: center !important;
        }
        .card {
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            text-align: center;
        }

        .card-end {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 10px; /* Adjust padding as needed */
        }

        .custom-button {
            width: 100%;
            margin: 5px 0;
        }

        .service-card-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .card {
            flex: 1;
            margin: 0 1rem; /* Adjust margin as needed for spacing between cards */
            width: 100%; /* Set the width to 100% for full container width */
            max-width: 400px; /* Adjust the max-width as needed for the desired card size */
            height: 400px; /* Adjust the height as needed for the desired card size */
        }
        .card-img-container {
            height: 200px;
            overflow: hidden;
        }
        /* CSS để cân đối các dòng chữ trong card */
        .card {
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .card-body {
            flex: 1;
        }

        .card-title,
        .card-text {
            text-align: center;
            justify-content: s
        }
        .card-title,
        .card-text {
            margin-bottom: 15px; /* Khoảng cách giữa các dòng chữ */
        }

        .btn-primary {
            align-self: center; /* Để căn giữa nút "Learn More" */
        }

        .card-img-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        /* CSS để cân đối nút "Learn More" trong card */
        .card {
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            text-align: center;
        }


        .custom-button {
            width: 100%; /* Đảm bảo rằng nút có chiều ngang 100% của phần tử cha */
            margin: 5px 0; /* Khoảng cách giữa các nút */
        }
        .btn-primary {
            margin-top: auto; /* Để nút "Learn More" ở dưới cùng */
        }
        .custom-button {
            width: 100%; /* Đảm bảo rằng nút có chiều ngang 100% của phần tử cha */

        }
        body {
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .wrapper {
            flex: 1;
        }
        .footer {
            background-color: #333; /* Set the background color of your footer */
            color: white; /* Set the text color of your footer */
            text-align: center;
            padding: 20px;
            width: 100%;
        }
    </style>

    <!-- End -->
    <script src= "<c:url value= '/frontend/template/assets/js/bootstrap.bundle.min.js'/>"></script>
    <!-- Icons -->
    <script src= "<c:url value= '/frontend/template/assets/js/feather.min.js'/>"></script>
    <!-- Main Js -->
    <script src= "<c:url value= '/frontend/template/assets/js/tiny-slider.js'/>"></script>
    <script src= "<c:url value= '/frontend/template/assets/js/app.js'/>"></script>
    <script src= "<c:url     value= '/frontend/template/assets/js/tiny-slider.js'/>"></script>
    <script src= "<c:url value= '/frontend/template/assets/js/tiny-slider-init.js'/>"></script>
</body>

</html>
