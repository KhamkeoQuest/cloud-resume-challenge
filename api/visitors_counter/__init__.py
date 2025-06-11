import logging
import os
import azure.functions as func
from azure.data.tables import TableServiceClient

# Read connection string from environment variable
connection_string = os.getenv("TABLE_STORAGE_CONNECTION")

# Initialize Table client
table_service = TableServiceClient.from_connection_string(conn_str=connection_string)
table_client = table_service.get_table_client(table_name="visitorcounter")

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Processing visitor count request.')

    partition_key = "counter"
    row_key = "visitor"

    try:
        entity = table_client.get_entity(partition_key=partition_key, row_key=row_key)
        entity['Count'] += 1
        table_client.update_entity(entity)
    except Exception as e:
        # First time, entity might not exist, so create it
        logging.warning(f"Entity not found, initializing: {e}")
        entity = {
            'PartitionKey': partition_key,
            'RowKey': row_key,
            'Count': 1
        }
        table_client.create_entity(entity)

    return func.HttpResponse(f'{{"count": {entity["Count"]}}}', mimetype="application/json", status_code=200)
