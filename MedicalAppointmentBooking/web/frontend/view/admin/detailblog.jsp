<%-- 
    Document   : adddoctor
    Created on : Sep 28, 2023, 1:54:24 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="shortcut icon" href="/assets/images/favicon.ico.png">
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
                                <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3"
                                     style="min-width: 200px;">
                                    <a class="dropdown-item d-flex align-items-center text-dark"
                                       <img src="data:image/jpg;base64,${sessionScope.user.image}"
                                       class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                        <div class="flex-1 ms-2">
                                            <span class="d-block mb-1">${sessionScope.user.fullName}</span>
                                            <small class="text-muted"></small>
                                        </div>
                                    </a>

                                    <div class="dropdown-divider border-top"></div>
                                    <a class="dropdown-item text-dark" href="<c:url value='/home?action=logout'/>"><span
                                            class="mb-0 d-inline-block me-1"><i
                                                class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <c:set value="${requestScope.blog}" var="blog"></c:set>
                    <div class="mt-100" id="edit" role="tabpanel" aria-labelledby="edit">
                        <div class="card border-0 shadow overflow-hidden">
                            <div class="tab-content p-4" id="pills-tabContent">
                                <form action="<c:url value='/manage-blog?action=detail&blog_id=${blog.blog_id}'/>" method="POST" enctype="multipart/form-data">
                                <h5 class="mb-0"> Blog Information.</h5>
                                <div>   
                                    <label class="form-label">Image  </label>
                                    <div id="thumbbox" class="mt-3 mb-3">
                                        <img class="rounded" height="20%" width="30%" alt="Thumb image" id="thumbImage"  src="data:image/jpg;base64,${blog.image}" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="mb-3">
                                            <label class="form-label">Title  </label>
                                            <h5>${blog.title}</h5>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="mb-3">
                                            <label class="form-label">Description</label>
                                            <h5>${blog.description}</h5>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="mb-3 custom-box">
                                            <label class="form-label">Content</label>
                                            <h5>${blog.content}</h5>
                                        </div>
                                    </div>

                                </div>

                                <div class="row">
                                    <div class=" col-lg-3">
                                        <a href="<c:url value='/manage-blog?action=view-all'/> " class="btn btn-primary btn-sm">TURN BACK</a>
                                    </div>
                                </div>

                            </form>
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
