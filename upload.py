import os

import boto3


def upload_folder_to_s3(bucket_name, local_folder, s3_folder_path):
    s3_client = boto3.client("s3")

    for root, dirs, files in os.walk(local_folder):
        for file in files:
            local_file_path = os.path.join(root, file)
            s3_key = os.path.join(
                s3_folder_path, os.path.relpath(local_file_path, local_folder)
            )
            s3_client.upload_file(local_file_path, bucket_name, s3_key)


if __name__ == "__main__":
    # Replace these variables with your own values
    bucket_name = "sagardahiya69"
    local_folder = "/home/fossil/BACKUP/"
    s3_folder_path = "rambo/BACKUP/"

    upload_folder_to_s3(bucket_name, local_folder, s3_folder_path)
