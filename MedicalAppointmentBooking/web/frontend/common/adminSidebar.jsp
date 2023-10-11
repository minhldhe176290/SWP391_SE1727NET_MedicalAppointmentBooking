<%-- 
    Document   : adminSidebar
    Created on : Sep 28, 2023, 10:40:27 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    </head>
    <body>

        <nav id="sidebar" class="sidebar-wrapper">
            <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
                <div class="sidebar-brand">
                    <a href="index.html">
                        <img src="../../template/assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                        <img src="../assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                    </a>
                </div>

                <ul class="sidebar-menu pt-3">
                    <li><a href="index.html"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>
                    <li><a href="appointment.html">
                            <i class="uil uil-stethoscope me-2 d-inline-block"></i>Appointment</a>
                    </li>

                    <li class="sidebar-dropdown">
                        <a href="<c:url value='/manage-doctor?action=view-all'/>"><i class="uil uil-user me-2 d-inline-block"></i>Doctors</a>
                    </li>
                    <li class="sidebar-dropdown">
                        <a href="javascript:void(0)"><i class="uil uil-user me-2 d-inline-block"></i>Services</a>
                    </li>

                    <li class="sidebar-dropdown">
                        <a href="javascript:void(0)"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Patients</a>

                    </li>
                    <li class="sidebar-dropdown">
                        <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Blogs</a>
                    </li>
                </ul>
                <!-- sidebar-menu  -->
            </div>
        </nav>
    </body>

</html>