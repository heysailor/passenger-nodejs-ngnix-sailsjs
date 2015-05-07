# Bootstrapped Phusion Passenger with NodeJs with nginx enabled, and Sails.js 0.11

To use, make a second container with this as the base. Override the nginx conf files detailed in the Dockerfile to settings appropriate for your app.

Optimised for fast dev workflow: app restarts on every request to enable live code reloading via a mounted volume. To disable app restarts, remove 'tmp/always_restart.txt'.

In dev, run with mounted volumes:

$ docker run -d -P -v /webapp:/home/app/api -v /webapp/config:/home/app/config -v /webapp/views:/home/app/views username/webapp

[## Those on MacOSX will encounter a permissions issue due to boot2docker - code in a mounted volume is given owner 1000:staff which cannot be run by app.js. Make a mounted volume with corrected uid:gid via the VMachine:

$ boot2docker halt

$ vboxmanage sharedfolder add “boot2docker-vm” –name webpp –hostpath /Users/username/path/to/webapp

$ boot2docker up

$ boot2docker ssh “sudo modprobe vboxsf && sudo mkdir /webapp && sudo mount -v -t vboxsf -o uid=9999,gid=9999 webapp /webapp”

…then your mounted files orginating from your MacOS will have app:app as owner:group, and app.js will be happy. ##]

If you add a node package to your child container, you'll need to rebuild the child container. But this will be super fast, as most node_modules will already be present from this container as base.

Enjoy!