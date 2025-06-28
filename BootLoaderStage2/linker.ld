
ENTRY(boot_loader_stage2);

MEMORY
{
    FLASH(rx) : ORIGIN = 0x10000000, LENGTH = 2048k
    SRAM(rwx) : ORIGIN = 0x20000000, LENGTH = 256k
}

SECTIONS
{
    .boot :
    {
        *(.bootStage2)
        . = ORIGIN(FLASH) + 252;
        *(.crc)
    } > FLASH AT>FLASH

    .text :
    {
        *(.text)
    } > FLASH AT>FLASH
}