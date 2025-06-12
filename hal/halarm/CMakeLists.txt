
spec2def(hal.dll ../hal.spec ADD_IMPORTLIB)

add_definitions(
    -D_NTHALDLL_
    -D_NTHAL_)

include_directories(
    include
    ${REACTOS_SOURCE_DIR}/ntoskrnl/include)

list(APPEND SOURCES
    generic/beep.c
    generic/bus.c
    generic/cache.S
    generic/display.c
    generic/dma.c
    generic/drive.c
    generic/fmutex.c
    generic/halinit.c
    generic/misc.c
    generic/pic.c
    generic/portio.c
    generic/processor.c
    generic/profil.c
    generic/reboot.c
    generic/rtc.c
    generic/spinlock.c
    generic/sysinfo.c
    generic/timer.c
    generic/usage.c
    omap3/halinit_up.c
    omap3/halup.rc
    versa/halinit_up.c
    versa/halup.rc)

add_library(hal MODULE
    ${SOURCES})

set_module_type(hal kerneldll ENTRYPOINT 0)
