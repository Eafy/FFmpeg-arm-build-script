######################################
# Makefile
######################################

TARGET  := libJimiVideoPusher.so

ARCH    := arm
CROSS_COMPILE := arm-buildroot-linux-gnueabi-
AS      := $(CROSS_COMPILE)as
LD      := $(CROSS_COMPILE)ld
CC 	:= $(CROSS_COMPILE)g++

ROOT_PATH := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
#LIBS    := -L$(ROOT_PATH)/lib/ffmpeg/lib -L$(ROOT_PATH)/lib/curl/lib -L$(ROOT_PATH)/lib/x264/lib -L$(ROOT_PATH)/lib/openssl/lib
LIBS    := -L$(ROOT_PATH)/lib/ffmpeg/lib -L$(ROOT_PATH)/lib/lib -L$(ROOT_PATH)/lib/x264/lib
LDFLAGS := -lstdc++ -lssl -lcrypto -lcurl -lx264
DEFINES :=
#INCLUDE := -I$(ROOT_PATH)/lib/ffmpeg/include -I$(ROOT_PATH)/lib/curl/include/curl -I$(ROOT_PATH)/lib/x264/include -I$(ROOT_PATH)/lib/openssl/include/openssl
INCLUDE := -I$(ROOT_PATH)/lib/ffmpeg/include -I$(ROOT_PATH)/lib/inc/curl -I$(ROOT_PATH)/lib/inc/openssl -I$(ROOT_PATH)/lib/x264/include
CFLAGS  := -s -g -Wall -O3 -pthread $(DEFINES) $(INCLUDE)
CXXFLAGS:= $(CFLAGS) -DHAVE_CONFIG_H -std=c++11 -Wno-unknown-pragmas #-Wunused-variable -Wformat-zero-length
SHARE   := -fPIC -shared -o

ALLDIRS := $(shell ls -R | grep '^\./src/.*:$$' | awk '{gsub(":",""); print}')
SOURCES := $(foreach n,$(ALLDIRS),$(wildcard $(n)/*.c) $(wildcard $(n)/*.cpp))
SRC_INC := $(foreach n,$(ALLDIRS),-I$(wildcard $(n)))
OBJS    := $(patsubst %.c,%.o,$(patsubst %.cpp,%.o,$(wildcard $(SOURCES))))

COMPILE = $(CC) $(CXXFLAGS) -c -fPIC $< -o $@  $(INCLUDE) $(SRC_INC)

.PHONY: everything objs clean veryclean rebuild

everything: $(TARGET)

all: $(TARGET)

rebuild: veryclean everything

clean:
	rm -fr $(OBJS)

cleanall: clean
	rm -fr $(TARGET)

rmOpenGL:
	rm -f $(ROOT_PATH)/src/CCrossTool/CJsonObject/cJSON.*
	rm -rf $(ROOT_PATH)/src/CCrossTool/OpenGL

shModifyFFmpegError:
	./sh_modify_ffmpeg_error.sh

%.o: %.c
	$(COMPILE)

%.o: %.cpp
	$(COMPILE)

$(TARGET): shModifyFFmpegError rmOpenGL $(OBJS)
	$(CC) $(CXXFLAGS) $(SHARE) $@ $(OBJS) $(LDFLAGS) $(LIBS)
