package com.clinic.model;

public class User {
    private int id; // Add user ID
    private String fullname;
    private int age;
    private String address;
    private String gender;
    private String contact;
    private String email;
    private String password;
    private String role;

    // Constructor for new users (without ID)
    public User(String fullname, int age, String address, String gender, String contact, String email, String password, String role) {
        this.fullname = fullname;
        this.age = age;
        this.address = address;
        this.gender = gender;
        this.contact = contact;
        this.email = email;
        this.password = password;
        this.role = role;
    }

    // Constructor for existing users (with ID) - Needed for updates
    public User(int id, String fullname, int age, String address, String gender, String contact, String email, String password, String role) {
        this.id = id;
        this.fullname = fullname;
        this.age = age;
        this.address = address;
        this.gender = gender;
        this.contact = contact;
        this.email = email;
        this.password = password;
        this.role = role;
    }

    // Getters and Setters

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    @Override
    public String toString() {
        return "User [id=" + id + ", fullname=" + fullname + ", age=" + age + ", address=" + address + ", gender=" + gender
                + ", contact=" + contact + ", email=" + email + ", password=" + password + ", role=" + role + "]";
    }
}
