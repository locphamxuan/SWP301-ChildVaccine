<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Schedule a Vaccination</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                display: block;
                margin-bottom: 5px;
            }
            input, select {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
            }
            button {
                padding: 10px 20px;
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
            }
            button:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <h1>Schedule a Vaccination</h1>

        <form action="MainController" method="post">
            <!-- Hiển thị thông tin trẻ em đã chọn -->
            <h2>Child Information:</h2>
            <p>Name: ${sessionScope.SELECTED_CHILD.fullName}</p>
            <p>Date of Birth: ${sessionScope.SELECTED_CHILD.dateOfBirth}</p>
            <p>Gender: ${sessionScope.SELECTED_CHILD.gender}</p>
            
            <input type="hidden" name="childID" value="${sessionScope.SELECTED_CHILD.childID}">
            <input type="hidden" name="vaccineId" value="${sessionScope.VACCINE_ID}">

            <div class="form-group">
                <label for="centerID">Vaccination Center:</label>
                <select id="centerID" name="centerID" required>
                    <option value="1">VNVC Ha Noi</option>
                    <option value="2">VNVC Ho Chi Minh</option>
                </select>
            </div>

            <div class="form-group">
                <label for="appointmentDate">Appointment date:</label>
                <input type="date" id="appointmentDate" name="appointmentDate" required>
            </div>

            <div class="form-group">
                <label for="serviceType">Service Type:</label>
                <select id="serviceType" name="serviceType" required>
                    <option value="Tiêm lẻ">Retail Injection (Tiem Le)</option>
                    <option value="Trọn gói">All Inclusive (Tron Goi)</option>
                    <option value="Cá thể hóa">Individualization (Ca Nhan Hoa)</option>
                </select>
            </div>

            <input type="hidden" name="action" value="BookAppointment">
            <button type="submit">Book Appointment</button>
        </form>
    </body>
</html>