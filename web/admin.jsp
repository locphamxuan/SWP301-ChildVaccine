<%@page import="customer.CustomerDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="customer.CustomerDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Admin Dashboard - Vaccine Management</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
            }

            body {
                background-color: #f0f2f5;
                color: #333;
                line-height: 1.6;
            }

            .hero-section {
                background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
                    url('https://img.freepik.com/free-photo/medical-banner-with-doctor-working-laptop_23-2149611193.jpg?w=2000');
                background-size: cover;
                background-position: center;
                padding: 60px 0;
                text-align: center;
                color: white;
                margin-bottom: 40px;
                border-radius: 0 0 20px 20px;
            }

            .navbar {
                background: white;
                padding: 1rem 2rem;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                display: flex;
                justify-content: space-between;
                align-items: center;
                position: sticky;
                top: 0;
                z-index: 1000;
            }

            .welcome-message {
                display: flex;
                align-items: center;
                gap: 10px;
                font-weight: 500;
            }

            .welcome-message i {
                color: #1e88e5;
            }

            .dashboard-title {
                font-size: 2.5em;
                margin-bottom: 15px;
                font-weight: 700;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            }

            .dashboard-subtitle {
                font-size: 1.1em;
                opacity: 0.9;
            }

            .main-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
            }

            .search-box {
                background: white;
                padding: 25px;
                border-radius: 15px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .search-form {
                display: flex;
                gap: 15px;
            }

            .search-input {
                flex: 1;
                padding: 12px 20px;
                border: 2px solid #e0e0e0;
                border-radius: 10px;
                font-size: 1em;
                transition: all 0.3s ease;
            }

            .search-input:focus {
                border-color: #1e88e5;
                outline: none;
                box-shadow: 0 0 0 3px rgba(30,136,229,0.1);
            }

            .search-button {
                padding: 12px 25px;
                background: #1e88e5;
                color: white;
                border: none;
                border-radius: 10px;
                cursor: pointer;
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 8px;
                transition: all 0.3s ease;
            }

            .search-button:hover {
                background: #1565c0;
                transform: translateY(-2px);
            }

            .users-table {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            }

            .users-table table {
                width: 100%;
                border-collapse: collapse;
            }

            .users-table th {
                background: #1e88e5;
                color: white;
                padding: 15px;
                text-align: left;
                font-weight: 500;
            }

            .users-table td {
                padding: 15px;
                border-bottom: 1px solid #eee;
            }

            .users-table tr:last-child td {
                border-bottom: none;
            }

            .users-table tr:hover {
                background: #f8f9fa;
            }

            .action-buttons {
                display: flex;
                gap: 10px;
            }

            .action-button {
                padding: 8px 15px;
                border-radius: 8px;
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 5px;
                font-size: 0.9em;
                transition: all 0.3s ease;
            }

            .edit-button {
                background: #4CAF50;
                color: white;
            }

            .delete-button {
                background: #f44336;
                color: white;
            }

            .action-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .logout-button {
                padding: 10px 20px;
                background: #f44336;
                color: white;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 8px;
                transition: all 0.3s ease;
            }

            .logout-button:hover {
                background: #d32f2f;
                transform: translateY(-2px);
            }

            .no-results {
                text-align: center;
                padding: 40px;
                color: #666;
            }

            .no-results i {
                font-size: 48px;
                color: #ccc;
                margin-bottom: 15px;
            }

            /* Modal styles */
            .modal-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                z-index: 1000;
                animation: fadeIn 0.3s ease;
            }

            .modal-container {
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: white;
                padding: 30px;
                border-radius: 15px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.1);
                width: 90%;
                max-width: 400px;
                text-align: center;
                z-index: 1001;
                animation: slideIn 0.3s ease;
            }
            .modal-icon {
                font-size: 48px;
                color: #f44336;
                margin-bottom: 20px;
            }

            .modal-title {
                font-size: 1.5em;
                color: #333;
                margin-bottom: 10px;
                font-weight: 600;
            }

            .modal-message {
                color: #666;
                margin-bottom: 25px;
                font-size: 1.1em;
            }

            .modal-buttons {
                display: flex;
                justify-content: center;
                gap: 15px;
            }

            .modal-button {
                padding: 12px 25px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .confirm-button {
                background: #f44336;
                color: white;
            }

            .confirm-button:hover {
                background: #d32f2f;
                transform: translateY(-2px);
            }

            .cancel-button {
                background: #e0e0e0;
                color: #333;
            }

            .cancel-button:hover {
                background: #d5d5d5;
                transform: translateY(-2px);
            }

            @keyframes fadeIn {
                from { opacity: 0; }
                to { opacity: 1; }
            }

            @keyframes slideIn {
                from { 
                    opacity: 0;
                    transform: translate(-50%, -60%);
                }
                to { 
                    opacity: 1;
                    transform: translate(-50%, -50%);
                }
            }
        </style>
    </head>
    <body>
        <%
            // Kiểm tra đăng nhập
            CustomerDTO loginUser = (CustomerDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null || !"AD".equals(loginUser.getRoleID())) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Lấy danh sách users từ session
            List<CustomerDTO> list = (List<CustomerDTO>) session.getAttribute("LIST_USER");
            if (list == null) {
                CustomerDAO dao = new CustomerDAO();
                list = dao.getListUser();
                session.setAttribute("LIST_USER", list);
            }
        %>

        <!-- Navbar -->
        <nav class="navbar">
            <div class="welcome-message">
                <i class="fas fa-user-shield"></i>
                Welcome, <%= loginUser.getFullName()%>
            </div>
            <form action="MainController" method="POST">
                <button type="submit" name="action" value="Logout" class="logout-button">
                    <i class="fas fa-sign-out-alt"></i>
                    Logout</button>
            </form>
        </nav>

        <!-- Hero Section -->
        <div class="hero-section">
            <h1 class="dashboard-title">Admin Dashboard</h1>
            <p class="dashboard-subtitle">Manage users and system settings</p>
        </div>

        <!-- Main Content -->
        <div class="main-container">
            <!-- Search Box -->
            <div class="search-box">
                <form action="MainController" method="POST" class="search-form">
                    <input type="text" 
                           name="search" 
                           class="search-input"
                           value="<%= request.getParameter("search") != null ? request.getParameter("search") : ""%>"
                           placeholder="Search users by name...">
                    <button type="submit" name="action" value="Search" class="search-button">
                        <i class="fas fa-search"></i>
                        Search
                    </button>
                </form>
            </div>

            <!-- Users Table -->
            <div class="users-table"> <table>
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>User ID</th>
                            <th>Full Name</th>
                            <th>Role</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (list != null && !list.isEmpty()) {
                                int count = 1;
                                for (CustomerDTO user : list) {
                        %>
                        <tr>
                            <td><%= count++%></td>
                            <td><%= user.getUserID()%></td>
                            <td><%= user.getFullName()%></td>
                            <td>
                                <span class="role-badge <%= user.getRoleID().equals("AD") ? "admin" : "user"%>">
                                    <%= user.getRoleID()%>
                                </span>
                            </td>
                            <td><%= user.getEmail()%></td>
                            <td><%= user.getPhone()%></td>
                            <td> <div class="action-buttons">
                                    <a href="editUser.jsp?userID=<%= user.getUserID()%>" 
                                       class="action-button edit-button">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <a href="MainController?action=Delete&userID=<%= user.getUserID()%>" 
                                       class="action-button delete-button">
                                        <i class="fas fa-trash-alt"></i> Delete
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="7" class="no-results">
                                <i class="fas fa-search"></i>
                                <p>No users found</p>
                                <p style="font-size: 0.9em; color: #888;">Try different search terms</p>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->  
        <div id="deleteModal" class="modal-overlay">
            <div class="modal-container">
                <div class="modal-icon">
                    <i class="fas fa-exclamation-circle"></i>
                </div>
                <h2 class="modal-title">Xác nhận xóa</h2>
                <p class="modal-message">Bạn có chắc chắn muốn xóa người dùng này?</p>
                <div class="modal-buttons">
                    <button id="confirmDelete" class="modal-button confirm-button">
                        <i class="fas fa-trash-alt"></i> Xóa
                    </button>
                    <button id="cancelDelete" class="modal-button cancel-button">
                        <i class="fas fa-times"></i> Hủy
                    </button>
                </div>
            </div>
        </div>
        <script>
            let userIdToDelete = null;

            function showDeleteConfirmation(userId) {
                userIdToDelete = userId;
                document.getElementById('deleteModal').style.display = 'block';
                document.body.style.overflow = 'hidden';
            }

            document.getElementById('cancelDelete').addEventListener('click', function () {
                document.getElementById('deleteModal').style.display = 'none';
                document.body.style.overflow = 'auto';
                userIdToDelete = null;
            });

            document.getElementById('confirmDelete').addEventListener('click', function () {
                if (userIdToDelete) {
                    window.location.href = 'MainController?action=Delete&userID=' + userIdToDelete;
                }
            });

            // Sửa lại onclick của nút delete
            document.querySelectorAll('.delete-button').forEach(button => {
                button.onclick = function (e) {
                    e.preventDefault();
                    const userId = this.getAttribute('href').split('userID=')[1];
                    showDeleteConfirmation(userId);
                };
            });
        </script>
    </body>
</html>