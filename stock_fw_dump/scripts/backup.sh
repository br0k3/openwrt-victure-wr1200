#!/bin/sh
cat /proc/mtd | tail -n+2 | while read; do
  MTD_DEV=$(echo ${REPLY} | cut -f1 -d:)
  MTD_NAME=$(echo ${REPLY} | cut -f2 -d\")
  echo "Backing up ${MTD_DEV} (${MTD_NAME})"
  dd if=/dev/${MTD_DEV}ro of=/tmp/${MTD_DEV}_${MTD_NAME}.backup
done
