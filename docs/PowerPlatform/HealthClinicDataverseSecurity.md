### Health Clinic Management System

#### Background

A health clinic employs Microsoft's Power Platform, built on Microsoft Dataverse, to manage its patient records, appointments, and internal communications efficiently and securely. The system includes:

- **Patient Records Management** (Model-driven App)
- **Appointment Scheduling** (Canvas App)
- **Internal Communications** (Microsoft Teams integration with automated workflows)

#### Security Requirements and Implementation

**1. Licensing**
- All staff members are provided with Power Apps licenses, determining their base level of access to the Power Platform ecosystem.

**2. Environment and Business Unit Setup**
- The clinic establishes a single Dataverse environment as the primary container for its applications and data.
- Within this environment, departments such as Pediatrics and Orthopedics are set up as distinct **Business Units**, reflecting the clinic's hierarchical and matrix organizational structure.

**3. Hierarchical and Matrix Data Access Structure**
- **Senior medical staff** are granted broad access across business units due to their role, allowing them to oversee patient care across departments.
- **Specialized medical staff**, such as those with cross-departmental expertise, are given matrix access to multiple business units, enabling them to access patient records in both Pediatrics and Orthopedics.

**4. Security Roles, Teams, and Ownership**
- Custom security roles are created and assigned to staff based on their department and job function. These roles define access at the business unit level, table/record level, and even field level for sensitive information.
- **Teams** are formed to group staff by their function and department. These teams facilitate efficient permission management and reflect the clinic's organizational structure within Dataverse.
  - **Medical Staff Teams**: Include doctors and nurses, with access permissions to patient records based on their specific roles and the hierarchical structure.
  - **Receptionist Team**: Has access to the Appointment Scheduling app but limited access to patient records, ensuring they can manage appointments without viewing sensitive health information.
  - **Group Teams** (Microsoft 365 groups) are used for internal communications, integrating seamlessly with Microsoft Teams for efficient collaboration without compromising patient data security.

**5. Table/Record Ownership and Access Controls**
- **Patient records** are owned by the clinic but are accessible only to authorized medical personnel based on their security roles and team memberships.
- **Appointment data** is managed by receptionists, who are the primary owners of this data, ensuring that only they can make changes to the schedule.

#### Advanced Security Measures
- **Row-Level Security** is implemented to ensure that only medical staff involved in a patient's care can access their records.
- **Field-Level Security** restricts access to highly sensitive patient information, such as medical history, to authorized senior medical staff only.
- Custom connectors to external services (e.g., SMS notifications for appointments) are secured and managed based on the credentials of the service, ensuring data is shared securely and in compliance with health data protection regulations.

#### Conclusion

Hope this gave you good overview of how Dataverse security concepts are implemented.