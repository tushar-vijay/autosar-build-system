# Define a static library target named 'cdd_dummy'
# It will be comprised of cdd_dummy.c and cdd_dummy.h
add_library(cdd_dummy cdd_dummy.c cdd_dummy.h)

# Specify the directory for header lookup when another target links this library
# 'PUBLIC' means anyone that links to this target will also use these include paths
target_include_directories(cdd_dummy PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
