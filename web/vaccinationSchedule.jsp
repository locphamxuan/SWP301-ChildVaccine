<%@page import="vaccine.VaccineDTO"%>
<%@page import="vaccine.VaccineDAO"%>
<%@page import="child.ChildDAO"%>
<%@page import="child.ChildDTO"%>
<%@page import="java.util.List"%>
<%@page import="customer.CustomerDTO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Vaccination Schedule</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                background-color: #f0f2f5;
                color: #333;
                line-height: 1.6;
            }

            .hero-section {
                background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
                    url('https://img.freepik.com/free-photo/doctor-vaccinating-patient-clinic_23-2148880385.jpg?w=1380&t=st=1709825937~exp=1709826537~hmac=4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a4a');
                background-size: cover;
                background-position: center;
                padding: 100px 0;
                text-align: center;
                color: white;
                margin-bottom: 40px;
                border-radius: 15px;
            }

            .hero-content {
                max-width: 800px;
                margin: 0 auto;
                padding: 0 20px;
            }.hero-title {
                font-size: 3em;
                margin-bottom: 20px;
                font-weight: 700;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            }

            .hero-subtitle {
                font-size: 1.2em;
                margin-bottom: 30px;
                text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
            } .vaccine-card {
                background: white;
                border-radius: 15px;
                padding: 20px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .vaccine-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 5px;
                background: linear-gradient(90deg, #1e88e5, #1565c0);
            }

            .vaccine-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 8px 15px rgba(0,0,0,0.2);
            }

            .vaccine-image {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: 10px;
                margin-bottom: 15px;
            }

            .stats-section {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 20px;
                margin: 40px 0;
            }

            .stat-card {
                background: white;
                padding: 20px;
                border-radius: 10px;
                text-align: center;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .stat-number {
                font-size: 2em;
                font-weight: 700;
                color: #1e88e5;
                margin-bottom: 10px;
            }
            .stat-label {
                color: #666;
                font-size: 0.9em;
            }

            /* Cập nhật style cho search section */
            .search-section {
                background: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                margin-bottom: 40px;
            }

            .search-input {
                padding: 15px 25px;
                font-size: 1.1em;
                border: 2px solid #e0e0e0;
                border-radius: 30px;
            }

            .search-button {
                padding: 15px 30px;
                font-size: 1.1em;
                border-radius: 30px;
                background: linear-gradient(90deg, #1e88e5, #1565c0);
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }

            .nav-info-bar {
                background: white;
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-bottom: 20px;
                display: flex;
                justify-content: space-around;
                align-items: center;
            }

            .nav-info-item {
                display: flex;
                align-items: center;
                gap: 10px;
                padding: 0 20px;
            }

            .nav-info-item i {
                font-size: 24px;
                color: #1e88e5;
            }

            .info-content {
                display: flex;
                flex-direction: column;
            }

            .info-label {
                font-size: 0.9em;
                color: #666;
            }

            .info-value {
                font-weight: 500;
                color: #333;
            }

            .status-warning {
                color: #ff9800;
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .error {
                color: #f44336;
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .header {
                text-align: center;
                margin-bottom: 30px;
                padding: 20px;
                background: linear-gradient(135deg, #1e88e5, #1565c0);
                color: white;
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            }

            .search-section {
                margin-bottom: 30px;
            }

            .search-container {
                display: flex;
                gap: 10px;
                max-width: 600px;
                margin: 0 auto;
            }

            .search-input {
                flex: 1;
                padding: 12px 20px;
                border: 2px solid #e0e0e0;
                border-radius: 25px;
                font-size: 16px;
                transition: all 0.3s ease;
            }

            .search-input:focus {
                border-color: #1e88e5;
                outline: none;
            }

            .search-button {
                padding: 12px 30px;
                background: #1e88e5;
                color: white;
                border: none;
                border-radius: 25px;
                cursor: pointer;
                font-size: 16px;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .search-button:hover {
                background: #1565c0;
            }

            .vaccine-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 20px;
                margin-top: 20px;
            }

            .vaccine-card {
                background: white;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                transition: transform 0.3s ease;
            }

            .vaccine-card:hover {
                transform: translateY(-5px);
            }

            .vaccine-name {
                font-size: 1.2em;
                font-weight: 600;
                color: #1e88e5;
                margin-bottom: 10px;
            }

            .vaccine-info {
                margin-bottom: 15px;
            }

            .vaccine-info p {
                margin-bottom: 8px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .price {
                color: #2e7d32;
                font-weight: 500;
            }

            .recommended-age {
                color: #1565c0;
            }

            .book-button {
                width: 100%;
                padding: 12px;
                border: none;
                border-radius: 5px;
                background: #1e88e5;
                color: white;
                font-size: 16px;
                cursor: pointer;
                transition: background 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                text-decoration: none;
            }

            .book-button:hover {
                background: #1565c0;
            }

            .warning-button {
                background: #ff9800;
            }

            .warning-button:hover {
                background: #f57c00;
            }

            .success-message {
                background-color: #e8f5e9;
                color: #2e7d32;
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .error-message {
                background: #ffebee;
                color: #c62828;
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .welcome-message {
                display: flex;
                align-items: center;
                gap: 8px;
                color: white;
            }

            .login-button {
                padding: 8px 16px;
                background: rgba(255, 255, 255, 0.2);
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 8px;
                transition: all 0.3s ease;
            }

            .login-button:hover {
                background: rgba(255, 255, 255, 0.3);
            }

            .header-right {
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .no-results {
                text-align: center;
                padding: 40px;
                background: white;
                border-radius: 10px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .no-results i {
                font-size: 48px;
                color: #9e9e9e;
                margin-bottom: 10px;
            }

            .book-button {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                width: 100%;
                padding: 12px;
                background: #4CAF50;
                color: white;
                border: none;
                border-radius: 25px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                text-decoration: none;
                transition: all 0.3s ease;
            }

            .book-button:hover {
                background: #45a049;
                transform: translateY(-2px);
            }

            .book-button i {
                font-size: 18px;
            }

            .warning-button {
                background: #ff9800;
            }

            .warning-button:hover {
                background: #f57c00;
            }

            /* User Profile Dropdown */
            .user-profile {
                position: relative;
                display: inline-block;
            }

            .user-avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: #1e88e5;
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                transition: all 0.3s ease;
                border: 2px solid white;
            }

            .user-avatar:hover {
                transform: scale(1.05);
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }

            .profile-dropdown {
                position: absolute;
                top: 100%;
                right: 0;
                background: white;
                min-width: 250px;
                border-radius: 8px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                display: none;
                z-index: 1000;
                margin-top: 10px;
            }

            .profile-header {
                padding: 15px;
                border-bottom: 1px solid #eee;
                background: linear-gradient(135deg, #1e88e5, #1565c0);
                color: white;
                border-radius: 8px 8px 0 0;
            }

            .profile-header h4 {
                margin: 0;
                font-size: 1.1em;
            }

            .profile-header p {
                margin: 5px 0 0;
                font-size: 0.9em;
                opacity: 0.9;
            }

            .profile-menu {
                padding: 10px 0;
            }

            .profile-menu a {
                display: flex;
                align-items: center;
                padding: 12px 20px;
                color: #333;
                text-decoration: none;
                transition: all 0.3s ease;
            }

            .profile-menu a i {
                margin-right: 10px;
                width: 20px;
                text-align: center;
                color: #1e88e5;
            }

            .profile-menu a:hover {
                background: #f5f5f5;
                padding-left: 25px;
            }

            .profile-menu .logout {
                border-top: 1px solid #eee;
                margin-top: 5px;
                color: #dc3545;
            }

            .profile-menu .logout i {
                color: #dc3545;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="nav-info-bar">
                <div class="nav-info-item">
                    <i class="fas fa-hospital"></i>
                    <div class="info-content">
                        <span class="info-label">Trung tâm</span>
                        <span class="info-value">Trung tâm Y tế Vaccine</span>
                    </div>
                </div>

                <div class="nav-info-item">
                    <i class="fas fa-child"></i>
                    <div class="info-content">
                        <span class="info-label">Trẻ em</span>
                        <%
                            CustomerDTO loginUser = (CustomerDTO) session.getAttribute("LOGIN_USER");
                            boolean isLoggedIn = loginUser != null;
                            boolean hasChildren = false;
                            ChildDAO childDAO = new ChildDAO();

                            if (isLoggedIn) {
                                try {
                                    hasChildren = childDAO.hasChildren(Integer.parseInt(loginUser.getUserID()));
                                    if (hasChildren) {
                                        List<ChildDTO> children = childDAO.getChildrenByCustomerID(Integer.parseInt(loginUser.getUserID()));
                                        if (!children.isEmpty()) {
                        %>
                        <span class="info-value"><%= children.get(0).getFullName()%></span>
                        <%              }
                        } else { %>
                        <span class="info-value status-warning">
                            <i class="fas fa-exclamation-circle"></i> Chưa đăng ký
                        </span>
                        <%          }
                        } catch (Exception e) {
                            e.printStackTrace();
                        %>
                        <span class="info-value error">
                            <i class="fas fa-exclamation-triangle"></i> Lỗi
                        </span>
                        <%      }
                        } else { %>
                        <span class="info-value">
                            <i class="fas fa-user"></i> Khách
                        </span>
                        <% } %>
                    </div>
                </div>

                <div class="nav-info-item">
                    <i class="fas fa-calendar-check"></i>
                    <div class="info-content">
                        <span class="info-label">Lịch tiêm</span>
                        <span class="info-value">Theo dõi lịch tiêm</span>
                    </div>
                </div>
            </div>

            <div class="hero-section">
                <div class="hero-content">
                    <h1 class="hero-title">Bảo Vệ Sức Khỏe Tương Lai</h1>
                    <p class="hero-subtitle">Đặt lịch tiêm chủng an toàn và thuận tiện cho bé yêu của bạn</p>
                </div>
            </div>

            <div class="stats-section">
                <div class="stat-card">
                    <div class="stat-number">1000+</div>
                    <div class="stat-label">Khách Hàng Tin Tưởng</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">50+</div>
                    <div class="stat-label">Loại Vaccine</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">99%</div>
                    <div class="stat-label">Độ An Toàn</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">24/7</div>
                    <div class="stat-label">Hỗ Trợ Y Tế</div>
                </div>
            </div>

            <!-- Hiển thị thông báo thành công nếu có -->
            <%
                String successMessage = (String) request.getAttribute("SUCCESS_MESSAGE");
                if (successMessage != null) {
            %>
            <div class="success-message">
                <i class="fas fa-check-circle"></i>
                <%= successMessage%>
            </div>
            <% } %>

            <div class="header">
                <div style="display: flex; justify-content: space-between; align-items: center;">
                    <h1>Vaccination Schedule</h1>
                    <% if (isLoggedIn) {%>
                    <div class="user-profile">
                        <div class="user-avatar">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="profile-dropdown">
                            <div class="profile-header">
                                <h4><%= loginUser.getFullName()%></h4>
                                <p><%= loginUser.getEmail()%></p>
                            </div>
                            <div class="profile-menu">
                                <a href="profile.jsp">
                                    <i class="fas fa-user-circle"></i>
                                    Hồ sơ cá nhân
                                </a>

                                <div class="menu-item">
                                    <a href="childProfile.jsp" class="menu-link">
                                        <i class="fas fa-child"></i>
                                        Hồ sơ trẻ em
                                    </a>
                                </div>
                                <a href="appointmentHistory.jsp">
                                    <i class="fas fa-calendar-check"></i>
                                    Lịch sử tiêm chủng
                                </a>
                                <a href="MainController?action=Logout" class="logout">
                                    <i class="fas fa-sign-out-alt"></i>
                                    Đăng xuất
                                </a>
                            </div>
                        </div>
                    </div>
                    <% } else { %>
                    <a href="login.jsp" class="login-button">
                        <i class="fas fa-sign-in-alt"></i> Đăng nhập
                    </a>
                    <% }%>
                </div>
                <p>Find and schedule your vaccinations with ease</p>
            </div>

            <div class="search-section">
                <form action="VaccinationController" method="GET">
                    <div class="search-container">
                        <input type="text" 
                               name="search" 
                               class="search-input" 
                               placeholder="Search for vaccines..." 
                               value="<%= request.getParameter("search") != null ? request.getParameter("search") : ""%>">
                        <button type="submit" class="search-button">
                            <i class="fas fa-search"></i> Search
                        </button>
                    </div>
                </form>
            </div>

            <%
                VaccineDAO vaccineDAO = new VaccineDAO();
                List<VaccineDTO> vaccines = (List<VaccineDTO>) request.getAttribute("vaccines");

                try {
                    if (vaccines == null) {
                        String search = request.getParameter("search");
                        if (search != null && !search.trim().isEmpty()) {
                            vaccines = vaccineDAO.search(search);
                        } else {
                            vaccines = vaccineDAO.getAllVaccines();
                        }
                    }
            %>

            <% if (vaccines != null && !vaccines.isEmpty()) { %>
            <div class="vaccine-grid">
                <% for (VaccineDTO vaccine : vaccines) {%>
                <div class="vaccine-card">
                    <img src="https://img.freepik.com/free-photo/vaccine-bottles-arrangement_23-2149079681.jpg?w=1380&t=st=1709826012~exp=1709826612~hmac=8a8a8a8a8a8a8a8a8a8a8a8a8a8a8a8a8a8a8a8a8a8a8a8a8a8a8a8a8a8a8a" 
                         alt="Vaccine Image" 
                         class="vaccine-image">
                    <div class="vaccine-name">
                        <%= vaccine.getVaccineName()%>
                    </div>
                    <div class="vaccine-info">
                        <p><%= vaccine.getDescription()%></p>
                        <p class="price">
                            <i class="fas fa-tag"></i>
                            <%= String.format("%,.0f VND", vaccine.getPrice())%>
                        </p>
                        <p class="recommended-age">
                            <i class="fas fa-user-clock"></i>
                            <%= vaccine.getRecommendedAge()%>
                        </p>
                    </div>
                    <% if (isLoggedIn) { %>
                    <% if (hasChildren) {%>
                    <a href="MainController?action=ShowAppointmentForm&vaccineId=<%= vaccine.getVaccineID()%>" class="book-button">
                        <i class="fas fa-calendar-plus"></i> Buy Now
                    </a>
                    <% } else {%>
                    <a href="MainController?action=ShowAddChild&vaccineId=<%= vaccine.getVaccineID()%>" class="book-button warning-button">
                        <i class="fas fa-user-plus"></i> Đăng ký thông tin trẻ em
                    </a>
                    <% } %>

                    <% } else {%>  
                    <a href="login.jsp" class="book-button">
                        <i class="fas fa-shopping-cart"></i> Mua ngay
                    </a>
                    <% } %>





                </div>
                <% } %>
            </div>
            <% } else { %>
            <div class="no-results" style="text-align: center; padding: 40px; background: white; border-radius: 10px; margin-top: 20px;">
                <i class="fas fa-search" style="font-size: 48px; color: #ccc; margin-bottom: 20px;"></i>
                <p style="font-size: 18px; color: #666;">Không tìm thấy vaccine phù hợp với từ khóa của bạn</p>
                <p style="font-size: 14px; color: #888; margin-top: 10px;">Vui lòng thử lại với từ khóa khác</p>
                <a href="vaccinationSchedule.jsp" class="search-button" style="display: inline-block; margin-top: 20px; text-decoration: none;">
                    <i class="fas fa-redo"></i> Xem tất cả vaccine
                </a>
            </div>
            <% } %>

            <%
            } catch (Exception e) {
                e.printStackTrace();
            %>
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i>
                <p>An error occurred while loading vaccines. Please try again later.</p>
            </div>
            <%  }%>



        </div>

        <script>
            function redirectToLogin() {
                window.location.href = 'login.jsp';
            }

            document.addEventListener('DOMContentLoaded', function () {
                const userAvatar = document.querySelector('.user-avatar');
                const profileDropdown = document.querySelector('.profile-dropdown');

                if (userAvatar) {
                    userAvatar.addEventListener('click', function (e) {
                        e.stopPropagation();
                        profileDropdown.style.display =
                                profileDropdown.style.display === 'block' ? 'none' : 'block';
                    });

                    document.addEventListener('click', function (e) {
                        if (!profileDropdown.contains(e.target)) {
                            profileDropdown.style.display = 'none';
                        }
                    });
                }
            });
        </script>
    </body>
</html>