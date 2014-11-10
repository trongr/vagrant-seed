#!/usr/bin/env bash

echo "these modules should already be here, so you probably don't need to run this.---trong"

pp="puppet module install --modulepath ./modules"

$pp puppetlabs-mongodb
