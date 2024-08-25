define Device/victure_wr1200
  $(Device/dsa-migration)
  IMAGE_SIZE := 6475317
  DEVICE_VENDOR := Victure
  DEVICE_MODEL := WR1200
  DEVICE_PACKAGES := kmod-mt7603 kmod-mt7615e kmod-mt7663-firmware-ap
endef
TARGET_DEVICES += victure_wr1200