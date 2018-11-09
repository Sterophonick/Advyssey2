extern u32 op_table[256];

extern u32 cycles;
extern u32 lastpc;
extern u8 CPU();
extern void menu();
extern u8 read_PB(u8 p);
extern void write_PB(u8 p, u8 val);
extern u8 read_P2(void);
extern u8 Read(u16 addr);
extern void GetKeypad();
extern void MergeKeyData();
extern void Write(u16 addr, u8 value);
extern u32 op_table[256];