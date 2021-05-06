resource "google_project_iam_custom_role" "km-role" {
  role_id     = "KnowledgeManagementRole"
  title       = "Knowledge Management Custom Role"
  description = "Test role for KM"
  permissions = [
    "networkmanagement.*",
    "resourcemanager.projects.get",
    "resourcemanager.projects.list",
    "serviceusage.quotas.get",
    "serviceusage.services.get",
    "serviceusage.services.list",
  ]
}
