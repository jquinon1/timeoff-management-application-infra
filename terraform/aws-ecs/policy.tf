resource "aws_iam_role" "ecs_task_role" {
    name = "${var.project_name}-ecsTaskRole"
    assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_policy" "elb_policy" {
    name        = "${var.project_name}-task-policy"
    description = "Policy for ${var.project_name}"
    policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
       {
           "Effect": "Allow",
           "Action": [
               "elasticloadbalancing:DeregisterTargets",
               "elasticloadbalancing:Describe*",
               "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
               "elasticloadbalancing:RegisterTargets",
               "ecs:*",
               "ecr:*",
               "elasticloadbalancing:*",
               "autoscaling:*"
           ],
           "Resource": "*"
       }
   ]
}
EOF
}
 
resource "aws_iam_role_policy_attachment" "ecs-task-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.elb_policy.arn
}