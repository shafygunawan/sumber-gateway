#!/bin/bash

sudo docker network create sumber-network || true # Buat jika belum ada
sudo docker-compose up -d
