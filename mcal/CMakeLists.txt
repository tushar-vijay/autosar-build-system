# Define a static library target named 'mcal_dummy'
# It will be comprised of mcal_dummy.c and mcal_dummy.h
add_library(mcal_dummy mcal_dummy.c mcal_dummy.h)

# Specify the directory for header lookup when another target links this library
# 'PUBLIC' means anyone that links to this target will also use these include paths
target_include_directories(mcal_dummy PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
