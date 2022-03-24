#!/bin/sh

{
	echo "# Dynamically generated configuration, do not edit!"

	cat "$SNAP/etc/aziot/config.toml.template"

	#cat "$SNAP/fragments/provisioning"
	printf "[provisioning]\n"
	printf "source = \"%s\"\n" "$(snapctl get provisioning.source)"
	# TODO: don't print this if not set
	printf "connection_string = \"%s\"\n" "$(snapctl get provisioning.connection-string)"

} > $SNAP_DATA/etc/aziot/config.toml


# Temporary Hacks
cp $SNAP_DATA/etc/aziot/certd/config.toml.default $SNAP_DATA/etc/aziot/certd/config.d/00-hack.toml
cp $SNAP_DATA/etc/aziot/identityd/config.toml.default $SNAP_DATA/etc/aziot/identityd/config.d/00-hack.toml
{
	printf "[provisioning]\n"
	printf "source = \"%s\"\n" "$(snapctl get provisioning.source)"
	# TODO: don't print this if not set
	printf "connection_string = \"%s\"\n" "$(snapctl get provisioning.connection-string)"
} >> $SNAP_DATA/etc/aziot/identityd/config.d/00-hack.toml
