<%@page import="registration.RegistrationDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thanh toán</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                background-color: #f5f6f7;
                min-height: 100vh;
            }

            .container {
                max-width: 1000px;
                margin: 40px auto;
                padding: 0 20px;
            }

            .payment-header {
                text-align: center;
                margin-bottom: 40px;
                color: #0854a0;
            }

            .payment-header h1 {
                font-size: 2.5em;
                margin-bottom: 10px;
            }

            .payment-header p {
                color: #666;
                font-size: 1.1em;
            }

            .payment-summary {
                background: white;
                border-radius: 10px;
                padding: 30px;
                margin-bottom: 30px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .summary-title {
                font-size: 1.3em;
                color: #0854a0;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 2px solid #eee;
            }

            .summary-item {
                display: flex;
                justify-content: space-between;
                padding: 15px 0;
                border-bottom: 1px solid #eee;
            }

            .summary-item:last-child {
                border-bottom: none;
                font-weight: bold;
            }

            .payment-methods {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .payment-method {
                background: white;
                border-radius: 10px;
                padding: 25px;
                text-align: center;
                cursor: pointer;
                transition: all 0.3s ease;
                border: 2px solid #eee;
                position: relative;
            }

            .payment-method:hover {
                transform: translateY(-5px);
                border-color: #0854a0;
            }

            .payment-method.selected {
                border-color: #0854a0;
                background: #f8fbff;
            }

            .payment-method i {
                font-size: 2.5em;
                color: #0854a0;
                margin-bottom: 15px;
            }

            .payment-method h3 {
                color: #333;
                margin-bottom: 10px;
            }

            .payment-method p {
                color: #666;
                font-size: 0.9em;
            }

            .payment-details {
                background: white;
                border-radius: 10px;
                padding: 30px;
                margin-top: 20px;
                display: none;
            }

            .btn-confirm {
                background: #0854a0;
                color: white;
                border: none;
                padding: 15px 30px;
                border-radius: 5px;
                font-size: 1.1em;
                cursor: pointer;
                width: 100%;
                margin-top: 20px;
                transition: background 0.3s;
            }

            .btn-confirm:hover {
                background: #063a75;
            }

            .back-link {
                text-align: center;
                margin-top: 20px;
            }

            .back-link a {
                color: #666;
                text-decoration: none;
            }

            .back-link a:hover {
                color: #0854a0;
            }

            @media (max-width: 768px) {
                .container {
                    margin: 20px auto;
                }

                .payment-methods {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="payment-header">
                <h1>Thanh toán</h1>
                <p>Vui lòng chọn phương thức thanh toán phù hợp</p>
            </div>

            <div class="payment-summary">
                <h2 class="summary-title">
                    <i class="fas fa-receipt"></i> Thông tin đơn hàng
                </h2>
                <div class="summary-item">
                    <span>Mã đăng ký:</span>
                    <span>#${param.registrationId}</span>
                </div>
                <div class="summary-item">
                    <span>Tên trẻ:</span>
                    <span>${registration.childName}</span>
                </div>
                <div class="summary-item">
                    <span>Ngày tiêm:</span>
                    <span>${registration.appointmentDate}</span>
                </div>
                <div class="summary-item">
                    <span>Thời gian:</span>
                    <span>${registration.appointmentTime}</span>
                </div>
                <div class="summary-item">
                    <span>Tổng tiền:</span>
                    <span class="total-amount">${registration.totalAmount} VNĐ</span>
                </div>
            </div>

            <div class="payment-methods">
                <div class="payment-method" onclick="selectPayment('momo')">
                    <i class="fas fa-wallet"></i>
                    <h3>Ví MoMo</h3>
                    <p>Thanh toán nhanh chóng qua ví điện tử MoMo</p>
                </div>

                <div class="payment-method" onclick="selectPayment('bank')">
                    <i class="fas fa-university"></i>
                    <h3>Chuyển khoản</h3>
                    <p>Chuyển khoản qua tài khoản ngân hàng</p>
                </div>

                <div class="payment-method" onclick="selectPayment('cash')">
                    <i class="fas fa-money-bill-wave"></i>
                    <h3>Tiền mặt</h3>
                    <p>Thanh toán trực tiếp tại phòng khám</p>
                </div>
            </div>

            <div id="paymentDetails" class="payment-details">
                <!-- Chi tiết thanh toán sẽ được thêm bằng JavaScript -->
            </div>

            <button class="btn-confirm" onclick="confirmPayment()">
                <i class="fas fa-check-circle"></i> Xác nhận thanh toán
            </button>

            <div class="back-link">
                <a href="javascript:history.back()">
                    <i class="fas fa-arrow-left"></i> Quay lại
                </a>
            </div>
        </div>

        <%
            // Lấy thông tin từ session
            RegistrationDTO registration = (RegistrationDTO) session.getAttribute("REGISTRATION_INFO");
            Integer registrationId = (Integer) session.getAttribute("REGISTRATION_ID");

            // Nếu không có thông tin, redirect về trang chủ
            if (registration == null || registrationId == null) {
                response.sendRedirect("home.jsp");
                return;
            }
        %>

        <!-- Hiển thị thông tin -->
        <div class="summary-item">
            <span>Mã đăng ký:</span>
            <span>#<%= registrationId%></span>
        </div>
        <div class="summary-item">
            <span>Tên trẻ:</span>
            <span><%= registration.getChildName()%></span>
        </div>

        <script>
            let selectedMethod = '';

            function selectPayment(method) {
                selectedMethod = method;

                // Remove selected class from all methods
                document.querySelectorAll('.payment-method').forEach(el => {
                    el.classList.remove('selected');
                });

                // Add selected class to clicked method
                event.currentTarget.classList.add('selected');

                const detailsDiv = document.getElementById('paymentDetails');
                detailsDiv.style.display = 'block';

                // Show different content based on payment method
                switch (method) {
                    case 'momo':
                        detailsDiv.innerHTML = `
                            <h3>Thanh toán qua MoMo</h3>
                            <p>Quét mã QR bên dưới để thanh toán:</p>
                            <img src="path/to/qr-code.png" alt="MoMo QR Code">
                        `;
                        break;

                    case 'bank':
                        detailsDiv.innerHTML = `
                            <h3>Thông tin chuyển khoản</h3>
                            <p>Ngân hàng: VietComBank</p>
                            <p>Số tài khoản: 1234567890</p>
                            <p>Chủ tài khoản: CÔNG TY VACCINE</p>
                            <p>Nội dung: TIEM${param.registrationId}</p>
                        `;
                        break;

                    case 'cash':
                        detailsDiv.innerHTML = `
                            <h3>Thanh toán tiền mặt</h3>
                            <p>Vui lòng thanh toán trực tiếp tại phòng khám trước khi tiêm.</p>
                            <p>Địa chỉ: 123 Đường ABC, Quận XYZ, TP.HCM</p>
                        `;
                        break;
                }
            }

            function confirmPayment() {
                if (!selectedMethod) {
                    alert('Vui lòng chọn phương thức thanh toán');
                    return;
                }

                // Gửi thông tin thanh toán lên server
                fetch('PaymentController', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: `method=${selectedMethod}&registrationId=${param.registrationId}`
                })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                alert('Thanh toán thành công!');
                                window.location.href = 'confirmation.jsp';
                            } else {
                                alert('Có lỗi xảy ra: ' + data.message);
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Có lỗi xảy ra khi xử lý thanh toán');
                        });
            }
        </script>
    </body>
</html>