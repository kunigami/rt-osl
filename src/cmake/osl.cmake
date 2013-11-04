# If home is not defined, try reading from environment
if (NOT OSLHOME)
    if (NOT $ENV{OSLHOME} STREQUAL "")
        set (OSLHOME $ENV{OSLHOME})
    endif ()
endif ()

MESSAGE ( STATUS "OSLHOME = ${OSLHOME}" )

find_library ( OSL_COMP
               NAMES oslcomp
               HINTS ${OSLHOME}
               PATH_SUFFIXES lib
               PATHS ${OSLHOME}/lib )

find_library ( OSL_EXEC
               NAMES oslexec
               HINTS ${OSLHOME}
               PATH_SUFFIXES lib
               PATHS ${OSLHOME}/lib )

find_library ( OSL_EXEC
               NAMES oslexec
               HINTS ${OSLHOME}
               PATH_SUFFIXES lib
               PATHS ${OSLHOME}/lib )

find_library ( OSL_QUERY
               NAMES oslquery
               HINTS ${OSLHOME}
               PATH_SUFFIXES lib
               PATHS ${OSLHOME}/lib )

find_path ( OSL_INCLUDES
            NAMES oslexec.h
            PATHS ${OSLHOME}/include/OSL )

set (OSL_LIBRARY ${OSL_COMP} ${OSL_EXEC} ${OSL_QUERY})


MESSAGE ( STATUS "OSL_LIBRARY = ${OSL_LIBRARY}" )
MESSAGE ( STATUS "OSL_INCLUDES = ${OSL_INCLUDES}" )
