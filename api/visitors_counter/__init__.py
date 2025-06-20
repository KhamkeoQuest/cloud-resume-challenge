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

    item_id = "counter"
    partition_key = item_id  # now same as id and matches container's /id partition key

    try:
        logging.info("Reading item from Cosmos DB")
        item_response = container.read_item(item=item_id, partition_key=partition_key)
        item_response['count'] += 1
        container.replace_item(item=item_response, body=item_response)
        logging.info(f"Existing item updated. New count: {item_response['count']}")
    except Exception as e:
        logging.warning(f"Item not found or error: {e}")
        item_response = {
            "id": item_id,
            "count": 1
        }
        try:
            container.create_item(body=item_response)
            logging.info("New item created in Cosmos DB.")
        except Exception as create_error:
            logging.error(f"Failed to create item: {create_error}")
            return func.HttpResponse("Error creating counter item.", status_code=500)

    return func.HttpResponse(
        body=f'{{"count": {item_response["count"]}}}',
        mimetype="application/json",
        status_code=200
    )
