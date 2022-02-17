#!/bin/sh

{
	echo "# Dynamically generated configuration, do not edit!"

	cat "$SNAP/config.yaml.base"

	cat "$SNAP/fragments/homedir"
	printf "homedir: \"%s\"\n" "$SNAP_COMMON/var/lib/iotedge"

	cat "$SNAP/fragments/hostname"
	#TODO: figure out why this isn't working as expected
	#printf "hostname: \"%s\"\n" "$(/usr/bin/hostnamectl --static)"
	printf "hostname: \"%s\"\n" "$(snapctl get hostname)"

	cat "$SNAP/fragments/provisioning"
	printf "  source: \"%s\"\n" "$(snapctl get provisioning.source)"
	# TODO: don't print this if not set
	printf "  device_connection_string: \"%s\"\n" "$(snapctl get provisioning.device-connection-string)"
	printf "  dynamic_reprovisioning: %s\n" "$(snapctl get provisioning.dynamic-reprovisioning)"

} > $SNAP_DATA/config/config.yaml
