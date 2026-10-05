# AutoCare – System Architecture

## 1. Architectural Overview
AutoCare adheres to a 3-tier architecture utilizing the classic **Model-View-Controller (MVC)** design pattern. This architecture cleanly decouples presentation concerns, business logic execution, and database persistence.

```
+-------------------------------------------------------------+
|                      PRESENTATION TIER                      |
|                  (HTML5, CSS3, JavaScript)                  |
|          Web Browser UI (Customer, Staff, Admin)           |
+------------------------------+------------------------------+
                               |
                        HTTP / HTTPS
                               |
+------------------------------v------------------------------+
|                     APPLICATION TIER                        |
|             (Apache Tomcat - Java Servlets)                 |
|                                                             |
|   +-----------------------+     +-----------------------+   |
|   | Controller (Servlets) | --> | Model (JavaBeans/DTO) |   |
|   +-----------+-----------+     +-----------+-----------+   |
|               |                             ^               |
|               v                             |               |
|   +-----------------------------------------+-----------+   |
|   |                 DAO (Data Access Object)            |   |
|   +-----------------------------------------------------+   |
+------------------------------+------------------------------+
                               |
                          JDBC Driver
                               |
+------------------------------v------------------------------+
|                        DATA TIER                            |
|                 (MySQL Relational Database)                 |
|            Users, Vehicles, Services, Appointments          |
+-------------------------------------------------------------+
```

---

## 2. Layered Breakdown

### 2.1 Presentation Tier (Frontend)
- **Technologies:** HTML5, CSS3, Vanilla JavaScript (ES6+).
- **Location:** `src/main/webapp/`
- **Responsibilities:**
  - Rendering responsive, role-tailored user interfaces (Customer, Staff, Admin).
  - Client-side validation (form inputs, appointment dates, registration details).
  - Asynchronous interactions (AJAX / Fetch API) for real-time status updates without full page reloads.
  - Delivering styling via `css/` and dynamic behaviors via `js/`.

### 2.2 Application Tier (Backend)
- **Technologies:** Java Servlets, Java EE / Jakarta EE API, Apache Tomcat 9/10.
- **Location:** `src/main/java/com/autocare/`
- **Architectural Components:**
  - **Controller (`com.autocare.controller`):**
    - Java Servlets mapping incoming HTTP requests (GET, POST).
    - Session management, role verification, and request dispatching.
    - Parsing parameters, invoking appropriate DAO methods, and sending JSON responses or forwarding to views.
  - **Model (`com.autocare.model`):**
    - Plain Old Java Objects (POJOs) / JavaBeans representing core domain entities (e.g., `User`, `Vehicle`, `ServiceRequest`, `Appointment`, `Invoice`).
    - Encapsulates state, business data validation, and getter/setter utilities.
  - **DAO (`com.autocare.dao`):**
    - Data Access Object pattern isolating database persistence from servlet controllers.
    - Prepared statements, connection pooling, and transactional operations.

### 2.3 Data Tier (Database)
- **Technologies:** MySQL 8.x, MySQL Connector/J (JDBC).
- **Location:** `database/schema.sql`
- **Responsibilities:**
  - Relational schema enforcing referential integrity with foreign keys, constraints, and cascading rules.
  - Efficient indexing on user lookups, vehicle registration numbers, and appointment status queries.
  - Secure storage with hashed passwords and audit timestamps (`created_at`, `updated_at`).

---

## 3. Request Lifecycle

1. **User Action:** The client browser submits an action (e.g., login, book service) via HTTP POST/GET.
2. **Servlet Routing:** Apache Tomcat routes the request to the matching servlet controller registered in `com.autocare.controller`.
3. **Session & Security Filter:** The controller or filter verifies user authentication and role permissions.
4. **DAO Invocation:** The controller invokes methods on a DAO class in `com.autocare.dao`.
5. **JDBC Execution:** The DAO connects via JDBC to the MySQL database, runs parameterized queries, and maps result sets into Model entities (`com.autocare.model`).
6. **Response Generation:** The servlet returns data (either forwarding to rendered HTML/JSP or returning JSON to client-side JS), which updates the user interface.
