#!/bin/bash

# Update sysconfig from environment variables
for FILE in /etc/sysconfig/apache2; do
	FILE_TMP=`mktemp`
	cat "$FILE" > "$FILE_TMP"
	grep '^[^#].*=' "$FILE" | while IFS='=' read KEY VALUE; do
		if [ -n "${!KEY+x}" ]; then
			echo "Updating $FILE: $KEY=${!KEY}" 1>&2
			sed -i "s#^$KEY=.*\$#$KEY=\"${!KEY}\"#g" "$FILE_TMP"
		fi
	done
	cat "$FILE_TMP" > "$FILE"
	rm -f "$FILE_TMP"
done

# Generate configuration
mkdir -p /tmp/phpbb
confd -onetime -backend env

# Perform installation
if [ "$PHPBB_SKIP_BOOTSTRAP" != "true" -a -e "install" ]; then
	echo "Performing installation"
    INSTALL_OUTPUT=$(php install/phpbbcli.php --no-ansi install /tmp/phpbb/install-config.yml 2>&1)
    if [[ $? -ne 0 || "$INSTALL_OUTPUT" == *"ERROR"* ]] && [[ "$INSTALL_OUTPUT" != *"prefix already exist"* ]]; then
		echo "$INSTALL_OUTPUT"
        echo "Install failed."
		truncate -s 0 config.php
        exit 1
    fi
fi

# Perform update
cat /tmp/phpbb/config.php > config.php
echo "Performing update"
UPDATE_OUTPUT=$(php bin/phpbbcli.php --no-ansi db:migrate --safe-mode 2>&1)
if [ $? -ne 0 ]; then
	echo "$UPDATE_OUTPUT"
    echo "Update failed."
    exit 1
fi

# Adjust configuration
if [ "$PHPBB_DISABLE_SESSION_VALIDATION" = "true" ]; then
	echo "Disabling session validation"
	for CONFIG_KEY in browser_check ip_check; do
		CONFIG_OUTPUT=$(php bin/phpbbcli.php --no-ansi config:set $CONFIG_KEY 0 2>&1)
		if [ $? -ne 0 ]; then
			echo "$CONFIG_OUTPUT"
			echo "Config update failed."
			exit 1
		fi
	done
fi

# Clean up
chown -R --reference=files cache store >/dev/null 2>&1
rm -Rf install /tmp/phpbb

# Start Apache
exec start_apache2 -DFOREGROUND
