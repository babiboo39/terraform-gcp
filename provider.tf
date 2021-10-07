provider "google" {
    credentials = "${file("./key/key.json")}"
    project = var.project_id
    region = var.region
}