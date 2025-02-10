package appointment;

import java.util.Date;

public class AppointmentDTO {

    private int appointmentID;
    private int childID;
    private int centerID;
    private Date appointmentDate;
    private String serviceType;
    private String notificationStatus;
    private String status;

    public AppointmentDTO() {
    }

    public AppointmentDTO(int appointmentID, int childID, int centerID, Date appointmentDate, String serviceType, String notificationStatus, String status) {
        this.appointmentID = appointmentID;
        this.childID = childID;
        this.centerID = centerID;
        this.appointmentDate = appointmentDate;
        this.serviceType = serviceType;
        this.notificationStatus = notificationStatus;
        this.status = status;
    }

    // Getters and Setters
    public int getAppointmentID() {
        return appointmentID;
    }

    public void setAppointmentID(int appointmentID) {
        this.appointmentID = appointmentID;
    }

    public int getChildID() {
        return childID;
    }

    public void setChildID(int childID) {
        this.childID = childID;
    }

    public int getCenterID() {
        return centerID;
    }

    public void setCenterID(int centerID) {
        this.centerID = centerID;
    }

    public Date getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(Date appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    public String getServiceType() {
        return serviceType;
    }

    public void setServiceType(String serviceType) {
        this.serviceType = serviceType;
    }

    public String getNotificationStatus() {
        return notificationStatus;
    }

    public void setNotificationStatus(String notificationStatus) {
        this.notificationStatus = notificationStatus;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
