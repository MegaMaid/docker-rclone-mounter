# Usage

Default launch of container:

```
docker run -itd \
    --name rclone-mount \
    --memory=8192m \
    --cpuset-cpus="0" \
    -v /Users/leezilla/Downloads/RCloneMounter/config:/config \
    -v /Users/leezilla/Downloads/RCloneMounter/foo:/mount:shared \
    --privileged --cap-add=MKNOD --cap-add=SYS_ADMIN --device=/dev/fuse \
    megamaid/rclonemounter
```
