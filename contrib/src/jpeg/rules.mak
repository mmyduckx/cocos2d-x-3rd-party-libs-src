# jpeg

JPEG_VERSION := 9d
JPEG_URL := http://www.ijg.org/files/jpegsrc.v$(JPEG_VERSION).tar.gz
# JPEG_URL := http://download.videolan.org/pub/contrib/jpegsrc.v$(JPEG_VERSION).tar.gz

$(TARBALLS)/jpegsrc.v$(JPEG_VERSION).tar.gz:
	$(call download,$(JPEG_URL))

.sum-jpeg: jpegsrc.v$(JPEG_VERSION).tar.gz

jpeg: jpegsrc.v$(JPEG_VERSION).tar.gz .sum-jpeg
	$(UNPACK)
	mv jpeg-$(JPEG_VERSION) jpegsrc.v$(JPEG_VERSION)
	$(UPDATE_AUTOCONFIG)
	$(MOVE)

.jpeg: jpeg
	cd $< && $(HOSTVARS) ./configure $(HOSTCONF) --with-gnu-ld --with-sysroot /Users/xwx/gitWork/cocos2d-x-3rd-party-libs-src/build/android-toolchain-arm/sysroot
	cd $< && $(MAKE) clean && $(MAKE) install V=1
	cd $< && if test -e $(PREFIX)/lib/libjpeg.a; then $(RANLIB) $(PREFIX)/lib/libjpeg.a; fi
	touch $@
