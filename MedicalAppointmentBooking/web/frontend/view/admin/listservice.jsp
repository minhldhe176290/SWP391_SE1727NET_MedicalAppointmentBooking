    <%-- 
    Document   : listservice
    Created on : Oct 12, 2023, 1:16:48 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Service</title>

        <!-- favicon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/frontend/template/assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Select2 -->
        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/select2.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">

        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    </head>
    <body>
        <div id="preloader">
            <div id="status">
                <div class="spinner">
                    <div class="double-bounce1"></div>
                    <div class="double-bounce2"></div>
                </div>
            </div>
        </div>
        <!-- Loader -->
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="/frontend/common/manager_side_bar.jsp" />
            <!-- sidebar-wrapper  -->
            <!-- Start Page Content -->
            <main class="page-content">


                <div class="top-header">
                    <div class="header-bar d-flex justify-content-between border-bottom">
                        <div class="d-flex align-items-center">
                            <a href="#" class="logo-icon">
                                <img src="frontend/template/assets/images/logo-icon.png" height="30" class="small" alt="">
                                <span class="big">
                                    <img src="frontend/template/assets/images/MABS__1.png" height="24" class="logo-light-mode" alt="">
                                    <img src="frontend/template/assets/images/MABS__1.png" height="24" class="logo-dark-mode" alt="">
                                </span>
                            </a>
                            <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#">
                                <i class="uil uil-bars"></i>
                            </a>
                        </div>
                        <ul class="list-unstyled mb-0">
                            <li class="list-inline-item mb-0 ms-1">
                                <div class="dropdown dropdown-primary">
                                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0"
                                            data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img
                                            src="../../assets/images/doctors/01.jpg"
                                            class="avatar avatar-ex-small rounded-circle" alt=""></button>
                                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3"
                                         style="min-width: 200px;">
                                        <a class="dropdown-item d-flex align-items-center text-dark"
                                           <img src="../assets/images/doctors/01.jpg"
                                           class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="flex-1 ms-2">
                                                <span class="d-block mb-1">Calvin Carlo</span>
                                                <small class="text-muted">Orthopedic</small>
                                            </div>
                                        </a>
                                        <a class="dropdown-item text-dark" href="dr-profile.html"><span
                                                class="mb-0 d-inline-block me-1"><i
                                                    class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                        <div class="dropdown-divider border-top"></div>
                                        <a class="dropdown-item text-dark" href="lock-screen.html"><span
                                                class="mb-0 d-inline-block me-1"><i
                                                    class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="row align-content-center">
                            <div class="col-xl-3 col-md-3">
                                <div class="card component-wrapper border-0 rounded shadow">
                                    <div>
                                        <select class="form-select form-control" id="Filter" onchange="filter()">
                                            <option selected disabled>Category</option>
                                            <c:forEach items="${cateList}" var="cate">
                                                <option value="${cate.sc_id}">${cate.name}</option>  
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                            </div>
                            <div class="col-xl-6 col-md-6">
                                <div class="search-bar d-lg-block " style="padding-top :0">
                                    <div id="search" class="menu-search  ">
                                        <form action="<c:url value='/manage-service?action=search'/>"role="search" method="post" id="searchform" class="searchform  ">
                                            <div>
                                                <input type="text" class="form-control border rounded-pill bg-light " name="search"
                                                       id="search" placeholder="Search service by name">
                                                <input type="submit" id="searchsubmit" value="Search">
                                            </div>
                                            <c:choose>
                                                <c:when test="${empty sList}">
                                                    <tr>
                                                        <td colspan="6">No services found with the given name.</td>
                                                    </tr>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach items="${sList}" var="s">
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>

                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-3 mt-4 mt-md-0 text-md-end">
                                <a href="<c:url value='/manage-service?action=add'/>" class="btn btn-primary ">Add Service</a>
                            </div><!--end col-->
                        </div><!--end row-->


                        <div class="col-12 mt-5">
                            <div class="card component-wrapper border-0 rounded shadow ">
                                <div class="p-4 border-bottom">
                                    <h4 class="mb-0 text-primary">Service List</h4>
                                </div>

                                <div class="p-4">
                                    <div class="table-responsive bg-white shadow rounded">
                                        <table class="table mb-0 table-center">
                                            <thead>
                                                <tr>
                                                    <th scope="col">ID</th>
                                                    <th scope="col">Image</th>
                                                    <th scope="col">Name</th>
                                                    <th scope="col">Price</th>
                                                    <th scope="col">Status</th>
                                                    <th scope="col" class="text-md-center">Action</th> 
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${sList}" var="s">
                                                    <tr>
                                                        <th scope="row">${s.service_id}</th>
                                                        <td><img src="data:image/jpg;base64,${s.service_image}" width="200" height="100"></td>
                                                        <td>${s.service_name}</td>
                                                        <td>$${s.fee}</td>
                                                        <td>
                                                            <c:if test="${s.service_status == 1}">
                                                                <span class="text-success">Active</span>
                                                            </c:if>
                                                            <c:if test="${s.service_status == 0}">
                                                                <span class="text-danger ">InActive</span>
                                                            </c:if>
                                                        </td>

                                                        <td class="text-center">
                                                            <div class="container d-flex justify-content-center">
                                                                <div class="card component-wrapper border-0 rounded">
                                                                    <div class="d-flex mb-2">
                                                                        <a href="<c:url value='/manage-service?action=view&service_id=${s.service_id}'/>" class="btn btn-primary custom-btn btn-sm m-2">View</a>
                                                                        <a href="<c:url value='/manage-service?action=edit&service_id=${s.service_id}'/>" class="btn btn-primary custom-btn btn-sm m-2">Edit</a>
                                                                        <c:choose>
                                                                            <c:when test="${s.service_status == 1}">
                                                                                <a href="<c:url value='/manage-service?action=status&service_id=${s.service_id}&status=${s.service_status}'/>" 
                                                                                   class="btn btn-danger custom-btn btn-sm m-2"
                                                                                   onclick="return confirm('Are you sure you want to deactivate this service?');">Deactivate</a>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <a href="<c:url value='/manage-service?action=status&service_id=${s.service_id}&status=${s.service_status}'/>" 
                                                                                   class="btn btn-success custom-btn btn-sm m-2"
                                                                                   onclick="return confirm('Are you sure you want to activate this service?');">Activate</a>
                                                                            </c:otherwise>
                                                                        </c:choose>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </td>


                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>



                                <div class="row text-end">
                                    <div class="col-12 mt-4">
                                        <ul class="pagination justify-content-end mb-5 mt-3 mt-sm-0">
                                            <c:forEach begin="1" end="${num}" var="i">
                                                <li class="page-item ${i == page ? 'active' : ''}">
                                                    <a class="page-link" href="${pageContext.request.contextPath}/manage-service?action=view-all&page=${i}">
                                                        ${i}
                                                    </a>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div><!--end col-->

                    </div>
                </div><!--end container-->
            </main>
            <!--End page-content" -->
            <!-- Modal -->

        </div>
        <!-- page-wrapper -->
        <style>
            .custom-btn {
                width: 100px; /* Adjust the width as needed */
            }
        </style>
        <!-- javascript -->
        <script>
            function filter() {
                const url = 'http://localhost:8080/MedicalAppointmentBooking/manage-service?action=filter&category_id=';
                const filterElement = document.getElementById("Filter").value;
                window.location.href = url + filterElement;
            }


        </script>
        <script src="${pageContext.request.contextPath}/frontend/template/assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="${pageContext.request.contextPath}/frontend/template/assets/js/simplebar.min.js"></script>
        <!-- Icons -->
        <script src="${pageContext.request.contextPath}/frontend/template/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="${pageContext.request.contextPath}/frontend/template/assets/js/app.js"></script>


    </body>
</html>

