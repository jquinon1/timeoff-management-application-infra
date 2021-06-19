resource "aws_ecr_repository" "repository" {
    for_each = {for repo in var.repositories: "${var.environment}-${repo.name}" => repo}
    name = "${var.environment}-${each.key}"
    image_scanning_configuration {
        scan_on_push = each.value.scan_on_push
    }
}

output "registries" {
    value = "${aws_ecr_repository.repository}"
}