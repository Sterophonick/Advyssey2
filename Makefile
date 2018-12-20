HEADERS =
OBJECTS = build/main.o build/mcs48.o build/menu.o build/lang.o build/keypad.o build/mcs48.out build/video.o build/memory.o
CPPFILES =
# SOURCES = src/main.c src/mem.c src/cpu.c src/hardware.c src/keypad.c
ASM =
CFLAGS = -DHRT_WITH_LIBHEART -Wall -Ofast -march=armv4t -Wno-switch -Wno-multichar -ffast-math -mlong-calls -mcpu=arm7tdmi -mtune=arm7tdmi -marm -faggressive-loop-optimizations -fverbose-asm 
ARCH =  -mthumb-interwork
SPECS = -specs=gba_mb.specs
PREFIX = C:\devkitPro\devkitARM\bin\arm-none-eabi-

default: advyssey2.gba

build/%.o: src/%.c $(HEADERS)
	$(PREFIX)gcc $(CFLAGS) -mthumb -Iinc $(ARCH) -c $< -o $@
	
build/%.o: src/%.cpp $(HEADERS)
	$(PREFIX)g++ $(CFLAGS) $(ARCH) -c $< -o $@
	
build/%.out: src/%.s
	$(PREFIX)as -mthumb-interwork -mcpu=arm7tdmi $< -o $@
	
build/main.elf: $(OBJECTS)
	$(PREFIX)gcc $(SPECS) -mthumb $(ARCH) $(OBJECTS) -lheart -lm -o build/main.elf
	
advyssey2.gba: build/main.elf
	$(PREFIX)objcopy -O binary build/main.elf advyssey2.gba
	C:/devkitPro/devkitARM/bin/gbafix advyssey2.gba -tadvyssey2 -cC8AU -v1
	

clean:
	-rm build/*.o build/*.out build/main.elf
	-rm advyssey2.gba