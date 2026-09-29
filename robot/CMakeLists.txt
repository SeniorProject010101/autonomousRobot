cmake_minimum_required(VERSION 3.16)

project(coreSystem LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_executable(coreSystem
    main.cpp
    core/base/systemBase.cpp
    core/connection/connection.cpp
    core/logic/logic.cpp
)

target_include_directories(coreSystem PRIVATE
    core/headers
)