# AutoCare – Progress Tracker

Tracking project milestones across the four phases of development.

---

## 📌 Phase 1: Environment & Project Setup
- [x] Define project scope, requirements, and problem statement
- [x] Create project documentation (`README.md`, `Project overview.md`, `Architecture.md`, `Progress tracker.md`)
- [x] Establish directory hierarchy (`src/main/webapp/`, `src/main/java/com/autocare/`, `database/`)
- [x] Design relational database schema (`database/schema.sql`)
- [ ] Configure local Apache Tomcat development server
- [ ] Setup MySQL database instance and verify JDBC driver connectivity
- [ ] Establish base JDBC utility class (`DBConnection.java`)

---

## 🎨 Phase 2: Frontend Development
- [ ] **Landing Page (`index.html`)**
  - [x] Hero section, service highlights, and modern responsive navigation
  - [ ] Customer testimonials and contact/footer sections
- [ ] **Authentication & Onboarding Pages**
  - [ ] User Login page (Customer / Staff / Admin login forms)
  - [ ] User Registration page for new vehicle owners
- [ ] **Customer Portal**
  - [ ] Customer dashboard overview
  - [ ] "My Vehicles" management interface (add, edit, list vehicles)
  - [ ] Service appointment booking form with package selector
  - [ ] Live service status tracking screen
  - [ ] Service history and invoice viewing modal/page
- [ ] **Staff / Technician Portal**
  - [ ] Technician dashboard with assigned task cards
  - [ ] Service progress update controls and parts logging form
  - [ ] Inspection checklist and notes interface
- [ ] **Admin Portal**
  - [ ] Admin management dashboard with key metrics
  - [ ] Service catalog & pricing management UI
  - [ ] User and staff account administration
  - [ ] Job allocation and scheduling board

---

## ⚙️ Phase 3: Backend Development (Java Servlets & DAO)
- [ ] **Model Layer (`com.autocare.model`)**
  - [ ] `User.java` (ID, name, email, password, role, phone)
  - [ ] `Vehicle.java` (ID, user_id, make, model, year, license_plate)
  - [ ] `ServiceType.java` (ID, service_name, description, base_price)
  - [ ] `Appointment.java` (ID, user_id, vehicle_id, appointment_date, status)
  - [ ] `ServiceRecord.java` (ID, appointment_id, technician_id, notes, total_cost, status)
- [ ] **DAO Layer (`com.autocare.dao`)**
  - [ ] `UserDAO.java` (authentication, registration, user lookup)
  - [ ] `VehicleDAO.java` (CRUD operations for customer vehicles)
  - [ ] `ServiceTypeDAO.java` (fetch active catalog services and packages)
  - [ ] `AppointmentDAO.java` (create, list by user, update appointment status)
  - [ ] `ServiceRecordDAO.java` (technician logging, status transitions, invoice data)
- [ ] **Controller Layer (`com.autocare.controller`)**
  - [ ] `AuthServlet.java` (login, logout, session verification)
  - [ ] `RegisterServlet.java` (customer signup)
  - [ ] `VehicleServlet.java` (vehicle profile endpoints)
  - [ ] `AppointmentServlet.java` (booking and appointment management)
  - [ ] `TechnicianServlet.java` (job handling and status transitions)
  - [ ] `AdminServlet.java` (user control, catalog management, dashboard stats)

---

## 🔗 Phase 4: Integration & Testing
- [ ] Connect frontend forms to servlet endpoints via POST/Fetch API
- [ ] Implement session filters and role-based route protection
- [ ] Validate end-to-end user workflows:
  - [ ] Customer registers, adds vehicle, and schedules a service
  - [ ] Admin approves booking and assigns to a technician
  - [ ] Technician updates status from *In Progress* to *Completed*
  - [ ] Customer views real-time status update and completed invoice
- [ ] Error handling, form validation, and SQL injection sanitization
- [ ] Cross-browser and responsive device testing
- [ ] Final deployment on Apache Tomcat and demo walkthrough preparation
