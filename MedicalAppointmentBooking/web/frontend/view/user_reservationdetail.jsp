

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>MABS</title>
        <!-- favicon -->
        <meta charset="utf-8" />
        <title>MABS - Medical Appointment Booking System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- favicon -->
        <link rel="shortcut icon" href="frontend/assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/template/assets/css/tiny-slider.css"/>
        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/select2.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/template/assets/css/flatpickr.min.css">
        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/remixicon.css"  type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/frontend/template/assets/css/style.min.css" type="text/css">
        <link href="${pageContext.request.contextPath}/frontend/template/assets/css/otherStyle.css" rel="stylesheet" type="text/css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="<c:url value= '/frontend/template/assets/js/flatpickr.min.js'/>"></script>

    </head>
    <body>
        <jsp:include page="/frontend/common/header.jsp" />
        <section class="bg-hero mt-4">
            <div class="container">
                <div class="row mt-lg-5">
                    <div class="col-md-6 col-lg-4">
                        <div class="rounded shadow overflow-hidden sticky-bar">
                            <div class="card border-0">
                                <img src="frontend/template/assets/images/bg/bg-profile.jpg" class="img-fluid" alt="">
                            </div>
                            <div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
                                <img src="data:image/jpg;base64,${sessionScope.user.image}" 
                                     class="rounded-circle shadow-md avatar avatar-md-md" alt="">
                                <h5 class="mt-3 mb-1">${sessionScope.user.fullName}</h5>
                            </div>
                            <div class="list-unstyled p-4">
                                <div class="d-flex align-items-center mt-2">
                                    <i class="uil uil-user align-text-bottom text-primary h5 mb-0 me-2"></i>
                                    <h6 class="mb-0">Gender</h6>
                                    <p class="text-muted mb-0 ms-2">${sessionScope.user.gender == 1 ?"Male": "Female" }</p>
                                </div>

                                <div class="d-flex align-items-center mt-2">
                                    <i class="uil uil-calendar-alt align-text-bottom text-primary h5 mb-0 me-2"></i>
                                    <h6 class="mb-0">Birthday</h6>
                                    <p class="text-muted mb-0 ms-2"><fmt:formatDate value="${sessionScope.user.dob}" pattern="dd/MM/yyyy"  /></p>
                                </div>

                                <div class="d-flex align-items-center mt-2">
                                    <i class="uil uil-phone  align-text-bottom text-primary h5 mb-0 me-2"></i>
                                    <h6 class="mb-0">Phone</h6>
                                    <p class="text-muted mb-0 ms-2">${sessionScope.user.phone}</p>
                                </div>

                                <div class="d-flex align-items-center mt-2">
                                    <i class="uil uil-italic align-text-bottom text-primary h5 mb-0 me-2"></i>
                                    <h6 class="mb-0">Address</h6>
                                    <p class="text-muted mb-0 ms-2">${sessionScope.user.address}</p>
                                </div>
                            </div>
                            <c:if test="${sessionScope.user.role.role_name == 'PATIENT'}">
                                <jsp:include page="/frontend/common/patient_side_bar.jsp" />  
                            </c:if>

                        </div>
                    </div><!--end col-->

                    <div class="col-lg-8 col-md-6 mt-4 mt-sm-0 pt-2 pt-sm-0">
                        <div class="card border-0 shadow overflow-hidden">
                            <div class="p-4 border-bottom">
                                <h5 class="mb-0">Service Information</h5>
                            </div>
                            <br><br><br><br><br>
                            <div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
                                <c:if test="${resv.service.service_image== 'default'}">
                                    <img src="../template/assets/images/avatar.png" class="rounded-circle shadow-md avatar avatar-md-md" alt="">
                                </c:if>
                                <c:if test="${resv.service.service_image != 'default'}">
                                    <img src="data:image/png;base64,${resv.service.service_image}" class="rounded-circle shadow-md avatar avatar-md-md" alt="">
                                </c:if>
                                <h5 class="mt-3 mb-1">${resv.service.service_name}</h5>
                            </div>

                            <div class="list-unstyled p-4">
                                <div class="d-flex align-items-center mt-2">
                                    <i class="uil uil-user align-text-bottom text-primary h5 mb-0 me-2"></i>
                                    <h6 class="mb-0">Service description</h6>
                                    <p class="text-muted mb-0 ms-2">${resv.service.service_description}</p>
                                </div>

                            </div>
                        </div><!--end col-->
                        <div class="card border-0 shadow overflow-hidden mt-4 ">
                            <div class="p-4 border-bottom">
                                <h5 class="mb-0">Reservation Details</h5>
                            </div>
                            <div class="tab-content p-4" id="pills-tabContent">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="mb-3">
                                            <label class="form-label">Reservation Date</label>
                                            <p>${resv.resvDate}</p>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="mb-3">
                                            <label class="form-label">Reservation Time</label>
                                            <p>${resv.resvTime}</p>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="mb-3">
                                            <label class="form-label">Status</label>
                                            <p>${resv.status}</p>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="mb-3">
                                            <label class="form-label">Service Fee</label>
                                            <p>${resv.service.fee}</p>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="mb-3">
                                            <label class="form-label">Service Note</label>
                                            <p>${resv.resvNote}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <c:if test="${resv.status == 'PENDING' || resv.status == 'CONFIRMED'}">
                            <div class="card border-0 shadow overflow-hidden mt-4 ">
                                <div class=" p-3 d-flex justify-content-center ">
                                    <div class="me-5">
                                        <a href="#cancelappointment" class="btn btn-primary btn-sml btn-soft-danger" 
                                           data-bs-toggle="modal" data-bs-target="#cancelappointment" onclick="cancelAppt(this)" data-id="${resv.resvId}">
                                            Cancel</a>
                                    </div>
                                    <div class="">
                                        <a href="#rescheduleappointment" class="btn btn-primary btn-sml" 
                                           data-bs-toggle="modal" data-bs-target="#rescheduleappointment" onclick="reschedule(this)" data-id="${resv.resvId}">
                                            Reschedule</a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${error != null}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>
                        <c:if test="${success != null}">
                            <div class="alert alert-success">${success}</div>
                        </c:if>
                    </div>        
                </div>
        </section>
        <div class="modal fade"  id="cancelappointment" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog "style="max-width: 500px;"  >
                <div class="modal-content">
                    <div class="modal-body py-5">
                        <div class="text-center">
                            <div class="icon d-flex align-items-center justify-content-center bg-soft-danger rounded-circle mx-auto" style="height: 95px; width:95px;">
                                <i class="uil uil-times-circle h1 mb-0"></i>
                            </div>
                            <div class="mt-4">
                                <h4>Cancel Reservation</h4>
                                <p class="para-desc mx-auto text-muted mb-0">This appointment will be canceled.Are you sure ?</p>
                                <div class="mt-4">
                                    <form action="<c:url value='/user-reservation?action=cancel'></c:url>" method="post">
                                            <input type="hidden" id="cancel_appointment" name="cancel_appointment" value="">
                                            <input type="submit" class="btn btn-soft-danger" name="cancel" value="Cancel">
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <div class="modal fade" id="rescheduleappointment" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" style="max-width: 500px;">
                    <div class="modal-content">
                        <div class="modal-body py-5">
                            <div class="card border-0 shadow overflow-hidden mt-4">
                                <form action="<c:url value='/user-reservation?action=reschedule'></c:url>" method="post">
                                    <div class="bg-white rounded shadow overflow-hidden">
                                        <div class="p-4 border-bottom">
                                            <h5 class="mb-0">Reschedule new reservation</h5>
                                        </div>
                                        <div class="p-3">
                                            <div class="">
                                                <label class="form-label">Select Reservation Date:</label>
                                                <input required id="checkin-date" name="resv-date" type="date" class="flatpickr flatpickr-input form-control">
                                            </div>
                                        </div>
                                        <div class="p-3">
                                            <div class="">
                                                <label class="form-label">Select Reservation Time:</label>
                                                <select required id="time" name="resv-time" class="form-control department-name select2input">
                                                    <option disabled selected>Select Time</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="p-3">
                                            <div class="">
                                                <label class="form-label">Your reason for rescheduling:</label>
                                                <textarea class="form-control" name="reschedule_reason" placeholder="Your reason" required></textarea>
                                            </div>
                                        </div>
                                        <div class="p-3">
                                            <div class="me-5">
                                                <input type="hidden" id="reschedule_appointment" name="reschedule_appointment" value="">
                                                <input type="submit" id="reassign" class="btn btn-primary" value="Confirm rescheduling">
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                $("#checkin-date").flatpickr({
                    minDate: "today",
                    maxDate: new Date().fp_incr(7)
                });
                function cancelAppt(appt) {
                    var dataId = appt.getAttribute('data-id');
                    let cancel_appt = document.getElementById('cancel_appointment');
                    cancel_appt.value = dataId;
                }
                function reschedule(appt) {
                    var dataId = appt.getAttribute('data-id');
                    let cancel_appt = document.getElementById('reschedule_appointment');
                    cancel_appt.value = dataId;
                }
                $(document).ready(function () {
                    $("#checkin-date").change(function () {
                        $("#time").find("option").remove();
                        $("#time").append("<option>Select Time</option>");
                        let chosendate = $("#checkin-date").val();
                        let data = {
                            type: "reservation",
                            patientId :"",
                            chosenDate: chosendate,
                            service_id: "${resv.resvId}"
                        };
                        $.ajax({
                            url: "CheckAvailabilityServlet",
                            method: "GET",
                            data: data,
                            success: function (data, textStatus, jqXHR) {
                                let obj = $.parseJSON(data);
                                $.each(obj, function (key, value) {
                                    $("#time").append(
                                            '<option value="' + value + '">' + value + "</option>"
                                            );
                                });
                                $("select").formSelect();
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                $("#time").append("<option>No Time Slot Unavailable</option>");
                            },
                            cache: false
                        });
                    });

                });
        </script>
        <jsp:include page="/frontend/common/footer.jsp" />
        <script src= "<c:url value= '/frontend/template/assets/js/bootstrap.bundle.min.js'/>"></script>
        <script src= "<c:url value= '/frontend/template/assets/js/feather.min.js'/>"></script>
        <script src= "<c:url value= '/frontend/template/assets/js/tiny-slider.js'/>"></script>
        <script src= "<c:url value= '/frontend/template/assets/js/app.js'/>"></script>
        <script src= "<c:url value= '/frontend/template/assets/js/tiny-slider.j'/>"></script>
        <script src= "<c:url value= '/frontend/template/assets/js/tiny-slider-init.js'/>"></script>
    </body>
</html>