package com.clinic.model;
public class Doctor {
    private int id;
    private String name;
    private String specialization;
    private String experience;
    private String qualification;
    private String contact;
    private String email;
    private String address;
    private String availability;

    // Constructor
    public Doctor() {}

    public Doctor(int id, String name, String specialization, String experience, String qualification,
                  String contact, String email, String address, String availability) {
        this.id = id;
        this.name = name;
        this.specialization = specialization;
        this.experience = experience;
        this.qualification = qualification;
        this.contact = contact;
        this.email = email;
        this.address = address;
        this.availability = availability;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getSpecialization() { return specialization; }
    public void setSpecialization(String specialization) { this.specialization = specialization; }

    public String getExperience() { return experience; }
    public void setExperience(String experience) { this.experience = experience; }

    public String getQualification() { return qualification; }
    public void setQualification(String qualification) { this.qualification = qualification; }

    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getAvailability() { return availability; }
    public void setAvailability(String availability) { this.availability = availability; }

    // Override toString() for debugging
    @Override
    public String toString() {
        return "Doctor [id=" + id + ", name=" + name + ", specialization=" + specialization +
                ", experience=" + experience + ", qualification=" + qualification + ", contact=" + contact +
                ", email=" + email + ", address=" + address + ", availability=" + availability + "]";
    }
}
