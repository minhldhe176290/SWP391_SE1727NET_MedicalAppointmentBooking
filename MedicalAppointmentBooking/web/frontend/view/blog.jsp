<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

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
        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/newstyle.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/template/assets/css/tiny-slider.css"/>
        <!-- Select2 -->
        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/select2.min.css" rel="stylesheet" />
        <!-- Date picker -->
        <link rel="stylesheet" href="frontend/template/assets/css/flatpickr.min.css">
        <link href="${pageContext.request.contextPath}frontend/template/assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
        <style>
            #home{
                background-image: url("frontend/template/assets/images/bg/backgroundclinic.jpg") ;
            }
        </style>
    <body>

        <jsp:include page="/frontend/common/header.jsp" />
        <section class="bg-half-60 d-table w-100" id="home">
            <div class="bg-overlay bg-overlay-dark"></div>
            <div class="container">
                <div class="row mt-5 justify-content-center">
                    <div class="col-12">
                        <div class="section-title text-center">
                            <h3 class="sub-title mb-4 text-white title-dark">Blogs &amp; News</h3>
                            <p class="para-desc mx-auto text-white-50">Great doctor if you need your family member to get
                                effective immediate assistance, emergency treatment or a simple consultation.</p>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-3">
                                <ul class="breadcrumb bg-light rounded mb-0 py-1 px-2">
                                    <li class="breadcrumb-item"><a href="index.html">MABS</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Blogs</li>
                                </ul>
                            </nav>
                        </div>
                    </div><!--end col-->
                </div>
            </div><!--end container-->
        </section>
        <div class="container" style="margin-top: 90px;">
            <section class="blog_area section-padding">
                <div class="container">
                    <div class="row">
                        <h6 class="widget_title" style="color: #2d2d2d;">Recent Post</h6>                          
                        <c:forEach var="o" items="${requestScope.blogs3}">

                            <div class="col-lg-4 col-md-6 col-12 mb-4 pb-2" value="${o.blog_id}">
                                <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                                    <div class="imagefit">
                                        <img src="data:image/jpg;base64,${o.image}" style="width:100%;height:100%;" class="img-fluid" alt="">
                                    </div>
                                    <div class="card-body p-4">
                                        <ul class="list-unstyled mb-2">
                                            <li class="list-inline-item text-muted small me-3">
                                                ${o.created_time}
                                            </li>
                                            <li class="list-inline-item text-muted small"><i
                                                    class="uil uil-clock text-dark h6 me-1"></i>5 min read</li>
                                        </ul>
                                        <a href="newdetail?id=${o.blog_id}" class="text-dark title h5">${o.title}</a>
                                        <div>
                                            <ul class="list-unstyled mb-0">
                                                <a href="newdetail?id=${o.blog_id}" class="text-dark title h6">${o.description}</a>
                                            </ul>
                                        </div>
                                        <div class="post-meta d-flex justify-content-between mt-3">                                               
                                            <a href="newdetail?id=${o.blog_id}" class="link">Read More <i
                                                    class="mdi mdi-chevron-right align-middle"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </section>
        </div>
        <div class="container" style="padding-top:10px">
            <section class="blog_area section-padding">
                <div class="container">      
                    <form class="flexsearch--form1" action="new" method="post">
                        <div class="row">
                            <div class="col-lg-5 mb-5 mb-lg-0">
                                <div class="blog_left_sidebar">
                                    <aside class="single_sidebar_widget post_category_widget">
                                        <div>
                                            <h5 class="widget_title" style="color: #2d2d2d;text-align: center;">Category</h5>
                                        </div>
                                        <div>
                                            <ul class="list cat-list">
                                                <select class=""name="category" id="category" >
                                                    <option value="0">All</option>
                                                    <c:forEach var="o" items="${requestScope.listC}">
                                                        <option value="${o.blog_category_id}">${o.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </ul>
                                        </div>
                                    </aside>
                                </div>
                            </div>
                            <div class="col-lg-5 mb-5 mb-lg-0">
                                <div class="blog_left_sidebar">
                                    <aside class="single_sidebar_widget post_category_widget">
                                        <ul class="list cat-list">
                                            <div>
                                                <h5 class="widget_title" style="color: #2d2d2d;text-align: center;">Sorted By</h5>
                                            </div>
                                            <div>
                                                <select name="sort" id="sort">
                                                    <option value="all">All</option>
                                                    <option value="newest">Newest</option>
                                                    <option value="oldest">Oldest</option>
                                                </select>
                                            </div>
                                        </ul>
                                    </aside>
                                </div>
                            </div>
                            <div class="col-lg-2">
                                <div class="blog_left_sidebar">
                                    <aside class="single_sidebar_widget post_category_widget">
                                        <ul class="list cat-list">
                                            <div class="flexsearch">
                                                <div class="flexsearch--wrapper">
                                                    <div row>
                                                        <input class="flexsearch--submit" type="submit" value="&#10140" />
                                                    </div>
                                                </div>
                                            </div>
                                        </ul>
                                    </aside>
                                </div>
                            </div>
                        </div>
                    </form>

            </section>
        </div>

        <div class="container" style="padding-top:20px">
            <div>
                <c:forEach var="o" items="${requestScope.data}">
                    <div class="col-lg-12 col-md-6 col-12 mb-4 pb-2">
                        <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                            <div class="row">
                                <div class="col-lg-4">
                                    <img src="data:image/jpg;base64,${o.image}" class="image-container" alt="">
                                </div>
                                <div class="col-lg-8">
                                    <div class="card-body p-4">
                                        <ul class="list-unstyled mb-2">
                                            <li class="list-inline-item text-muted small me-3"><i
                                                    class="uil uil-calendar-alt text-dark h6 me-1"></i>${o.created_time}</li>
                                            <li class="list-inline-item text-muted small"><i
                                                    class="uil uil-clock text-dark h6 me-1"></i>5 min read</li>
                                        </ul>
                                        <a href="newdetail?id=${o.blog_id}" class="text-dark title h5">${o.title}</a>
                                        <div>
                                            <ul class="list-unstyled mb-0">
                                                <a href="newdetail?id=${o.blog_id}" class="text-dark title h6">${o.description}</a>
                                            </ul>
                                        </div>
                                        <div class="post-meta d-flex justify-content-between mt-3">                                                           
                                            <a href="newdetail?id=${o.blog_id}" class="link">Read More <i
                                                    class="mdi mdi-chevron-right align-middle"></i></a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>  
                </c:forEach>
            </div>
        </div>

        <jsp:include page="/frontend/common/footer.jsp" />
        <!-- javascript -->
        <script src="frontend/template/assets/js/jquery.min.js"></script>
        <script src="frontend/template/assets/js/bootstrap.bundle.min.js"></script>
        <!-- SLIDER -->
        <script src="frontend/template/assets/js/tiny-slider.js"></script>
        <script src="frontend/template/assets/js/tiny-slider-init.js"></script>
        <script src="frontend/template/assets/js/easy_background.js"></script>
        <!-- Select2 -->
        <script src="frontend/template/assets/js/select2.min.js"></script>
        <script src="frontend/template/assets/js/select2.init.js"></script>
        <!-- Datepicker -->
        <script src="frontend/template/assets/js/flatpickr.min.js"></script>
        <script src="frontend/template/assets/js/flatpickr.init.js"></script>
        <!-- Datepicker -->
        <script src="frontend/template/assets/js/jquery.timepicker.min.js"></script> 
        <script src="frontend/template/assets/js/timepicker.init.js"></script> 
        <!-- Icons -->
        <script src="frontend/template/assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="frontend/template/assets/js/app.js"></script>

    </body>
</html>