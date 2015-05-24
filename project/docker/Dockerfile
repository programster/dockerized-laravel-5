FROM ubuntu:trusty

RUN apt-get update
RUN apt-get dist-upgrade -y


# Install the relevant packages
RUN apt-get install vim apache2 libapache2-mod-php5 php5-cli php5-mysqlnd curl php5-curl php5-mcrypt -y

# Enable the php mod we just installed
RUN a2enmod php5


# expose port 80 and 443 for the web requests
EXPOSE 80
EXPOSE 443


###### Update the php INI settings #########

# Increase php's max allowed memory size
RUN sed -i 's;memory_limit = .*;memory_limit = -1;' /etc/php5/apache2/php.ini
RUN sed -i 's;memory_limit = .*;memory_limit = -1;' /etc/php5/cli/php.ini

RUN sed -i 's;display_errors = .*;display_errors = Off;' /etc/php5/apache2/php.ini
RUN sed -i 's;display_errors = .*;display_errors = On;' /etc/php5/cli/php.ini

# Change apache php to allow larger uploads/POSTs
RUN sed -i 's;post_max_size = .*;post_max_size = 4000M;' /etc/php5/apache2/php.ini
RUN sed -i 's;upload_max_filesize = .*;upload_max_filesize = 2000M;' /etc/php5/apache2/php.ini

# Set the max execution time
RUN sed -i 's;max_execution_time = .*;max_execution_time = 300;' /etc/php5/apache2/php.ini
RUN sed -i 's;max_execution_time = .*;max_execution_time = 300;' /etc/php5/cli/php.ini

# This is also needed for execution time
RUN sed -i 's;max_input_time = .*;max_input_time = 300;' /etc/php5/apache2/php.ini


####### END of updating php INI ########
########################################

# Manually set the apache environment variables in order to get apache to work immediately.
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

# It appears that the new apache requires these env vars as well
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid

# Set up url rewrite ability
RUN a2enmod rewrite
RUN php5enmod mcrypt

# Install the cron service
RUN apt-get install cron -y

# Add our websites files to the default apache directory (/var/www)
# This should be as close to the last step as possible for faster rebuilds
ADD settings /var/www/my-website/settings

# Add our websites files to the default apache directory (/var/www)
ADD project /var/www/my-website/project

# Update our apache sites available with the config we created
ADD project/docker/apache-config.conf /etc/apache2/sites-enabled/000-default.conf


# Use the crontab file.
# The crontab file was already added when we added "project"
RUN crontab /var/www/my-website/project/docker/crons.conf

# Make the uploads folder writeable
RUN chown root:www-data -R /var/www
RUN chmod 750 -R /var/www/my-website
RUN chmod 770 -R /var/www/my-website/project/storage

# Execute the containers startup script which will start many processes/services
# The startup file was already added when we added "project"
CMD ["/bin/bash", "/var/www/my-website/project/docker/startup.sh"]
