#!/bin/bash
sudo chmod -R 775 /home/ubuntu/app/postgres_data
sudo chown -R $(id -u):$(id -g) /home/ubuntu/app/postgres_data
exec "$@"
