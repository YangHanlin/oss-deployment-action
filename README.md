# OSS Deployment Action

This GitHub Action deploys static files to Aliyun (or Alibaba Cloud) OSS.

## Quick start

1. Create the directory `.github/workflows` (if not exist);

1. Run the following command to get an example workflow configuration:

    ```sh
    curl -L u.nu/oss-deploy-workflow >.github/workflows/oss-deployment.yml
    ```

    > The example workflow configuration is hosted on GitHub Pages with Cloudflare CDN as well as Aliyun OSS with Aliyun CDN (synced with this GitHub Action). The URL provided above will direct you to Aliyun OSS if you are from mainland China and Cloudflare otherwise (using [geoteleport](https://github.com/YangHanlin/geoteleport)) to get fast speed in both cases.

1. Modify the configuration based on your needs and identification of your account;

1. Commit and push it.

You are all set. When triggered, the workflow will deploy files from the specified location to the specified path in OSS.
