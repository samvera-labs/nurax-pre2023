#!/bin/sh

echo "Building ${RAILS_ENV}"

# Remove previous servers pid
rm -f tmp/puma.pid

# Guarantee gems are installed in case docker image is outdated
./build/install_gems.sh

# Do not auto-create SOLR or Migrations for production or staging environments
if [ "${RAILS_ENV}" != 'production' ] && [ "${RAILS_ENV}" != 'staging' ]; then
  ./build/create_solr_index.sh
  ./build/validate_migrated.sh
fi

