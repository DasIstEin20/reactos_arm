include_directories(inc)

add_asm_files(armllb_asm boot.s)

list(APPEND ARMLLB_SRC
    crtsupp.c
    envir.c
    fw.c
    main.c
    os/loader.c
    hw/keyboard.c
    hw/matrix.c
    hw/serial.c
    hw/time.c
    hw/video.c
    hw/omap3-beagle/hwinfo.c
    hw/omap3-beagle/hwinit.c
    hw/omap3-beagle/hwuart.c
    hw/omap3-zoom2/hwinfo.c
    hw/omap3-zoom2/hwinit.c
    hw/omap3-zoom2/hwlcd.c
    hw/omap3-zoom2/hwsynkp.c
    hw/omap3-zoom2/hwtwl40x.c
    hw/omap3-zoom2/hwuart.c
    hw/versatile/hwclcd.c
    hw/versatile/hwinfo.c
    hw/versatile/hwinit.c
    hw/versatile/hwkmi.c
    hw/versatile/hwuart.c)

add_executable(armllb ${armllb_asm} ${ARMLLB_SRC})
set_target_properties(armllb PROPERTIES SUFFIX ".bin")
add_dependencies(armllb asm)
