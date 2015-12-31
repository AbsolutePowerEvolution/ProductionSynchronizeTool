ProductionSynchronizeTool
=========================

This is a tool to automative depoly your production from github or any with github like webhook site.  


# Usage #
```shell
$ git clone https://github.com/AbsolutePowerEvolution/ProductionSynchronizeTool.git sync-tool
$ cd sync-tool
$ bundle --deployment
$ cd config
$ cp config.example.yml config.yml
$ vim config.yml # or use your favorite editor
```
Please config repo path to your product.

Then run `rake check` to ensure your repo can be sync.
If got any error please fix it.

If all done. Then run:
```shell
$ bundle exec puma
```
This will start the server and listen from github request.

# Configure #
- `address`: Address for bind on. Default is enough.
- `port`: Port to listen. This must match webhook config.
- `repo_path`: Fuii path to your product project root.
- `remote_name`: Remote name. Default is "origin".
