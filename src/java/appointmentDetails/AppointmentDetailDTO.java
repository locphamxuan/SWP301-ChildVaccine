/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package appointmentDetails;

/**
 *
 * @author Windows
 */
public class AppointmentDetailDTO {
    private int appointmentDetailID;
    private int appointmentID;
    private int vaccineID;
    private int doseNumber;

    public AppointmentDetailDTO() {
    }

    public AppointmentDetailDTO(int appointmentDetailID, int appointmentID, int vaccineID, int doseNumber) {
        this.appointmentDetailID = appointmentDetailID;
        this.appointmentID = appointmentID;
        this.vaccineID = vaccineID;
        this.doseNumber = doseNumber;
    }

    // Getters and Setters

    public int getAppointmentDetailID() {
        return appointmentDetailID;
    }

    public void setAppointmentDetailID(int appointmentDetailID) {
        this.appointmentDetailID = appointmentDetailID;
    }

    public int getAppointmentID() {
        return appointmentID;
    }

    public void setAppointmentID(int appointmentID) {
        this.appointmentID = appointmentID;
    }

    public int getVaccineID() {
        return vaccineID;
    }

    public void setVaccineID(int vaccineID) {
        this.vaccineID = vaccineID;
    }

    public int getDoseNumber() {
        return doseNumber;
    }

    public void setDoseNumber(int doseNumber) {
        this.doseNumber = doseNumber;
    }
    
}

