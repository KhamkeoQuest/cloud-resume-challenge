import logging
import os
import azure.functions as func
from azure.cosmos import CosmosClient, PartitionKey

# Load Cosmos DB credentials from environment variables
COSMOS_ENDPOINT = os.getenv("COSMOS_DB_ENDPOINT")
COSMOS_KEY = os.getenv("COSMOS_DB_KEY")
DATABASE_NAME = "resume"
CONTAINER_NAME = "visitorCounter"

# Initialize Cosmos Client
client = CosmosClient(COSMOS_ENDPOINT, credential=COSMOS_KEY)
database = client.get_database_client(DATABASE_NAME)
container = database.get_container_client(CONTAINER_NAME)

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Processing visitor count request.')

    item_id = "counter"  # static ID for this use case

    try:
        item_response = container.read_item(item=item_id, partition_key=item_id)
        item_response['count'] += 1
        container.replace_item(item=item_response, body=item_response)
    except Exception as e:
        logging.warning(f"Item not found, initializing counter: {e}")
        item_response = {
            "id": item_id,
            "count": 1
        }
        container.create_item(body=item_response)

    return func.HttpResponse(
        body=f'{{"count": {item_response["count"]}}}',
        mimetype="application/json",
        status_code=200
    )
