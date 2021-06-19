resource "aws_ecr_repository" "repository" {
    for_each = {for repo in var.repositories: repo.name => repo}
    name = each.key
    image_scanning_configuration {
        scan_on_push = each.value.scan_on_push
    }
}