<%-- 
    Document   : detailpatient
    Created on : Oct 19, 2023, 1:17:47 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Detail Service</title>
        <link rel="shortcut icon" href="/frontend/template/assets/images/favicon.ico.png">
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
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="/frontend/common/manager_side_bar.jsp" />
            <main class="page-content">
                <div class="top-header">
                    <div class="header-bar d-flex justify-content-between border-bottom">
                        <div class="d-flex align-items-center">
                            <a href="#" class="logo-icon">
                                <img src="frontend/template/assets/images/logo-icon.png" height="30" class="small" alt="">
                                <span class="big">
                                    <img src="frontend/template/assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                                    <img src="frontend/template/assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
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
                                            src="frontend/template/assets/images/doctors/01.jpg"
                                            class="avatar avatar-ex-small rounded-circle" alt=""></button>
                                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3"
                                         style="min-width: 200px;">
                                        <a class="dropdown-item d-flex align-items-center text-dark"
                                           href="https://shreethemes.in/doctris/layouts/admin/profile.html">
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
                <c:set value="${requestScope.patient}" var="p"></c:set>
                    <div class="mt-100" id="edit" role="tabpanel" aria-labelledby="edit">
                        <div class="card border-0 shadow overflow-hidden">
                            <div class="tab-content p-4" id="pills-tabContent">
                                <form action="<c:url value='/manage-patient?action=view&patientId=${p.patientId}'/>" method="POST" enctype="multipart/form-data">
                                <h2 class="mb-0 text-primary"> Patient Information</h2>
                                <div>   
                                    <h5 class=" mt-5">Patient Image</h5>
                                    <div id="thumbbox" class="mt-3 mb-3">
                                        <img class="rounded" height="20%" width="30%" alt="Thumb image" id="thumbImage"  src="data:image/jpg;base64,${p.image}" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="mb-3">
                                            <h5>Patient Name</h5>
                                            <label class="form-label ">${p.fullName}  </label>

                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="mb-3">
                                            <h5>Date Of Birth</h5>
                                            <label class="form-label"><fmt:formatDate value="${p.dob}" pattern="dd/MM/yyyy"/></label>

                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="mb-3">
                                            <h5>Address</h5>
                                            <label class="form-label">${p.address}  </label>

                                        </div>
                                    </div>
                                            <div class="col-lg-12">
                                        <div class="mb-3">
                                            <h5>Gender</h5>
                                            <label class="form-label">
                                                <c:if test="${p.gender == 1}">
                                                    <span class="text-primary">Male</span>
                                                </c:if>
                                                <c:if test="${p.gender == 0}">
                                                    <span class="text-secondary">Female</span>
                                                </c:if>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="mb-3">
                                            <h5>Status</h5>
                                            <label class="form-label">
                                                <c:if test="${p.status == 1}">
                                                    <span class="text-success">Active</span>
                                                </c:if>
                                                <c:if test="${p.status == 0}">
                                                    <span class="text-danger">Inactive</span>
                                                </c:if>
                                            </label>
                                        </div>
                                    </div>


                                    <div class="row">

                                        <div class="col-lg-9">
                                            <a href="<c:url value='/manage-patient?action=edit&patientId=${p.patientId}'/> " class="btn btn-primary m-3 ">Edit</a>
                                        </div>
                                        <div class=" col-lg-3">
                                            <a href="<c:url value='/manage-patient?action=view-all'/> " class="btn btn-primary m-3 ">Return</a>
                                        </div>

                                    </div>
                                </div>
                        </div>
                    </div>
            </main><!-- comment -->
        </div>
    </body>
    <script>


        function displayThumbnail() {
            const input = document.getElementById("uploadfile");
            const thumbnail = document.getElementById("thumbImage");

            // Check if a file has been selected
            if (input.files && input.files[0]) {
                const reader = new FileReader();

                reader.onload = function (e) {
                    thumbnail.src = e.target.result;
                };

                reader.readAsDataURL(input.files[0]);
            } else {

                thumbnail.src = "";
            }
        }
    </script>
    <script src="${pageContext.request.contextPath}/frontend/template/assets/js/bootstrap.bundle.min.js"></script>
    <!-- simplebar -->
    <script src="${pageContext.request.contextPath}/frontend/template/assets/js/simplebar.min.js"></script>
    <!-- Icons -->
    <script src="${pageContext.request.contextPath}/frontend/template/assets/js/feather.min.js"></script>
    <!-- Main Js -->
    <script src="${pageContext.request.contextPath}/frontend/template/assets/js/app.js"></script><
</html>
