HEADERS =
OBJECTS = build/main.o build/cpu.o build/keypad.o build/lang.o build/menu.o build/mem.o build/sprite.o build/video.o build/vpp.o
CPPFILES =
# SOURCES = src/main.c src/mem.c src/cpu.c src/hardware.c src/keypad.c
ASM =
CFLAGS = -DHRT_WITH_LIBHEART -Wall -Ofast -march=armv4t -Wno-switch -Wno-multichar -ffast-math -mlong-calls -mcpu=arm7tdmi -mtune=arm7tdmi -marm -faggressive-loop-optimizations -fverbose-asm 
ARCH = -mthumb -mthumb-interwork
SPECS = -specs=gba.specs
PREFIX = C:\devkitPro\devkitARM\bin\arm-none-eabi-

default: advyssey2.gba

build/%.o: src/%.c $(HEADERS)
	$(PREFIX)gcc $(CFLAGS) -Iinc $(ARCH) -c $< -o $@
	
build/%.o: src/%.cpp $(HEADERS)
	$(PREFIX)g++ $(CFLAGS) $(ARCH) -c $< -o $@
	
build/%.out: src/%.s
	$(PREFIX)as  -mthumb -mthumb-interwork -mcpu=arm7tdmi $< -o $@
	
build/main.elf: $(OBJECTS)
	$(PREFIX)gcc $(SPECS) $(ARCH) $(OBJECTS) -lheart -lm -o build/main.elf
	
advyssey2.gba: build/main.elf
	$(PREFIX)objcopy -O binary build/main.elf advyssey2.gba
	C:/devkitPro/devkitARM/bin/gbafix advyssey2.gba -tODYSSEY2 -cO2AU -v1
	

clean:
	-rm build/*.o build/*.out build/main.elf
	-rm advyssey2.gba