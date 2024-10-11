import os
import json
import pandas as pd
from google.cloud import storage

def csv_to_parquet(data, context):
    # Détails de l'objet
    bucket_name = data['terraform-marie-bucket-by-marie']
    
    # Initialiser le client de stockage
    client = storage.Client()
    bucket = client.bucket(bucket_name)

    # Lister tous les fichiers dans le bucket
    blobs = bucket.list_blobs()

    for blob in blobs:
        # Traiter uniquement les fichiers CSV
        if blob.name.endswith('.csv'):
            # Télécharger le fichier CSV
            csv_data = blob.download_as_text()

            # Lire le CSV dans un DataFrame
            df = pd.read_csv(pd.compat.StringIO(csv_data))

            # Déterminer le nom du fichier Parquet
            parquet_file_name = os.path.splitext(blob.name)[0] + '.parquet'

            # Convertir le DataFrame en Parquet
            parquet_blob = bucket.blob(parquet_file_name)
            parquet_blob.upload_from_string(df.to_parquet(index=False), content_type='application/octet-stream')

            print(f'Converted {blob.name} to {parquet_file_name} and uploaded to {bucket_name}.')
