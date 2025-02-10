<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="child.ChildDTO"%>
<%@page import="child.ChildDAO"%>
<%@page import="customer.CustomerDTO"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hồ Sơ Trẻ Em</title>
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
                color: #333;
                line-height: 1.6;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }

            .hero-section {
                background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
                    url('https://img.freepik.com/free-photo/doctor-vaccinating-patient-clinic_23-2148880385.jpg?w=1380');
                background-size: cover;
                background-position: center;
                padding: 100px 0;
                text-align: center;
                color: white;
                margin-bottom: 40px;
                border-radius: 15px;
            }

            .hero-title {
                font-size: 2.5em;
                margin-bottom: 20px;
            }

            .children-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 20px;
                margin-top: 30px;
            }

            .child-card {
                background: white;
                border-radius: 15px;
                padding: 25px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                transition: transform 0.3s ease;
            }

            .child-card:hover {
                transform: translateY(-5px);
            }

            .child-avatar {
                width: 80px;
                height: 80px;
                background: #1e88e5;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 20px;
            }

            .child-avatar i {
                font-size: 40px;
                color: white;
            }

            .child-info {
                text-align: center;
            }

            .child-name {
                font-size: 1.5em;
                color: #1e88e5;
                margin-bottom: 15px;
                font-weight: 600;
            }

            .info-item {
                display: flex;
                align-items: center;
                margin: 10px 0;
                padding: 10px;
                background: #f8f9fa;
                border-radius: 8px;
            }

            .info-item i {
                margin-right: 10px;
                color: #1e88e5;
                width: 20px;
            }

            .add-child-button {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
                padding: 15px 30px;
                background: #4CAF50;
                color: white;
                border: none;
                border-radius: 25px;
                font-size: 1.1em;
                text-decoration: none;
                margin-top: 20px;
                transition: all 0.3s ease;
            }

            .add-child-button:hover {
                background: #45a049;
                transform: translateY(-2px);
            }
        </style>
    </head>
    <body>
        <%
            CustomerDTO loginUser = (CustomerDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            ChildDAO childDAO = new ChildDAO();
            List<ChildDTO> children = null;

            try {
                // Debug logs
                System.out.println("Debug - Login User Info:");
                System.out.println("UserID: " + loginUser.getUserID());
                System.out.println("Full Name: " + loginUser.getFullName());

                String userID = loginUser.getUserID();
                children = childDAO.getAllChildrenByUserID(userID);

                // Debug log results
                if (children != null) {
                    System.out.println("Found " + children.size() + " children");
                    for (ChildDTO child : children) {
                        System.out.println("Child: " + child.getFullName() + ", DOB: " + child.getDateOfBirth());
                    }
                } else {
                    System.out.println("No children found or list is null");
                }

            } catch (Exception e) {
                System.out.println("Error in JSP: " + e.getMessage());
                e.printStackTrace();
            }
        %>

        <div class="container">
            <div class="hero-section">

                <h1 class="hero-title">Hồ Sơ Trẻ Em</h1>
                <p>Quản lý thông tin trẻ em của bạn</p>
            </div>

            <div class="children-grid">
                <% if (children != null && !children.isEmpty()) {
                        for (ChildDTO child : children) {
                            // Debug log
                            System.out.println("Displaying child: " + child.getFullName());
                %>



                <div id="editModal" class="modal" style="display: none;">
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <h2>Chỉnh Sửa Thông Tin</h2>
                        <form id="editForm">
                            <input type="hidden" id="editChildID" name="childID">
                            <div class="form-group">
                                <label>Họ và tên</label>
                                <input type="text" id="editFullName" name="fullName" required>
                            </div>
                            <div class="form-group">
                                <label>Ngày sinh</label>
                                <input type="date" id="editDateOfBirth" name="dateOfBirth" required>
                            </div>
                            <div class="form-group">
                                <label>Giới tính</label>
                                <select id="editGender" name="gender" required>
                                    <option value="Nam">Nam</option>
                                    <option value="Nữ">Nữ</option>
                                </select>
                            </div>
                            <button type="submit" class="btn-save">Lưu thay đổi</button>
                        </form>
                    </div>
                </div>

                <div class="child-card">
                    <div class="child-avatar">
                        <i class="fas fa-child"></i>
                        <button onclick="openEditModal(<%=child.getChildID()%>,
                                        '<%=child.getFullName()%>',
                                        '<%=child.getDateOfBirth()%>',
                                        '<%=child.getGender()%>')" 
                                class="btn-edit">
                            <i class="fas fa-edit"></i> Chỉnh sửa
                        </button>
                    </div>
                    <div class="child-info">
                        <div class="child-name"><%= child.getFullName()%></div>
                        <div class="info-item">
                            <i class="fas fa-birthday-cake"></i>
                            <span>Ngày sinh: <%= child.getDateOfBirth()%></span>
                        </div>
                        <div class="info-item">
                            <i class="fas fa-venus-mars"></i>
                            <span>Giới tính: <%= child.getGender()%></span>
                        </div>
                    </div>
                </div>
                <% }
                } else {
                    System.out.println("No children to display");

                %>
                <div style="text-align: center; grid-column: 1 / -1;">
                    <div class="child-card">
                        <i class="fas fa-child" style="font-size: 48px; color: #ccc; margin-bottom: 20px;"></i>
                        <p>Chưa có thông tin trẻ em</p>
                        <a href="childRegistration.jsp" class="add-child-button">
                            <i class="fas fa-plus"></i>
                            Thêm thông tin trẻ em
                        </a>
                    </div>
                </div>
                <% }%>
            </div>
        </div>
    </body>
</html>