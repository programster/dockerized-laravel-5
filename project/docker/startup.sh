# Please do not manually call this file!
# This script is run by the docker container when it is "run"

# Run the apache process in the background
/usr/sbin/apache2 -D APACHE_PROCESS &

service apache2 restart

# perhaps call migrations here?

# Start the cron service in the foreground
cron -f
