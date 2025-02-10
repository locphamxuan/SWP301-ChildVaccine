<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="customer.CustomerDTO"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Chỉnh Sửa Thông Tin</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            /* Copy base styles from profile.jsp */
            * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
            body { background-color: #f0f2f5; color: #333; line-height: 1.6; }
            .container { max-width: 1200px; margin: 0 auto; padding: 20px; }

            /* Hero section matching home page */
            .hero-section {
                background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
                    url('https://img.freepik.com/free-photo/doctor-getting-patient-ready-covid-vaccination_23-2149850142.jpg?w=2000');
                background-size: cover;
                background-position: center;
                padding: 100px 0;
                text-align: center;
                color: white;
                margin-bottom: 40px;
                border-radius: 15px;
            }

            /* Form specific styles */
            .edit-form {
                background: white;
                border-radius: 15px;
                padding: 30px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            }

            .form-group {
                margin-bottom: 25px;
            }

            .form-group label {
                display: block;
                margin-bottom: 10px;
                color: #333;
                font-weight: 500;
            }

            .form-control {
                width: 100%;
                padding: 12px 15px;
                border: 2px solid #e0e0e0;
                border-radius: 8px;
                font-size: 1em;
                transition: all 0.3s ease;
            }

            .form-control:focus {
                border-color: #1e88e5;
                outline: none;
                box-shadow: 0 0 0 3px rgba(30,136,229,0.1);
            }

            .btn-group {
                display: flex;
                gap: 15px;
                margin-top: 30px;
            }

            .btn {
                flex: 1;
                padding: 12px 20px;
                border: none;
                border-radius: 25px;
                font-size: 1em;
                font-weight: 500;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                transition: all 0.3s ease;
            }

            .btn-primary {
                background: #1e88e5;
                color: white;
            }

            .btn-secondary {
                background: #e0e0e0;
                color: #333;
            }

            .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            }

            .toast {
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 15px 25px;
                background: #4CAF50;
                color: white;
                border-radius: 8px;
                display: flex;
                align-items: center;
                gap: 10px;
                animation: slideIn 0.3s ease, fadeOut 0.3s ease 2s forwards;
                z-index: 1000;
            }

            @keyframes slideIn {
                from { transform: translateX(100%); opacity: 0; }
                to { transform: translateX(0); opacity: 1; }
            }

            @keyframes fadeOut {
                to { opacity: 0; visibility: hidden; }
            }
        </style>
    </head>
    <body>
        <%
            CustomerDTO user = (CustomerDTO) session.getAttribute("LOGIN_USER");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>

        <div class="container">
            <div class="hero-section">
                <h1>Chỉnh Sửa Thông Tin</h1>
                <p>Cập nhật thông tin tài khoản của bạn</p>
            </div>

            <div class="edit-form">
                <form id="editForm" action="EditProfileController" method="POST">
                    <input type="hidden" name="userID" value="<%= user.getUserID()%>">

                    <div class="form-group">
                        <label><i class="fas fa-user"></i> Họ và tên</label>
                        <input type="text" class="form-control" name="fullName" value="<%= user.getFullName()%>" required>
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-envelope"></i> Email</label>
                        <input type="email" class="form-control" name="email" value="<%= user.getEmail() != null ? user.getEmail() : ""%>">
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-phone"></i> Số điện thoại</label>
                        <input type="tel" class="form-control" name="phone" value="<%= user.getPhone() != null ? user.getPhone() : ""%>">
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-map-marker-alt"></i> Địa chỉ</label>
                        <input type="text" class="form-control" name="address" value="<%= user.getAddress() != null ? user.getAddress() : ""%>">
                    </div>

                    <div class="btn-group">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i>
                            Lưu thay đổi
                        </button>
                        <a href="profile.jsp" class="btn btn-secondary">
                            <i class="fas fa-times"></i>
                            Hủy
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <script>

            document.getElementById('editForm').addEventListener('submit', function (e) {
                e.preventDefault();

                const formData = new FormData(this);

                fetch('EditProfileController', {
                    method: 'POST',
                    body: formData
                })
                        .then(response => response.text())
                        .then(data => {
                            console.log('Server response:', data);

                            if (data === 'success') {
                                alert('Cập nhật thông tin thành công!');
                                window.location.href = 'profile.jsp';
                            } else {
                                throw new Error(data || 'Cập nhật thất bại');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Lỗi: ' + error.message);
                        });
            });
        </script>
    </body>
</html>