# video_thumbs_relay

Docker worker for generating video thumbnails in Nextcloud.

## Overview

This project extends the original [video_thumbs_relay](https://github.com/silversong88/video_thumbs_relay) project.

The worker runs standalone in a Docker container and generates video thumbnails for Nextcloud. It communicates with the Nextcloud app **Video Thumbnail Relay**.

**Additional feature:** You can specify which folders should be scanned using the `SCAN_PATHS` setting in `worker.env`. Only the configured folders and their subfolders are scanned.

## Requirements

- A running Nextcloud instance
- The Nextcloud app **Video Thumbnail Relay** must be installed and configured.

Nextcloud app: [Video Thumbnail Relay](https://apps.nextcloud.com/apps/video_thumbs_relay)

Original project: [silversong88/video_thumbs_relay](https://github.com/silversong88/video_thumbs_relay)

## Installation

1. Download or clone this repository.
2. Create your configuration file:

   ```bash
   cp worker.env.example worker.env
   ```

3. Edit `worker.env` and configure your Nextcloud connection and the folders to scan.
4. Start the worker:

   ```bash
   docker compose up -d
   ```

The Docker image is available from GitHub Container Registry:

```bash
docker pull ghcr.io/linux-helmut/video_thumbs_relay:v1.0.1
```

## Configuration

Configure the worker in `worker.env`.

Use `SCAN_PATHS` to specify the folders to scan, separated by commas. For example:

```dotenv
SCAN_PATHS=/Bilder,/SofortUpload,/User_Pics
```

The paths are relative to the Nextcloud user's WebDAV root. Each configured folder and its subfolders are included in the scan.

Make sure the paths match the folder names accessible to the configured Nextcloud user.

## Successfully tested with the following Nextcloud versions and environments:

- Nextcloud 33.0.4
- Nextcloud 33.0.5
- Nextcloud 34.0.5
- Nextcloud 34.0.5 on Hetzner Storage Share

## License

This project is licensed under the **GNU Affero General Public License v3.0 or later (AGPL-3.0-or-later)**. See [LICENSE](LICENSE).

See [UPSTREAM.md](UPSTREAM.md) for information about the original project and the modifications made in this repository.

