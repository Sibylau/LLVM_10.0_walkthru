add_library(MyPass MODULE
    loop_tracing.cpp)

target_compile_features(MyPass PRIVATE cxx_range_for cxx_auto_type)

set_target_properties(MyPass PROPERTIES COMPILE_FLAGS "-fno-rtti")
