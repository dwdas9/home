## <span style="color: Indigo;Font-family: Segoe UI, sans-serif;">Background</span>

Power Platform is great in automation, but its true potential unlocks when you can connect it to non-standard data sources. This is where custom connectors come in, acting as bridges between Power Platform and external APIs. 

In this guide I will show you how to create custom connectors:

### <span style="color: DarkOrchid;Font-family: Segoe UI, sans-serif;">Steps to creating Custom Connectors for Power Platform</span>

**Building the Connector in Power Automate:**

1. **Launch Power Automate:** Sign in and navigate to the "Solutions" section. Create a new solution or open an existing one.

2. **Add a Custom Connector:** Within the solution, expand the "New" menu and select "Automation" > "Custom connector."

3. **Define Connection Details:**  Choose "Create from blank" and provide a descriptive name for your connector.

4. **Import API Definition (Optional):** If the API offers an OpenAPI (Swagger) definition file (.json or .yaml), you can import it to automatically populate actions and data models. Otherwise, you'll need to define them manually.

5. **Define Actions:**  Here's where the magic happens! Create actions representing the functionalities you want to expose in Power Apps. Each action should have a clear name, a concise description, and well-defined parameters (inputs) and outputs. 

* Parameters: Specify the data types (text, number, etc.) required for each action.
* Outputs: Define the structure of the data returned by the action (often matching the API's response format).

### <span style="color: Chocolate;Font-family: Segoe UI, sans-serif;">Example Action</span>

Let's say you're building a connector for a weather API. You might create an action named "GetWeather" that accepts a "city" parameter (text) and returns an output containing "temperature," "humidity," and "weather description" (all text).

6. **Configure Authentication:**  Specify the authentication method your chosen API requires. This could involve API keys, OAuth, or other methods.

7. **Test and Validate:**  The "Test" tab allows you to send test requests with sample data to ensure your connector functions as expected. Refine your definitions until the tests pass successfully.

8. **Save and Publish:**  Once everything is working smoothly, save your connector and then publish it to make it available in your environment.

### <span style="color: DodgerBlue;Font-family: Segoe UI, sans-serif;">Using the Custom Connector in Power Apps</span>

1. **Create a Power App:**  Build a new Power App or open an existing one.

2. **Connect to the Custom Connector:**  Navigate to the "Data" pane and select "Add data." Choose the "Connectors" tab and locate your custom connector by name. Click on it to establish a connection.

3. **Utilize the Connector Actions:**  Within your Power App formulas and expressions, you can now leverage the actions you defined in your custom connector.

### <span style="color: DodgerBlue;Font-family: Segoe UI, sans-serif;">Example Usage</span>

In your weather app, you could use the "GetWeather" action within a formula to display the current temperature and weather description for a user-entered city.
