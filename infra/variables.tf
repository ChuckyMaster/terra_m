variable "gcp_svc_key" {
  description = "C:/Users/chuck/Downloads/terraform-438214-003b5d50754a.json"
  type        = string
}

variable "gcp_project" {
  description = "terraform-438214"
  type        = string
}

variable "gcp_region" {
  description = "Région GCP"
  type        = string
  default     = "us-central1" # ou toute autre région par défaut
}

variable "csv_files" {
  description = "Map of CSV files with local paths as values"
  type        = map(string)
  default     = {
    "file_csv1.csv" = "../source/clients.csv"
    "file_csv2.csv" = "../source/produits.csv"
    "file_csv3.csv" = "../source/stocks.csv"
    "file_csv4.csv" = "../source/ventes.csv"
  }
}

