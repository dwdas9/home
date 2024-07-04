TBD



Power Platform Admin Central(PPAC) - Managing Users, Roles and Teams.

PPAC provides a centralized admin experience to manage users/security  roles and Teams.



## Background

In this article I will show you what are application users. Whey they are used. How we can create them. I will use a simple case-study so that you can related to it easily.

### Application users - case study

Say you have a power automate workflow(leave application) which adds new records in dataverse when a form is submitted by users. Now we have so many employees, we can't give all their ids access to the backend database. And its not feasible as well. They just want to submit the form. What is the soluton: 

Create an application user for the leave application workflow.
Give the application user read/write access to the tables.




### Add an Application user

Application users system accounts for background  tasks. You shouldn't update them or change their security roles. They don't consume any license.  The application users are given access to environment's data on behalf of the user who's using the application.

- Go to PPAC https://admin.powerplatform.microsoft.com/ -> Environments -> Select the environment
![alt text](images\image-44.png)

- Click Settings
![alt text](images\image-45.png)

- Click **Users + permissions** -> **Application users**.
  ![alt text](images\image-46.png)
- Click **+ New app user**.

Certainly! Let's delve into managing application users in the **Power Platform admin center**. This process is crucial for ensuring smooth access and security within your environment. Below, I'll outline the steps involved:

## Manage Application Users in the Power Platform Admin Center

### 1. **View Application Users in an Environment**
   - Sign in to the **Power Platform admin center** as a **System Administrator**.
   - Select **Environments**, and then choose an environment from the list.
   - Navigate to **Settings** and select **Users + permissions**.
   - Click on **Application users** to view and manage application users.

### 2. **Create an Application User**
   - You can create an **unlicensed application user** in your environment. This user will have access to your environment's data on behalf of the application.
   - In an environment, you can only have one application user for each **Microsoft Entra–registered application**.
   - Here's how:
     - Sign in to the **Power Platform admin center** as a **System Administrator**.
     - Select **Environments**, choose an environment, and go to **Settings**.
     - Click on **Users + permissions**, then select **Application users**.
     - Click **+ New app user** to open the **Create a new app user** page.
     - Choose the registered **Microsoft Entra application** created for the user.
     - Assign a **business unit** and select **security roles** for the new application user.
     - Save your changes and create the user.

### 3. **View or Edit Application User Details**
   - Sign in to the **Power Platform admin center** as a **System Administrator**.
   - Select **Environments**, choose an environment, and go to **Settings**.
   - Click on **Users + permissions**, then select **Application users**.
   - You can view or edit the details of an application user here.

Remember that **deleting an application user** is currently not supported. For more detailed information, you can refer to the official [Microsoft Learn article](https://learn.microsoft.com/en-us/power-platform/admin/manage-application-users).
