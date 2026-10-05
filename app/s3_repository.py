import json
import boto3

BUCKET_NAME = "learn-aws-terraform-employee-data"
FILE_NAME = "employees.json"

s3 = boto3.client("s3")


def get_employees():
    try:
        response = s3.get_object(
            Bucket=BUCKET_NAME,
            Key=FILE_NAME,
        )

        content = response["Body"].read().decode("utf-8")
        return json.loads(content)

    except s3.exceptions.NoSuchKey:
        return []


def save_employees(employees):
    s3.put_object(
        Bucket=BUCKET_NAME,
        Key=FILE_NAME,
        Body=json.dumps(employees),
        ContentType="application/json",
    )