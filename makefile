# Setup, part 1
setup-info-echo:
	echo Setting up locally.
setup-deploy-local:
	ln -s docker-compose.local.yml docker-compose.yml
pull-latest-images:
	docker-compose pull
set-env-variables:
	echo Edit the appropriate environment file for your instance type, envfile.local.txt or envfile.server.txt, filling in all mandatory variables, and optional variables as needed. && echo After doing this, run 'make setup-2'.

setup:
	make setup-info-echo && make setup-deploy-local && make pull-latest-images && set-env-variables

# Setup, part 2
build:
	docker-compose build
temp-bugfix-echo:
	echo 11 - Bugfix. # FORM DEPLOYMENT BUG PLEASE BE ADVICED - AS FROM 10/04/2018: (should be removed when fixed) If you start the kobo-docker framework the first time you have to set the permission of the media-folder correctly. otherwise form deployment as well as project creation will fail: Please run the following command inside your kobo-docker folder: docker-compose exec kobocat chown -R wsgi /srv/src/kobocat
temp-bugfix:
	docker-compose exec kobocat chown -R wsgi /srv/src/kobocat
echo-open-url-command:
	echo After server starts, run the following command to get the URL to open in the browser: "ip=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2 | head -n1 | awk '{print "http://"$1":8000"}') && open ${ip}"
serve-first-time:
	make pull-latest-images && docker-compose up
serve-in-background:
	make pull-latest-images && docker-compose up -d

setup2:
#	make build && make temp-bugfix-echo && make temp-bugfix && make echo-open-url-command && make serve
	make build && make echo-open-url-command && make serve-first-time

# Daily development
get-ips:
#	echo Run the following command: && ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2
	ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2
serve:
	docker-compose start
start:
	make serve
stop:
	docker-compose stop
