#Bucket

resource "google_storage_bucket" "bucket_ma" {
    name = "terraform-marie-bucket-by-marie"
    location = "EU"
}


# Upload csv to GC MACHIN
resource "google_storage_bucket_object" "csv_files" {
  for_each = var.csv_files
  name     = each.key             # Nom de l'objet dans le bucket
  bucket   = google_storage_bucket.bucket_ma.name
  source   = each.value           # Chemin du fichier local CSV
}

resource "google_storage_bucket_object" "function_zip" {
  name   = "function.zip"
  bucket = google_storage_bucket.bucket_ma.name
  source = "function.zip"  
}

resource "google_cloudfunctions_function" "function_deploy" {
  name                  = "csv_to_parquet"
  runtime               = "python39"              # Assurez-vous que la version est supportée
  entry_point           = "process_csv"           # Nom de la fonction dans votre script Python
  source_archive_bucket = google_storage_bucket.bucket_ma.name
  source_archive_object = google_storage_bucket_object.function_zip.name

  trigger_http          = true                    # Déclencheur HTTP pour appeler la fonction via une URL
  available_memory_mb   = 256
}