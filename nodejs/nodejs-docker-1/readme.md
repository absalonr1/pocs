
# install express 
npm i express@4.16.1

# run locally
docker run -p 49160:8080 -d aopazo/node-web-app

# create image
...

# https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/

# If you do not supply command or args for a Container, the defaults defined in the Docker image are used.
# If you supply a command but no args for a Container, only the supplied command is used. The default EntryPoint and the default Cmd defined in the Docker image are ignored.
# If you supply only args for a Container, the default Entrypoint defined in the Docker image is run with the args that you supplied.
# If you supply a command and args, the default Entrypoint and the default Cmd defined in the Docker image are ignored. Your command is run with your args.
