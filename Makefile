ARCHS = arm64 arm64e
TARGET := iphone:clang:latest:15.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SwiftGramSaver
SwiftGramSaver_FILES = Tweak.x
SwiftGramSaver_CFLAGS = -fobjc-arc

include $(THEOS)/makefiles/tweak.mk
