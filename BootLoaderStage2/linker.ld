
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
        *(.vector)
        *(.text)
        *(.rodata)
        . = ALIGN(4); 
    } > FLASH AT>FLASH


    /*
        SRAM address start with 0x20000000
        FLASH address start with 0x1000000 + SIZEOF(.boot + .text)
    */

    .data :
    {
        
        *(.data)

    } >SRAM AT>FLASH


    .bss :
    {
       
        *(.bss)

    } > SRAM AT>SRAM


    .stack (NOLOAD) :
    {
        . = ORIGIN(SRAM) + LENGTH(SRAM);
        _sstack = .;
    } >SRAM AT> SRAM

}

    /* Get LMA and VMA for .data section */

    _sdata = ADDR(.data);               /* Get starting LMA */
    _edata = _sdata + SIZEOF(.data);    /* Get ending LMA */
    _sdataram = LOADADDR(.data);          /* Get starting VMA */

    /* Get start and end of .bss section */

    _sbss = ADDR(.bss);                 /* Get starting LMA */
    _ebss = _sbss + SIZEOF(.bss);       /* Get ending LMA */