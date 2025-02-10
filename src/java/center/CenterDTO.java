package center;

public class CenterDTO {

    private int centerID;
    private String centerName;
    private String address;
    private String phoneNumber;
    private String email;
    private String operatingHours;
    private String description;
    
    public CenterDTO() {
    }
    
    public CenterDTO(int centerID, String centerName, String address, String phoneNumber, String email, String operatingHours, String description) {
        this.centerID = centerID;
        this.centerName = centerName;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.operatingHours = operatingHours;
        this.description = description;
    }

    // Getter và Setter
    public int getCenterID() {
        return centerID;
    }

    public void setCenterID(int centerID) {
        this.centerID = centerID;
    }

    public String getCenterName() {
        return centerName;
    }

    public void setCenterName(String centerName) {
        this.centerName = centerName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getOperatingHours() {
        return operatingHours;
    }

    public void setOperatingHours(String operatingHours) {
        this.operatingHours = operatingHours;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
