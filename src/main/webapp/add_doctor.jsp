<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Doctor</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body { background-color: #f8f9fa; }
        .form-container {
            background-color: #fff;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            border-radius: 10px;
            margin-top: 50px;
        }
        .btn-green {
            background-color: #28a745;
            border: none;
            color: white;
        }
        .btn-green:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

      <nav class="navbar navbar-expand-lg navbar-dark bg-success sticky-top">
          <div class="container">
              <a class="navbar-brand" href="index.jsp"><i class="fas fa-clinic-medical"></i> Clinic System</a>
              <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                  <span class="navbar-toggler-icon"></span>
              </button>
              <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                  <ul class="navbar-nav">
                      <li class="nav-item"><a class="nav-link active" href="index.jsp"><i class="fas fa-home"></i> Home</a></li>
                      <li class="nav-item"><a class="nav-link" href="doctors.jsp"><i class="fas fa-user-md"></i> Doctors</a></li>
                      <li class="nav-item"><a class="nav-link" href="appointments.jsp"><i class="fas fa-calendar-check"></i> Appointments</a></li>
                      <li class="nav-item"><a class="nav-link" href="about_Us.jsp"><i class="fas fa-info-circle"></i> About Us</a></li>
                      <li class="nav-item"><a class="nav-link" href="contact.jsp"><i class="fas fa-phone-alt"></i> Contact</a></li>
                  </ul>
              </div>
          </div>
      </nav>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="form-container">
                    <h2 class="text-center">Add New Doctor</h2>
                    <form id="doctorForm" action="DoctorServlet" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label>Name:</label>
                            <input type="text" name="name" id="name" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Age</label>
                            <input type="number" class="form-control" name="age" placeholder="Age" required>
                        </div>
                        <div class="form-group">
                            <label>Gender</label>
                            <select class="form-control" name="gender" required>
                                <option value="">Select Gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Specialization:</label>
                            <input type="text" name="specialization" id="specialization" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Experience:</label>
                            <input type="text" name="experience" id="experience" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Qualification:</label>
                            <input type="text" name="qualification" id="qualification" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Contact:</label>
                            <input type="text" name="contact" id="contact" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Email:</label>
                            <input type="email" name="email" id="email" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Address:</label>
                            <input type="text" name="address" id="address" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Availability:</label>
                            <input type="text" name="availability" id="availability" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Password:</label>
                            <input type="password" name="password" id="password" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Image:</label>
                            <input type="file" name="image_url" id="image_url" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-green btn-block">Submit</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        $("#doctorForm").submit(function(event) {
            event.preventDefault();

            var formData = new FormData(this); // includes file + all fields

            $.ajax({
                type: "POST",
                url: "DoctorServlet",
                data: formData,
                processData: false,   // don't let jQuery mess with FormData
                contentType: false,   // don't set Content-Type, browser will set it with boundary
                success: function(response) {
                    // ✅ handle success here
                    window.location.href = "doctors_dashboard.jsp?success=true";
                },
                error: function(xhr, status, error) {
                    console.error("Upload failed: " + error);
                    alert("Error uploading doctor info!");
                }
            });
        });

    </script>

    <footer class="footer text-white py-4 bg-success">
        <div class="container text-center">
            <p>&copy; 2026 Patient Appointment and Sheduling System. All Rights Reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
      <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>



</body>
</html>
