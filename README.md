# OSS Deployment Action

This GitHub Action deploys static files to Aliyun (Alibaba Cloud) OSS.

## Quick start

There is a [template workflow configuration](https://github.com/YangHanlin/oss-deployment-action/blob/gh-pages/workflow.yml) for you to quickly start with:

```bash
mkdir -p .github/workflows
curl -L -o .github/workflows/oss-deploy.yml bit.ly/oss-deployment-action-example
# use your favorite editor to edit .github/workflows/deploy.yml
```

## Examples

### Basic usage

The following example might cover most of the use cases.

```yaml
      - uses: YangHanlin/oss-deployment-action@v1
        with:
          # Replace REGION with actual region of the bucket, e.g. oss-cn-hangzhou
          oss-endpoint: REGION.aliyuncs.com
          # It is recommended to set the credentials as GitHub Action secrets
          oss-accesskey-id: ${{ secrets.OSS_ACCESSKEY_ID }}
          oss-accesskey-secret: ${{ secrets.OSS_ACCESSKEY_SECRET }}
          # Uncomment the following line only if STS is used
          # oss-sts-token: ${{ secrets.OSS_STS_TOKEN }}used only when STS is used
          # Replace BUCKET and PATH with actual bucket name and path
          oss-path: oss://BUCKET/PATH
          # Uncomment the following line if you want to specify a different path to deploy files from; otherwise the current working directory is deployed
          # local-path: '.'
          debug: ${{ secrets.ACTIONS_STEP_DEBUG }}
```

### Customizing `ossutil`

If you'd like to have more control over the version and configuration of `ossutil`, or if you have downloaded and configured `ossutil` in previous steps, you can put `ossutil` in `PATH` to make this action use the existing `ossutil` instead of downloading and configuring it again.

```yaml
      - run: |
          mkdir -p "$HOME/.local/bin"
          wget -O "$HOME/.local/bin/ossutil" https://gosspublic.alicdn.com/ossutil/1.7.14/ossutil64
          chmod +x "$HOME/.local/bin/ossutil"
          "$HOME/.local/bin/ossutil" config --endpoint=REGION.aliyuncs.com --access-key-id=$OSS_ACCESSKEY_ID --access-key-secret=$OSS_ACCESSKEY_SECRET
          # or some other customization
          echo "$HOME/.local/bin" >> $GITHUB_PATH
        env:
          OSS_ACCESSKEY_ID: ${{ secrets.OSS_ACCESSKEY_ID }}
          OSS_ACCESSKEY_SECRET: ${{ secrets.OSS_ACCESSKEY_SECRET }}
      - uses: YangHanlin/oss-deployment-action@v1
        with:
          # Replace BUCKET and PATH with actual bucket name and path
          oss-path: oss://BUCKET/PATH
          # Uncomment the following line if you want to specify a different path to deploy files from; otherwise the current working directory is deployed
          # local-path: '.'
          debug: ${{ secrets.ACTIONS_STEP_DEBUG }}
```

## Option reference

| Option                 | Description                                                  | Required                                             | Default value |
| ---------------------- | ------------------------------------------------------------ | ---------------------------------------------------- | ------------- |
| `oss-endpoint`         | OSS endpoint                                                 | Yes if no `ossutil` exists in `PATH`                 |               |
| `oss-accesskey-id`     | AccessKey ID of user with write access to OSS                | Yes if no `ossutil` exists in `PATH`                 |               |
| `oss-accesskey-secret` | AccessKey secret of the user identified by the previous AccessKey ID | Yes if no `ossutil` exists in `PATH`                 |               |
| `oss-sts-token`        | STS token                                                    | Yes if no `ossutil` exists in `PATH` and STS is used |               |
| `oss-path`             | Path to the location you'd like to deploy files to, i.e. `oss://<BUCKET NAME>/<PATH>` | Yes                                                  |               |
| `local-path`           | Path to the location you'd like to deploy files from         | No                                                   | `.`           |
| `ignored-patterns`     | Blob patterns of files (separated by spaces) to ignore in deployment | No                                                   | `.git`        |
| `delete-first`         | Whether to delete files under `oss-path` before deployment   | No                                                   | `false`       |
| `force-setup-ossutil`  | Whether to force download and configure even if `ossutil` is in `PATH` | No                                                   | `false`       |
| `cache-ossutil`        | Whether to cache downloaded `ossutil`                        | No                                                   | `false`       |
| `debug`                | Whether to enable debug logging; **recommended to set to `${{ secrets.ACTIONS_STEP_DEBUG }}` to align with debug logging option provided by GitHub Actions** | No                                                   | `false`       |

## Caveats

- The current version of this action is using [`ossutil`](https://help.aliyun.com/document_detail/50452.html) to upload files to OSS. It downloads and configures `ossutil` with provided credentials automatically by default; but if `ossutil` can be found in `PATH`, this action will use that copy and **assumes it is already configured with proper credentials and endpoint**. This is to leave to you the space for additional customization of `ossutil`; see [this example](#customizing-ossutil).

## License

All contents in this repository, unless otherwise noted, are licensed under [MIT](LICENSE).

This repository is not affliated with Alibaba Cloud.
