---
layout: default
title: Bulk Json Validation and Cleanup Using Azure Functions
nav_exclude: true
---

# <span style="color: SteelBlue;">Clean and Validate JSON Using Azure Functions</span>

### <span style="color: #9e0059;">Introduction</span>

In this case study, I detail handling multiple Python-acquired JSON files from a web API. The main challenge was their <span style="color: SaddleBrown;">ASCII</span> format with single quotes, causing validation problems. I resolved this by converting the files to <span style="color: DarkGreen;">UTF-8</span> format and implementing validation and sorting against a JSON schema using libraries like <span style="color: Navy;">json</span> and <span style="color: Chocolate;">jsonschema</span>. Files were initially in a <span style="color: DarkGoldenRod;">'Raw'</span> container, and post-validation, they were moved to either a <span style="color: Gray;">'silver'</span> container for valid data or an <span style="color: Crimson;">'error'</span> container for invalid ones within Azure Blob Storage. For larger datasets, however, I recommend using Spark connected to ADLS.

### <span style="color: MediumSeaGreen;">Pre-requisites</span>

- **Create the JSON Schema**: For well-strucuctured JSONs we can create the schema easily. You can take help from sites liks [transform.tools](https://transform.tools/json-to-json-schema).
- **Azure Function Setup**: To create an auto-scheduled function you will need to create a timer-triggered Azure function. You can refer to my [article](../../Projects/AzureSkyWeather/1_Ingestion/TimerTriggered/TimerTriggered_AzureFunc.md) for details.
- **Data Lake Storage Configuration**: My example works with Azure Data lake. However, if you are using a different storage like Azure blobs, the code might require little bit tweaking.

### <span style="color: Teal;">The Code</span>

Here is the code. Fill in your details appropriately.

```Python
import requests, logging, json
from jsonschema import validate
from jsonschema.exceptions import ValidationError
from datetime import datetime
import azure.functions as func
from azure.storage.blob import BlobServiceClient

def is_valid_json(data, schema):
    try:
        validate(instance=data, schema=schema)
        return True
    except ValidationError as e:
        logging.error(f"Validation error: {e}")
        return False

app = func.FunctionApp()

@app.schedule(schedule="<your CRON, e.g. >", arg_name="myTimer", run_on_startup=True,
              use_monitor=False) 
def AzFuncCheckNMoveJson(myTimer: func.TimerRequest) -> None:
    if myTimer.past_due:
        logging.info('The timer is past due!')

    logging.info('Python timer trigger function executed.')

    """
    Initialize BlobServiceClient using the given connection string.
    Storage Act, Access Keys, key1 -> Connection string(Copy)
    """
    blob_service_client = BlobServiceClient.from_connection_string("DefaultEndpointsProtocol=https;AccountName=<your_storage_act_name>;AccountKey=<your_account_key>;EndpointSuffix=core.windows.net")
    
    # Fetch the schema
    schema_blob_client = blob_service_client.get_blob_client(container="schema", blob="JSON_schema.json")
    try:
        schema_json = json.loads(schema_blob_client.download_blob().readall())
    except Exception as e:
        logging.error(f"Error fetching schema: {e}")
        
    
   # Iterate over blobs in the "weather-http" container
    container_client = blob_service_client.get_container_client("<raw_container>")
    for blob in container_client.list_blobs():
        try:
            blob_client = blob_service_client.get_blob_client(container="weather-http", blob=blob.name)
            data_str = blob_client.download_blob().readall().decode('utf-8')
            
            data_str = data_str.replace("'", '"')
            
            try:
                data = json.loads(data_str)
            except json.JSONDecodeError:
                data = json.loads(blob_client.download_blob().readall().decode('utf-8'))

            # Validate the JSON data
            if is_valid_json(data, schema_json):
                target_container = "silver"
            else:
                target_container = "error"

            # Move blob to the target container
            target_blob_client = blob_service_client.get_blob_client(container=target_container, blob=blob.name)
            target_blob_client.upload_blob(json.dumps(data), overwrite=True)
            blob_client.delete_blob()  # Delete the original blob after moving

        except Exception as e:
            logging.error(f"Error processing blob {blob.name}: {e}")

    logging.info("Processing complete.")
```

### <span style="color: Violet;">requirements.txt</span>

The following entries should be there in `requirements.txt` file

azure-functions <br>
requests <br>
azure-storage-blob<br>
jsonschema


  
### <span style="color: DodgerBlue;">Conclusion</span>

The use of <span style="color: Chocolate;">jsonschema</span> in this project proved invaluable for efficient JSON validation, eliminating the need for iterative item-by-item examination. This method enhanced both speed and accuracy. While Azure Functions were apt for our dataset size, they're best for smaller datasets. For larger volumes, solutions like Spark with Azure Data Lake Storage (ADLS) are recommended, showcasing the need for scalable approaches in data processing.