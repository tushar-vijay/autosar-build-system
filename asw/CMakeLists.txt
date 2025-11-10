# Define a static library target named 'asw_dummy'
# It will be comprised of asw_dummy.c and asw_dummy.h
add_library(asw_dummy asw_dummy.c asw_dummy.h)

# Specify the directory for header lookup when another target links this library
# 'PUBLIC' means anyone that links to this target will also use these include paths
target_include_directories(asw_dummy PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
