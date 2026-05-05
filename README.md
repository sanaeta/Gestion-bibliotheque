#  Library Management System (Jakarta EE)

##  Overview

This project is a **web-based Library Management System** built using **Jakarta EE (JEE)**.
It demonstrates a full **3-tier architecture** with a strong focus on backend design, transaction management, and role-based access control.

The application allows administrators and users to manage books, members, and borrowing operations in a secure and structured environment.

---

##  Architecture

The system follows a **3-tier architecture**:

* **Presentation Layer:** JSP (JavaServer Pages) + Bootstrap
* **Business Layer:** EJB (@Stateless)
* **Data Layer:** JPA (Java Persistence API) + MySQL

---

##  Features

###  Authentication & Authorization

* Secure login system
* Session management
* Role-based access:

  * **ADMIN** (librarian)
  * **ADHERENT** (user)

---

###  User Management

* Create, update, delete users
* Search users by name
* Profile management

---

###  Book Management

* Add, edit, delete books
* Track stock and availability
* Search by title or author

---

###  Borrowing System

* Borrow and return books
* Real-time stock updates
* Atomic transactions (ACID compliant)

---

###  Dashboard & Statistics

* Total books
* Total users
* Active borrowings

---

##  Tech Stack

* **Backend:** Jakarta EE 10 (EJB, Servlets)
* **Frontend:** JSP, JSTL, Bootstrap
* **Database:** MySQL
* **Server:** Payara Server 6
* **Build Tool:** Maven
* **Java Version:** JDK 17

---

##  Project Structure

```id="h7z2d1"
src/main/java/com/biblio/
├── entities/     # JPA entities (User, Book, Borrow)
├── services/     # EJB business logic
├── web/          # Servlets & filters
```

```id="f9k2la"
src/main/webapp/
├── admin/        # Admin views
├── client/       # User views
├── includes/     # Shared components (navbar, header)
```

---

##  Key Concepts Implemented

* **EJB @Stateless** for scalable business logic
* **JPA (EntityManager)** for persistence
* **JPQL queries** for optimized data access
* **Transaction management (ACID)**
* **Session handling & authentication filter**
* **MVC pattern (Servlets as controllers)**

---

##  Usage

1. Clone the repository:

```bash id="m3k92p"
git clone https://github.com/sanaeta/Gestion-bibliotheque.git
```

2. Configure database:

* Create a MySQL database
* Update `persistence.xml`

3. Deploy on Payara Server:

* Add JDBC resource (`jdbc/bibliothequeDS`)
* Deploy the project

4. Access the application:

```id="x82nqa"
http://localhost:8080/your-app-name
```

---

## ⚠️ Security

* Session-based authentication
* Role-based access control
* SQL injection protection using JPQL parameters
* Authentication filter for protected routes

---

##  Future Improvements

* REST API version (Spring Boot or Jakarta REST)
* Frontend modernization (React / Angular)
* JWT authentication
* Advanced reporting & analytics

---

##  Author

**Sanae Eljaafari**


---
