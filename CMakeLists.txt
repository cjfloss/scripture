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

pkg_check_modules(DEPS REQUIRED
                  gtk+-3.0
                  gee-0.8
                  granite
                  webkit2gtk-4.0>=2.14.1
                  sqlite3>=3.5.9
                 )

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
   src/Model/Bible.vala
   src/Model/Language.vala
   src/Model/Book.vala
   src/Model/BookPrototype.vala
   src/Model/QueryBuilder.vala
   src/Model/Transaction.vala
   src/Model/Database.vala

PACKAGES
   gtk+-3.0
   gee-0.8
   granite
   webkit2gtk-4.0>=2.14.1
   sqlite3
)

add_executable(${EXEC_NAME} ${VALA_C})

install (TARGETS ${EXEC_NAME} RUNTIME DESTINATION bin)

install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/biblenow.desktop DESTINATION ${DATADIR}/applications/)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/icons/48/biblenow.svg DESTINATION share/icons/hicolor/48x48/apps)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/icons/64/biblenow.svg DESTINATION share/icons/hicolor/64x64/apps)
