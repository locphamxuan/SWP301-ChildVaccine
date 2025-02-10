package registration;

import java.sql.Date;
import java.util.List;

public class RegistrationDTO {
    private int registrationID;
    private String childName;
    private Date dateOfBirth;
    private String gender;
    private String parentName;
    private String parentPhone;
    private Date appointmentDate;
    private String appointmentTime;
    private String status;
    private Date createdDate;
    private List<Integer> selectedVaccines;
    private double totalAmount;

    public RegistrationDTO() {
    }

    public RegistrationDTO(int registrationID, String childName, Date dateOfBirth, 
            String gender, String parentName, String parentPhone, 
            Date appointmentDate, String appointmentTime, String status) {
        this.registrationID = registrationID;
        this.childName = childName;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.parentName = parentName;
        this.parentPhone = parentPhone;
        this.appointmentDate = appointmentDate;
        this.appointmentTime = appointmentTime;
        this.status = status;
    }

    // Getters and Setters

    public int getRegistrationID() {
        return registrationID;
    }

    public void setRegistrationID(int registrationID) {
        this.registrationID = registrationID;
    }

    public String getChildName() {
        return childName;
    }

    public void setChildName(String childName) {
        this.childName = childName;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public String getParentPhone() {
        return parentPhone;
    }

    public void setParentPhone(String parentPhone) {
        this.parentPhone = parentPhone;
    }

    public Date getAppointmentDate() {
        return appointmentDate;
    }

    public void setAppointmentDate(Date appointmentDate) {
        this.appointmentDate = appointmentDate;
    }

    public String getAppointmentTime() {
        return appointmentTime;
    }

    public void setAppointmentTime(String appointmentTime) {
        this.appointmentTime = appointmentTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public List<Integer> getSelectedVaccines() {
        return selectedVaccines;
    }

    public void setSelectedVaccines(List<Integer> selectedVaccines) {
        this.selectedVaccines = selectedVaccines;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
   
}
    
