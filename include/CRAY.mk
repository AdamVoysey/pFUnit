export FUFLAGS=-markers

F90 ?=ftn
MPIF90 ?= ftn

I=-I
M=-I
L=-L

# Cray compiler only exists on Cray machines so no Windows support.
FFLAGS += -G0 -K trap=fp,unf

# Cray compiler defaults to using OpenMP, so we must explicitly
# turn it off if we don't want it.
ifeq ($(USEOPENMP),YES)
FFLAGS += -homp
LIBS += -homp
else
FFLAGS += -hnoomp
LIBS += -hnoomp
endif


# Common command line options.

F90_PP_ONLY = -eP
F90_PP_OUTPUT =; mv "$$(basename $${i} .F90).i"
