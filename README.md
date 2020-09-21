# OSS Deployment Action

This GitHub Action deploys static files to Aliyun (or Alibaba Cloud) OSS.

## Quick start

1. Create the directory `.github/workflows` (if not exist);

1. Run the following command to get an example workflow configuration:

    ```sh
    curl -L u.nu/oss-deploy-workflow >.github/workflows/oss-deployment.yml
    ```

1. Modify the configuration based on your needs and identification of your account;

1. Commit and push it.

You are all set. When triggered, the workflow will deploy files from the specified location to the specified path in OSS.
