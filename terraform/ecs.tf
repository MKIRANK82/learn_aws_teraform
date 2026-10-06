resource "aws_ecs_cluster" "employee_api" {
  name = "learn-employee-api-cluster"
}


resource "aws_iam_role" "ecs_execution_role" {
  name = "learn-employee-api-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


resource "aws_iam_role" "ecs_task_role" {
  name = "learn-employee-api-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role_policy" "ecs_task_s3_policy" {
  name = "employee-api-s3-access"
  role = aws_iam_role.ecs_task_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ]

        Resource = [
          "arn:aws:s3:::learn-aws-terraform-employee-data",
          "arn:aws:s3:::learn-aws-terraform-employee-data/*"
        ]
      }
    ]
  })
}