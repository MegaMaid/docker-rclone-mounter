# Usage

Default launch of container:

```
docker run -itd \
    --name rclone-mount \
    -v /my/hosts/storage/config:/config \
    -v /my/hosts/storage/mount:/mount:shared \
    -v /my/hosts/storage/cache:/cache:shared \
    --privileged --cap-add=MKNOD --cap-add=SYS_ADMIN --device=/dev/fuse \
    megamaid/rclonemounter
```

Note that this line is very much required for the correct mounting and sharing of data with the host:

`--privileged --cap-add=MKNOD --cap-add=SYS_ADMIN --device=/dev/fuse`

Inside the config folder you need to have rclone.conf (and any dependancies thereof) defined. This container will mount whatever you have named `mount` in the rclone config. For example, if you have a cached, encrypted google drive config, it might follow this pattern:

```
[gdrive-encrypted]
type = drive
client_id = 12345-67890-abcde-fghij.apps.googleusercontent.com
client_secret = fake_secret
scope = drive
token = {"access_token":"the_access_token","token_type":"Bearer","refresh_token":"the_refresh_token","expiry":"2019-10-25T13:17:46.234234243Z"}

[gdrive-decrypted]
type = crypt
remote = gdrive-encrypted:folder
filename_encryption = standard
directory_name_encryption = true
password = the_password_hash
password2 = the_password_2_hash

[remote]
type = cache
remote = gdrive-decrypted:/
plex_url = https://my.plex.host
plex_username = my_plex_username
plex_password = my_plex_password_hash
chunk_size = 25M
info_age = 2d
chunk_total_size = 100G
plex_token = my_plex_token
db_path = /cache
chunk_path = /cache
```

The above example was generted by using RClone on my local machine and calling `rclone config` from the command line. The order seen above is the order the config was created in. The config was then copied out of `~/.config/rclone/rclone.conf`.

**Note** that the lines `db_path = /cache` and `chunk_path = /cache` are created under the `rclone config` advanced setup for the cache type. You can also just manually add those lines later, but must be set to `/cache` to work with the container.
