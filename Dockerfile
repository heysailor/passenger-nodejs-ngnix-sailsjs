#########################################################################################################
#
# heysailor/passenger-nodejs-nginx-sails
#
# By using a base image on which layer the working Docker container, rebuilding the working image becomes
# very fast - eg on code changes.
#
#########################################################################################################

# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/passenger-nodejs:0.9.9

# Set correct environment variables.
ENV HOME /root
ENV APP_DIR /home/app

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...

# Enable nginx and passenger
RUN rm -f /etc/service/nginx/down

# Tell passenger about sails app
RUN rm /etc/nginx/sites-enabled/default
ADD app.conf /etc/nginx/sites-enabled/app.conf
ADD mongo-env.conf /etc/nginx/main.d/mongo-env.conf
ADD 00_app_env.conf /etc/nginx/conf.d/00_app_env.conf

# Add the sails app
COPY ./app ${APP_DIR}

# Build app
WORKDIR ${APP_DIR}
RUN npm install

# Change owner of app files to app (UID 999) (app.js is run by passenger as whatever its owner is)
RUN chown -R 9999 /${APP_DIR}
RUN chown -R 9999 ${APP_DIR}/.tmp

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*