import logging
import azure.functions as func
import os
from azure.cosmos import CosmosClient, exceptions

COSMOS_DB_ENDPOINT = os.environ["COSMOS_DB_ENDPOINT"]
COSMOS_DB_KEY = os.environ["COSMOS_DB_KEY"]
DATABASE_ID = "resume"
CONTAINER_ID = "visitorCount"

client = CosmosClient(COSMOS_DB_ENDPOINT, COSMOS_DB_KEY)
container = client.get_database_client(DATABASE_ID).get_container_client(CONTAINER_ID)

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Visitor counter triggered.')

    try:
        item = container.read_item(item="counter", partition_key="counter")
        item['count'] += 1
        container.replace_item(item="counter", body=item)

        return func.HttpResponse(
            body=f'{{"count": {item["count"]}}}',
            mimetype="application/json",
            status_code=200
        )

    except exceptions.CosmosHttpResponseError as e:
        logging.error(f"Cosmos DB error: {str(e)}")
        return func.HttpResponse(
            body='{"error": "Database error"}',
            mimetype="application/json",
            status_code=500
        )
