# Build from base - may have to specify version later.
FROM heysailor/passenger-nodejs-nginx-sailsjs:latest

# Set environment variables
ENV APP_DIR /home/app

# Update nginx confs
ADD nginx/app.conf /etc/nginx/sites-enabled/app.conf
ADD nginx/mongo-env.conf /etc/nginx/main.d/mongo-env.conf
ADD nginx/00_app_env.conf /etc/nginx/conf.d/00_app_env.conf

# Add the app files
COPY ./ ${APP_DIR}

# Build app
WORKDIR ${APP_DIR}
RUN npm install

# Change owner of app files to app (UID 9999) (app.js is run by passenger as whatever its owner is)
RUN chown -R 9999 /${APP_DIR}
RUN chown -R 9999 ${APP_DIR}/.tmp

# Clean up server config files
RUN rm -rf ${APP_DIR}/nginx

# Uncomment below to stop app restart after every request (development feature only)
# RUN rm ${APP_DIR}/tmp/always_restart.txt