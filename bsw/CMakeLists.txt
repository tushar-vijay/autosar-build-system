# Define a static library target named 'bsw_dummy'
# It will be comprised of bsw_dummy.c and bsw_dummy.h
add_library(bsw_dummy bsw_dummy.c bsw_dummy.h)

# Specify the directory for header lookup when another target links this library
# 'PUBLIC' means anyone that links to this target will also use these include paths
target_include_directories(bsw_dummy PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
