import os

import boto3


def download_folder_from_s3(bucket_name, s3_folder, local_folder_path):
    s3_client = boto3.client("s3")

    # List all objects in the specified S3 folder
    response = s3_client.list_objects_v2(Bucket=bucket_name, Prefix=s3_folder)

    if "Contents" in response:
        for obj in response["Contents"]:
            # Get the S3 object key and local file path
            s3_key = obj["Key"]
            local_file_path = os.path.join(
                local_folder_path, os.path.relpath(s3_key, s3_folder)
            )

            # Create the local directory if it doesn't exist
            os.makedirs(os.path.dirname(local_file_path), exist_ok=True)

            # Download the file from S3
            s3_client.download_file(bucket_name, s3_key, local_file_path)


if __name__ == "__main__":
    # Replace these variables with your own values
    bucket_name = "sagardahiya69"
    s3_folder = "rambo/"
    local_folder_path = "/home/fossil/Downloads"

    download_folder_from_s3(bucket_name, s3_folder, local_folder_path)
