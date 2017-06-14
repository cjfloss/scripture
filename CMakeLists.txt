project (biblenow)

cmake_minimum_required (VERSION 2.6)

list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/src)

set (DATADIR "${CMAKE_INSTALL_PREFIX}/share")

set (PKGDATADIR "${DATADIR}/biblenow")

set (EXEC_NAME "biblenow")
set (RELEASE_NAME "nightly")
set (VERSION "0.1")
set (VERSION_INFO "just testing")

find_package(PkgConfig)

pkg_check_modules(DEPS REQUIRED gtk+-3.0 granite webkit2gtk-4.0)

add_definitions(${DEPS_CFLAGS})
link_libraries(${DEPS_LIBRARIES})
link_directories(${DEPS_LIBRARY_DIRS})

find_package(Vala REQUIRED)
include(ValaVersion)
ensure_vala_version("0.16" MINIMUM)

include(ValaPrecompile)
vala_precompile(VALA_C ${EXEC_NAME}
   src/Main.vala
   src/Window.vala
   src/Widgets/ChapterSelect.vala
   src/Widgets/BookSelect.vala
   src/Widgets/BibleReadView.vala
   src/Widgets/ParallelView.vala
   src/Widgets/Styles/View.vala
   src/Widgets/Styles/App.vala
   src/Model/Verse.vala

PACKAGES
   gtk+-3.0
   gee-0.8
   granite
   webkit2gtk-4.0
)

add_executable(${EXEC_NAME} ${VALA_C})

install (TARGETS ${EXEC_NAME} RUNTIME DESTINATION bin)

install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/biblenow.desktop DESTINATION ${DATADIR}/applications/)
