docker-couchpotato
==================

Couchpotato daemon running in a container. The default paths have been altered to use the following volumes:

 * `/config`
 * `/download`
 * `/media`

`couchpotato` runs with the HTTP RPC interface listening on TCP port `5050`. The HTTP RPC interface is configured to not use authentication.

Assumptions
-----------

I use a NAS with a "download" share with the following structure:

  - Download                  - Completed downloads
  - Download\Torrents         - Watch directory for .torrent files
  - Download\Torrents\Working - Working directory where "in progress" files are located
  - Download\Usenet           - Watch directory for .nzb files
  - Download\Usenet\Working   - Working directory where "in progress" files are located

Host directory to container `VOLUME` mapping:

| Host Directory | Container Directory | Comment |
|----------------|---------------------|---------|
| /mnt/download  | /download           |         |
| /etc/docker/couchpotato | /config    |         |
| /media/movies  | /media              |         |
| /etc/localtime | /etc/localtime      | Set the container's TZ to match the host |

Quick-start
-----------
Run the command `docker run -d --restart always -h couchpotato --name couchpotato -v /mnt/download:/download -v /mnt/media/movies:/media -v /etc/docker/couchpotato:/config -v /etc/localtime:/etc/localtime:ro -p 5050:5050 randomparity/docker-couchpotato:latest`

Then open `http://<docker host IP>:5050` in a browser.
