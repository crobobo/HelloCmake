# HelloCmake

>[官方教程](https://cmake.org/cmake/help/latest/guide/tutorial/index.html)

## 命令行参数

```
Options
  -S <path-to-source>          = 指定目录：源文件位置（CMakeLists.txt在此目录内）
  -B <path-to-build>           = 指定目录：构建文件的生成位置
  -D <var>[:<type>]=<value>    = 指定宏变量
  -G <generator-name>          = 指定构建器
  -A <platform-name>           = 指定平台
  -E                           = 命令行模式
```

## Hello

### Tree

- Project Directory
  - `CMakeLists.txt`
  - `main.c`

### `main.c`

```c
#include <stdio.h>

int main() {
    printf("Hello, World!\n");
    return 0;
}
```

### `CMakeLists.txt`

```cmake
# cmake版本要求
cmake_minimum_required(VERSION 3.10)

# 编译标准
set(CMAKE_C_STANDARD 99)

# 项目名称
project(HelloCmakeProject)

# 执行文件
add_executable(Hello main.c)
```

### Build

#### 方案一：[Cygwin](https://cygwin.com/install.html)

>添加包：gcc-g++、make、cmake、gdb
>添加环境：`..\Cygwin\bin`

```bash
cmake -G "CodeBlocks - Unix Makefiles" -B build-cygwin -S .
pushd build-cygwin; make; ./Hello; popd
# 必须在Cygwin环境下运行
```

#### 方案二：[Mingw-w64](https://sourceforge.net/projects/mingw-w64/files/mingw-w64/)、[CMake](https://cmake.org/download/)（推荐）

>添加环境：`..\mingw-w64\x86_64-${version}-posix-seh-${subversion}\mingw64\bin`
>添加环境：`..\cmake\cmake-${version}-win64-x64\bin`

```batch
cmake -G "CodeBlocks - MinGW Makefiles" -B build-mingw -S .
pushd build-mingw && mingw32-make && .\Hello.exe && popd
```

## 变量

### 消息打印

```cmake
message("message none")
message(STATUS "message status")
message(WARNING "message warn")
message(AUTHOR_WARNING "message warn(dev)")
message(SEND_ERROR "message error(continue)")
message(FATAL_ERROR "message error(stop)")
```

### 变量声明

```cmake
# 变量定义
set(USER_KEY "Hello")
message("USER_KEY = ${USER_KEY};")

# 变量内容追加（set）
set(USER_KEY ${USER_KEY} "First")
message("USER_KEY = ${USER_KEY};")

# 变量内容追加（list）
list(APPEND USER_KEY "Second")
message("USER_KEY = ${USER_KEY};")

# 删除变量的值
list(REMOVE_ITEM USER_KEY "First")
message("USER_KEY = ${USER_KEY};")
```

## 特殊变量

### 魔术变量

```cmake
message("CMAKE_CURRENT_LIST_DIR=${CMAKE_CURRENT_LIST_DIR}")
message("CMAKE_CURRENT_LIST_LINE=${CMAKE_CURRENT_LIST_LINE}")
```

### 输出路径

```cmake
message("EXECUTABLE_OUTPUT_PATH=${EXECUTABLE_OUTPUT_PATH}")
message("LIBRARY_OUTPUT_PATH=${LIBRARY_OUTPUT_PATH}")
```

### 项目变量

```cmake
message("CMAKE_CURRENT_SOURCE_DIR=${CMAKE_CURRENT_SOURCE_DIR}")
message("CMAKE_CURRENT_BINARY_DIR=${CMAKE_CURRENT_BINARY_DIR}")

project(MyProjectName) # 该方法将自动引入以下四个变量
message("001=${PROJECT_BINARY_DIR}")
message("002=${PROJECT_SOURCE_DIR}")
message("003=${MyProjectName_BINARY_DIR}")
message("004=${MyProjectName_SOURCE_DIR}")
message("005=${PROJECT_NAME}")
```

### 环境变量

```cmake
# 读取环境变量
message("PATH=$ENV{PATH}")

# 设置环境变量
set(ENV{PATH} "C:\\;D\\")
message("PATH=$ENV{PATH}")
```

### 系统信息

```cmake
# CMAKE版本号
message("CMAKE_MAJOR_VERSION=${CMAKE_MAJOR_VERSION}")
message("CMAKE_MINOR_VERSION=${CMAKE_MINOR_VERSION}")
message("CMAKE_PATCH_VERSION=${CMAKE_PATCH_VERSION}")

# 系统信息
message("CMAKE_SYSTEM=${CMAKE_SYSTEM}")
message("CMAKE_SYSTEM_NAME=${CMAKE_SYSTEM_NAME}")
message("CMAKE_SYSTEM_VERSION=${CMAKE_SYSTEM_VERSION}")
message("CMAKE_SYSTEM_PROCESSOR=${CMAKE_SYSTEM_PROCESSOR}")

# 平台
message("UNIX=${UNIX}")
message("WIN32=${WIN32}")
```

### 编译参数

```cmake
# 控制默认的库编译方式（不设置默认编译为静态库）
# SET(BUILD_SHARED_LIBS ON)
# SET(BUILD_STATIC_LIBS ON) #（默认）
message("BUILD_SHARED_LIBS=${BUILD_SHARED_LIBS}")

# C/C++编译参数
message("CMAKE_C_FLAGS=${CMAKE_C_FLAGS}")
message("CMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}")
```

## 引入文件

### CMAKE文件

```cmake
include(./common.cmake) # 指定包含文件的全路径
include(common)         # 在搜索路径中搜索common.cmake文件
```

### 库文件

```cmake
# 指定库文件的搜索路径
link_directories(${library_directory} ...)

# 将指定源文件编译成库，并添加到项目中
add_library(${library_name} [SHARED|STATIC] ${source_file} ...)

# 导入库
target_link_libraries(${library_file} ...)
```

### 头文件

```cmake
# 指定头文件搜索路径
include_directories("${header_directory}" ...)
```

## 编程语法

### 简单条件

#### if

```cmake
# if(expression)
# expression 不为空（0,N,NO,OFF,FALSE,NOTFOUND）时为真
if (0)
    message("11")
    message("12")
elseif(1)
    message("21")
    message("22")
else()
    message("31")
    message("32")
endif ()
```

#### switch

```cmake
option (switch_test1 "开关测试1" ON)
if (switch_test1)
    message("On")
else()
    message("Off")
endif ()

option (switch_test2 "开关测试2" OFF)
if (switch_test2)
    message("On")
else()
    message("Off")
endif ()
```

### 高级条件

#### 逻辑运算

```cmake
# 与或非
if (1 AND 1)
    message("1 and")
endif ()
if (0 OR 1)
    message("1 or")
endif ()
if (NOT 0)
    message("1 not")
endif ()
```

#### 存在性判断

```cmake
# 变量是否定义
set(DEFINED_VARIABLE 0)
if (DEFINED DEFINED_VARIABLE)
    message("1 def")
endif ()
if (DEFINED UNDEFINED_VARIABLE)
    message("1 undef")
endif ()
set(DEFINED_VARIABLE 1)
if (DEFINED DEFINED_VARIABLE AND DEFINED_VARIABLE)
    message("1 def vaild")
endif ()

# 命令是否存在
if (COMMAND set)
    message("1 set")
endif()
```

#### 文件系统判断

```cmake
# 文件或目录是否存在
if (EXISTS "C:\\Windows\\notepad.exe")
    message("1 exist")
endif()

# 是否是目录
if (IS_DIRECTORY "C:\\Windows")
    message("1 dir")
endif()

# 哪个更新
if ("C:\\Windows\\notepad.exe" IS_NEWER_THAN "C:\\Windows\\notepad2.cmd")
    message("1 newer")
else()
    message("2 newer")
endif()
```

#### 值比较

```cmake
# 数字大小比较
if(123 EQUAL 123)
    message("1 equal")
endif ()
if(123 LESS 666)
    message("1 less")
endif ()
if(123 GREATER 55)
    message("1 greater")
endif ()

# 字符串比较
if("123" STREQUAL "123")
    message("1 equal")
endif ()
if("12" STRLESS "166")
    message("1 less")
endif ()
if("2" STRGREATER "199")
    message("1 greater")
endif ()
```

### 循环

```cmake
# range循环
foreach(i RANGE 0 10 2)
    message("i=${i}")
endforeach(i)

# while循环
while(condition)
    ...
endwhile()
```

## 文件搜索

### 源文件搜索

```cmake
# 搜索当前路径下所有源文件放到变量中去（以';'分割）
aux_source_directory(. SRC_LIST)
message("SRC_LIST=${SRC_LIST}")
```

### 自定义搜索规则

```cmake
file(GLOB SRC_LIST "*.c" "lib/*.c" ...)
message("SRC_LIST=${SRC_LIST}")
```

