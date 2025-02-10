
<%@page import="customer.CustomerDAO"%>
<%@page import="java.util.List"%>
<%@page import="vaccine.VaccineDAO"%>
<%@page import="vaccine.VaccineDTO"%>
<%@page import="customer.CustomerDTO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Đăng ký thông tin trẻ em</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                background-color: #f0f2f5;
                padding: 20px;
            }

            .container {
                max-width: 600px;
                margin: 0 auto;
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .header {
                text-align: center;
                margin-bottom: 30px;
                color: #1e88e5;
            }

            .header i {
                font-size: 48px;
                margin-bottom: 10px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                color: #333;
                font-weight: 500;
            }

            input[type="text"],
            input[type="date"] {
                width: 100%;
                padding: 12px;
                border: 2px solid #e0e0e0;
                border-radius: 5px;
                font-size: 16px;
                transition: all 0.3s ease;
            }

            input[type="text"]:focus,
            input[type="date"]:focus {
                border-color: #1e88e5;
                outline: none;
                box-shadow: 0 0 0 3px rgba(30,136,229,0.1);
            }

            .gender-group {
                display: flex;
                gap: 20px;
                margin-top: 10px;
            }

            .gender-option {
                display: flex;
                align-items: center;
                gap: 8px;
                cursor: pointer;
            }

            .gender-option input[type="radio"] {
                width: 18px;
                height: 18px;
            }

            .submit-btn {
                width: 100%;
                padding: 14px;
                background: #1e88e5;
                color: white;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                transition: background 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
            }

            .submit-btn:hover {
                background: #1565c0;
            }

            .error-message {
                background: #ffebee;
                color: #c62828;
                padding: 10px;
                border-radius: 5px;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .back-link {
                display: inline-block;
                margin-top: 20px;
                color: #1e88e5;
                text-decoration: none;
                font-weight: 500;
            }

            .back-link:hover {
                text-decoration: underline;
            }

            .vaccine-options {
                border: 2px solid #e0e0e0;
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
            }

            .vaccine-option {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
                padding: 8px;
                border-radius: 4px;
                cursor: pointer;
            }

            .vaccine-option:hover {
                background-color: #f5f5f5;
            }

            .vaccine-option input[type="checkbox"] {
                margin-right: 10px;
                width: 18px;
                height: 18px;
            }

            select {
                width: 100%;
                padding: 12px;
                border: 2px solid #e0e0e0;
                border-radius: 5px;
                font-size: 16px;
                appearance: none;
                background: url("data:image/svg+xml,...") no-repeat right 12px center;
                background-size: 12px;
            }

            select:focus {
                border-color: #1e88e5;
                outline: none;
                box-shadow: 0 0 0 3px rgba(30,136,229,0.1);
            }

            .parent-info {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 5px;
                margin-bottom: 20px;
            }

            .section-title {
                font-size: 1.1em;
                color: #1e88e5;
                margin-bottom: 15px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .vaccine-section {
                margin-bottom: 20px;
            }
            .vaccine-list {
                border: 2px solid #e0e0e0;
                border-radius: 5px;
                max-height: 300px;
                overflow-y: auto;
                padding: 10px;
            }

            .vaccine-options {
                border: 2px solid #e0e0e0;
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
                max-height: 300px;
                overflow-y: auto;
            }

            .vaccine-option {
                display: flex;
                align-items: flex-start;
                margin-bottom: 15px;
                padding: 10px;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.2s;
            }

            .vaccine-option:hover {
                background-color: #f5f5f5;
            }

            .vaccine-option input[type="checkbox"] {
                margin-right: 15px;
                margin-top: 5px;
                width: 18px;
                height: 18px;
            }

            .vaccine-info {
                display: flex;
                flex-direction: column;
                gap: 5px;
            } .vaccine-name {
                font-weight: 500;
                color: #1e88e5;
            }

            .vaccine-info {
                flex: 1;
            }

            .vaccine-name {
                font-weight: 600;
                color: #1e88e5;
                margin-bottom: 5px;
            }

            .vaccine-description {
                font-size: 0.9em;
                color: #666;
                margin-bottom: 5px;
            }

            .vaccine-details {
                display: flex;
                justify-content: space-between;
                font-size: 0.9em;
            }

            .vaccine-age {
                color: #2e7d32;
            }

            .vaccine-price {
                color: #c62828;
                font-weight: 500;
            }
            .vaccine-list {
                border: 2px solid #e0e0e0;
                border-radius: 5px;
                max-height: 300px;
                overflow-y: auto;
                padding: 10px;
            }

            .vaccine-description {
                font-size: 0.9em;
                color: #666;
            }

            .vaccine-price {
                font-weight: 500;
                color: #e53935;
            }

            .vaccine-checkbox {
                margin-right: 15px;
                margin-top: 5px;
            }

            .vaccine-item {
                padding: 15px;
                border-bottom: 1px solid #eee;
                display: flex;
                align-items: flex-start;
            }

            /* CSS cho phần đặt lịch */
            .appointment-section {
                margin-top: 20px;
                padding: 15px;
                background: #f8f9fa;
                border-radius: 5px;
            }

            .time-slots {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 10px;
                margin-top: 10px;
            }

            .time-slot {
                padding: 10px;
                text-align: center;
                border: 1px solid #ddd;
                border-radius: 4px;
                cursor: pointer;
                transition: all 0.3s;
            }

            .time-slot:hover {
                background: #e3f2fd;
                border-color: #1e88e5;
            }

            .time-slot.selected {
                background: #1e88e5;
                color: white;
                border-color: #1e88e5;
            }


            /* Tùy chỉnh thanh cuộn */
            .vaccine-options::-webkit-scrollbar {
                width: 8px;
            }

            .vaccine-options::-webkit-scrollbar-track {
                background: #f1f1f1;
                border-radius: 4px;
            }

            .vaccine-options::-webkit-scrollbar-thumb {
                background: #888;
                border-radius: 4px;
            }

            .vaccine-options::-webkit-scrollbar-thumb:hover {
                background: #666;
            }


            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
                z-index: 1000;
                animation: fadeIn 0.3s;
            }

            .modal-content {
                position: relative;
                background-color: #fff;
                margin: 15% auto;
                padding: 30px;
                width: 400px;
                border-radius: 10px;
                text-align: center;
                animation: slideIn 0.3s;
            }

            .success-icon {
                font-size: 60px;
                color: #4CAF50;
                margin-bottom: 20px;
            }

            .success-icon i {
                animation: scaleIn 0.5s;
            } 
            @keyframes fadeIn {
                from {opacity: 0;}
                to {opacity: 1;}
            }

            @keyframes slideIn {
                from {transform: translateY(-100px); opacity: 0;}
                to {transform: translateY(0); opacity: 1;}
            }

            @keyframes scaleIn {
                0% {transform: scale(0);}
                60% {transform: scale(1.2);}
                100% {transform: scale(1);}
            }

            /* Add to existing style section */
            .parent-info-section {
                background: #f8f9fa;
                padding: 25px;
                border-radius: 10px;
                margin: 30px 0;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                border: 1px solid #e0e0e0;
            }

            .section-title {
                font-size: 1.2em;
                color: #1e88e5;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 2px solid #e3f2fd;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .section-title i {
                color: #1565c0;
            }

            .form-group label i {
                width: 20px;
                color: #1e88e5;
                margin-right: 8px;
            }

            .form-group input {
                transition: all 0.3s ease;
            }

            .form-group input:focus {
                transform: translateY(-2px);
            }

            input[type="tel"],
            input[type="email"] {
                width: 100%;
                padding: 12px;
                border: 2px solid #e0e0e0;
                border-radius: 5px;
                font-size: 16px;
                transition: all 0.3s ease;
            }

            input[type="tel"]:focus,
            input[type="email"]:focus {
                border-color: #1e88e5;
                outline: none;
                box-shadow: 0 0 0 3px rgba(30,136,229,0.1);
            }

            .form-group {
                position: relative;
                margin-bottom: 25px;
            }

            .form-group label {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
                font-weight: 500;
                color: #333;
            }

            .readonly-input {
                background-color: #f5f5f5;
                border: 1px solid #ddd;
                color: #666;
                cursor: not-allowed;
            }

            .parent-info-section {
                background: #fff;
                padding: 25px;
                border-radius: 10px;
                margin: 30px 0;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .section-title {
                font-size: 1.2em;
                color: #1e88e5;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 2px solid #e3f2fd;
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: flex;
                align-items: center;
                margin-bottom: 8px;
                color: #333;
                font-weight: 500;
            }

            .form-group label i {
                margin-right: 8px;
                color: #1e88e5;
            }

            .form-group input {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 14px;
            }


            .info-section {
                background: #fff;
                padding: 25px;
                border-radius: 10px;
                margin-bottom: 30px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .section-title {
                font-size: 1.2em;
                color: #1e88e5;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .info-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
            }

            .info-item {padding: 15px;
                        background: #f8f9fa;
                        border-radius: 8px;
                        border: 1px solid #e3f2fd;
            }

            .info-item label {
                display: flex;
                align-items: center;
                gap: 8px;
                color: #666;
                font-size: 0.9em;
                margin-bottom: 5px;
            }

            .info-item .info-value {
                color: #333;
                font-weight: 500;
                font-size: 1.1em;
            }

            .info-item i {
                color: #1e88e5;
            }
        </style>
    </head>
    <body>
        <!-- Sửa lại cấu trúc form để bao gồm tất cả các trường input -->
        <div class="container">
            <%
                // Get logged in user info
                CustomerDTO loginUser = (CustomerDTO) session.getAttribute("LOGIN_USER");
                CustomerDAO customerDAO = new CustomerDAO();
                CustomerDTO parent = null;

                if (loginUser != null) {
                    // Get full parent info from database
                    parent = customerDAO.getUserByID(loginUser.getUserID());
                } else {
                    response.sendRedirect("login.jsp");
                    return;
                }
            %>

            <div class="header">
                <i class="fas fa-child"></i>
                <h1>Đăng ký thông tin trẻ em</h1>
                <p>Vui lòng điền đầy đủ thông tin bên dưới</p>
            </div>


            <!-- Replace existing parent-info-section with this -->
            <div class="parent-info-section">
                <div class="section-title">
                    <i class="fas fa-user-friends"></i>
                    Thông tin phụ huynh
                </div>

                <div class="info-grid">
                    <div class="info-item">
                        <label><i class="fas fa-user"></i> Họ và tên</label>
                        <div class="info-value"><%= parent.getFullName()%></div>
                    </div>



                    <div class="info-item">
                        <label><i class="fas fa-phone"></i> Số điện thoại</label>
                        <div class="info-value"><%= parent.getPhone()%></div>
                    </div>

                    <div class="info-item">
                        <label><i class="fas fa-envelope"></i> Email</label>
                        <div class="info-value"><%= parent.getEmail()%></div>
                    </div>

                    <div class="info-item">
                        <label><i class="fas fa-home"></i> Địa chỉ</label>
                        <div class="info-value"><%= parent.getAddress()%></div>
                    </div>
                </div>

            </div>


            <form id="registrationForm" action="AddChildController" method="POST">
                <input type="hidden" name="selectedTime" id="selectedTime" required>

                <!-- Phần đặt lịch -->
                <div class="appointment-section">
                    <h3><i class="fas fa-calendar-alt"></i> Đặt lịch tiêm</h3>
                    <div class="form-group">
                        <label for="appointmentDate">Ngày đặt lịch</label>
                        <input type="date" id="appointmentDate" name="appointmentDate" required>
                    </div>

                    <div class="form-group">
                        <label>Chọn thời gian</label>
                        <div class="time-slots">
                            <div class="time-slot" data-time="morning">
                                <i class="fas fa-sun"></i> Buổi sáng<br>
                                (8:00 - 12:00)
                            </div>
                            <div class="time-slot" data-time="afternoon">
                                <i class="fas fa-cloud-sun"></i> Buổi chiều<br>
                                (13:00 - 17:00)
                            </div>
                        </div>
                        <input type="hidden" name="selectedTime" id="selectedTime">
                    </div>
                </div>

                <!-- Thông tin trẻ -->
                <div class="section-title">
                    <i class="fas fa-user-circle"></i>
                    Thông tin trẻ
                </div>

                <div class="form-group">
                    <label for="childName">Họ và tên trẻ</label>
                    <input type="text" id="childName" name="childName" required 
                           placeholder="Nhập họ và tên trẻ">
                </div>

                <div class="form-group">
                    <label for="birthDate">Ngày sinh</label>
                    <input type="date" id="birthDate" name="birthDate" required>
                </div>

                <div class="form-group">
                    <label>Giới tính</label>
                    <div class="gender-group">
                        <label class="gender-option">
                            <input type="radio" name="gender" value="Nam" required>
                            <span>Nam</span>
                        </label>
                        <label class="gender-option">
                            <input type="radio" name="gender" value="Nữ" required>
                            <span>Nữ</span>
                        </label>
                    </div>
                </div>

                <button type="submit" class="submit-btn">
                    <i class="fas fa-save"></i>
                    Đăng ký thông tin
                </button>


                <a href="vaccinationSchedule.jsp" class="back-link">
                    <i class="fas fa-arrow-left"></i>
                    Quay lại trang chủ
                </a>
        </div>

        <!-- Modal thành công -->
        <div id="successModal" class="modal">
            <div class="modal-content">
                <div class="success-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <h2>Đăng ký thành công!</h2>
                <p>Thông tin của bạn đã được ghi nhận.</p>
                <p>Hệ thống sẽ chuyển đến trang đăng ký vaccine cho bạn!</p>
            </div>
        </div>



        <script>
            // Validate ngày đặt lịch
            const appointmentDateInput = document.getElementById('appointmentDate');
            const today = new Date().toISOString().split('T')[0];
            appointmentDateInput.setAttribute('min', today);

            // Xử lý chọn time slot
            const timeSlots = document.querySelectorAll('.time-slot');
            const selectedTimeInput = document.getElementById('selectedTime');

            timeSlots.forEach(slot => {
                slot.addEventListener('click', () => {
                    timeSlots.forEach(s => s.classList.remove('selected'));
                    slot.classList.add('selected');
                    selectedTimeInput.value = slot.dataset.time;
                });
            });



            // Sửa lại form submit
            document.querySelector('form').onsubmit = function (e) {
                e.preventDefault();
                const formData = new FormData(this);

                fetch('AddChildController', {
                    method: 'POST',
                    body: formData
                })
                        .then(response => {
                            if (response.ok) {
                                document.getElementById('successModal').style.display = 'block';
                                // Redirect to vaccineList.jsp after 2 seconds
                                setTimeout(() => {
                                    window.location.href = 'vaccineList.jsp';
                                }, 2000);
                            } else {
                                throw new Error('Registration failed');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Có lỗi xảy ra khi đăng ký');
                        });
                return false;
            };


        </script>
    </body>


</html>