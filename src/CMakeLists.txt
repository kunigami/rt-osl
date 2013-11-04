project (RT_OSL)

CMAKE_MINIMUM_REQUIRED(VERSION 2.4.5)

set (CMAKE_BUILD_TYPE Debug)

set(CMAKE_CXX_FLAGS -fno-rtti)

set (CMAKE_MODULE_PATH
     "${PROJECT_SOURCE_DIR}/cmake/modules"
     "${PROJECT_SOURCE_DIR}/cmake")

include (util_macros)
include (oiio)
include (osl)

###########################################################################
# Boost setup

set (Boost_ADDITIONAL_VERSIONS "1.52" "1.51" "1.50" "1.49" "1.48"
                               "1.47" "1.46" "1.45"
                               "1.44" "1.43" "1.42" "1.41" "1.40")
if (LINKSTATIC)
    set (Boost_USE_STATIC_LIBS   ON)
endif ()
set (Boost_USE_MULTITHREADED ON)
if (BOOST_CUSTOM)
    set (Boost_FOUND true)
else ()
    set (Boost_COMPONENTS filesystem regex system thread)
    if (USE_BOOST_WAVE)
        list (APPEND Boost_COMPONENTS wave)
    endif ()

    find_package (Boost 1.40 REQUIRED 
                  COMPONENTS ${Boost_COMPONENTS}
                 )
endif ()

if (VERBOSE)
    message (STATUS "BOOST_ROOT ${BOOST_ROOT}")
    message (STATUS "Boost found ${Boost_FOUND} ")
    message (STATUS "Boost version      ${Boost_VERSION}")
    message (STATUS "Boost include dirs ${Boost_INCLUDE_DIRS}")
    message (STATUS "Boost library dirs ${Boost_LIBRARY_DIRS}")
    message (STATUS "Boost libraries    ${Boost_LIBRARIES}")
endif ()

include_directories (SYSTEM "${Boost_INCLUDE_DIRS}")
link_directories ("${Boost_LIBRARY_DIRS}")

# Tell boost to not use 
if ((CMAKE_COMPILER_IS_GNUCC AND GCC_VERSION VERSION_LESS 4.3)
    OR CMAKE_COMPILER_IS_CLANG)
  add_definitions ("-DBOOST_NO_RTTI")
  add_definitions ("-DBOOST_NO_TYPEID")
endif ()

# end Boost setup
###########################################################################

###########################################################################
# IlmBase setup

# example of using setup_var instead:
#setup_var (ILMBASE_VERSION 1.0.1 "Version of the ILMBase library")
#setup_string (ILMBASE_VERSION 1.0.1
#              "Version of the ILMBase library")
mark_as_advanced (ILMBASE_VERSION)
setup_path (ILMBASE_HOME "${THIRD_PARTY_TOOLS_HOME}"
            "Location of the ILMBase library install")
mark_as_advanced (ILMBASE_HOME)

find_package (IlmBase REQUIRED)

if (ILMBASE_FOUND)
    include_directories ("${ILMBASE_INCLUDE_DIR}")
    include_directories ("${ILMBASE_INCLUDE_DIR}/OpenEXR")
    if (VERBOSE)
        message (STATUS "ILMBASE_INCLUDE_DIR=${ILMBASE_INCLUDE_DIR}")
    endif ()
else ()
    message (STATUS "ILMBASE not found!")
endif ()

macro (LINK_ILMBASE target)
    target_link_libraries (${target} ${ILMBASE_LIBRARIES})
endmacro ()

# end IlmBase setup
###########################################################################


message(STATUS ${OSL_INCLUDES})

include_directories (
  ${OPENIMAGEIO_INCLUDES}
  ${OSL_INCLUDES}
)

add_executable (
  rt_osl testrender.cpp simplerend.cpp
)

target_link_libraries (
  rt_osl ${Boost_LIBRARIES} ${OPENIMAGEIO_LIBRARY} ${OSL_LIBRARY} ${ILMBASE_LIBRARIES}
)

