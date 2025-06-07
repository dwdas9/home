### How to Use Web Services in SSIS Script Task

#### Introduction

Using web services in SSIS (SQL Server Integration Services) can be quite helpful when you need to get data from an external system. Here’s a simple guide on how to do this using the Script Task in SSIS.

#### Steps to Use Web Services in SSIS Script Task

1. **Create a Proxy Class for the Web Service**

   - First, you need to create a Proxy Class using WSDL (Web Services Description Language). This will help your SSIS package understand how to communicate with the web service.
   - Open the .NET command prompt and run this command:

     ```sh
     wsdl /language:VB http://localhost:8080/WebService/Service1.asmx?WSDL /out:C:\WebService1.vb
     ```

   - This command creates a file called `WebService1.vb` which is your Proxy Class.

> By default, it uses C Sharp if you don’t specify the language. In SSIS Script Task 2005, you can only use Visual Basic .NET, so generate the Proxy Class with VB if you are using SSIS 2005. For those unfamiliar with WSDL.EXE, it's a tool to generate code for XML Web Services and clients using ASP.NET from WSDL files, XSD schemas, and .discomap documents. It can be used with disco.exe.

1. **Publish Your Web Service to IIS**

   - In your web service project, right-click and select "Publish".
   - Choose the web site where you want to publish your web service.

2. **Add the Proxy Class to Your SSIS Project**

   - Open your SSIS package.
   - Drag and drop a Script Task onto the Control Flow area.
   - Right-click on the Script Task and select "Edit".
   - In the Script Task Editor, go to the "Script" section and click on "Design Script".
   - In the Script Editor, open Project Explorer (if it’s not visible, go to View -> Project Explorer).
   - Add your Proxy Class (`WebService1.vb`) to the project:
     - Right-click on your project in Project Explorer.
     - Select "Add" -> "Existing Item" and add the `WebService1.vb` file.

3. **Edit the Script in the Script Task**

   - Ensure that you include necessary namespaces in your script. Add these at the top of your Proxy Class file:

     ```vb
     Imports System.Web.Services
     Imports System.Xml.Serialization
     ```

   - In the `ScriptMain` class, create an object of the Proxy Class and call the web service methods. Here’s an example:

     ```vb
     Public Sub Main()
         Dim ws As New Service1
         MsgBox("Square of 2: " & ws.Square(2))
         Dts.TaskResult = Dts.Results.Success
     End Sub
     ```

4. **Handle Authentication Errors**

   - If you get an HTTP 401 Unauthorized error, add credentials to your web service call. Modify your `Main` method like this:

     ```vb
     Public Sub Main()
         Dim ws As New Service1
         ws.Credentials = New System.Net.NetworkCredential("username", "password", "domain")
         MsgBox("Square of 2: " & ws.Square(2))
         Dts.TaskResult = Dts.Results.Success
     End Sub
     ```