# AutoCare – Vehicle Service Management System

AutoCare is a web-based Vehicle Service Management System designed to streamline automotive service operations, automate manual record-keeping, and provide transparent tracking for vehicle owners, service staff, and administrators.

---

## 👥 Team Members

- **Yash Palkar**
- **Prayag Pagote**
- **Aaryan Patil**
- **Sagar Pandit**

---

## 💻 Tech Stack

- **Frontend:** HTML5, CSS3, JavaScript
- **Backend:** Java Servlets, Java EE / Jakarta EE
- **Server:** Apache Tomcat
- **Database:** MySQL (connected via JDBC)
- **Architecture Pattern:** Model-View-Controller (MVC)

---

## 📂 Project Context & Documentation

Detailed project documentation, architectural blueprints, and development tracking are maintained inside the [`context/`](context/) directory:

- [Project Overview](context/Project%20overview.md) – Problem statement, business objectives, and role-based specifications (Customer, Staff, Admin).
- [System Architecture](context/Architecture.md) – Structural separation across Presentation (HTML/CSS/JS), Business Logic (Java Servlets on Tomcat), and Data Access (MySQL via JDBC).
- [Progress Tracker](context/Progress%20tracker.md) – Four-phase execution checklist covering Setup, Frontend, Backend, and Integration.

---

## 📁 Project Directory Structure

```plaintext
Autocare/
├── README.md
├── context/
│   ├── Project overview.md
│   ├── Architecture.md
│   └── Progress tracker.md
├── database/
│   └── schema.sql
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── autocare/
        │           ├── controller/
        │           ├── dao/
        │           └── model/
        └── webapp/
            ├── css/
            ├── js/
            └── index.html
```

---

## 🚀 Getting Started

1. **Database Setup:** Run `database/schema.sql` on your MySQL server instance.
2. **Tomcat Deployment:** Configure Apache Tomcat in your IDE (Eclipse / IntelliJ / VS Code) targeting `src/main/webapp` as web content directory.
3. **Run Application:** Start Tomcat and access `http://localhost:8080/Autocare/` in your web browser.
