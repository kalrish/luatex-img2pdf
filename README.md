# luatex-img2pdf
LuaTeX-based image-to-PDF converter

Convert any image supported by LuaTeX into a PDF, with the fine-tuned PDF-handling capabilities of LuaTeX and without any other format or tool.


##  Usage

    $  luatex-img2pdf [OPTIONS]... [--] INPUT_IMAGE [OUTPUT_PDF]

| Option                              | Description
| ----------------------------------- | -------------------------------------------------------------------------------
| --pdf-minor-version=_n_             | Set the PDF minor version. _n_ must be a nonnegative integer.
| --pdf-compression-level=_n_         | Control the overal compression level of the resulting PDF. _n_ is a nonnegative integer from 0 to 9. 6 seems to be a good compromise between size and speed.
| --pdf-object-compression-level=_n_  | Control the compression level to be applied to PDF objects. _n_ is a nonnegative integer from 0 to 9. Any level of compression (that is, from 1 up) requires a PDF minor version of at least 5. Doesn't seem to have any effect on speed or size, though. Resulting PDFs probably have few and small objects.
| --extra-lua-code _code_             | Run arbitrary Lua code at the end of the run.
| --extra-lua-file=_path_             | Load Lua code from a file and run it at the end of the run.


##  Installation

The build and testing steps are handled by the Tup build system.

###  Configuration
Configuration options are specified in a `tup.config` file. The provided example contains a description of the different options.

###  Build and tests
The build and testing steps are handled together by Tup and follow the standard procedure, that is:

    $  tup

Tests will be run only if selected in the configuration.

####  Requirements

 -  Tup
 -  LuaTeX
 -  GNU Bash on systems other than Windows

Additionally, on non-Windows:

 -  cp, from GNU coreutils, or similar

###  Installation

A helper Bash script is provided for the task of installing the files which are meant to be installed. It should work on all systems.

####  Requirements

 -  GNU Bash

	Version 4.4.12 works.

 -  install and rm, from GNU coreutils, or similar

	The ones provided by GNU coreutils 8.26 work.

####  Options
Options controlling the installation process are passed to the script as environment variables.

| Option                           | Description
| -------------------------------- | -------------------------------------------------------------------------------
| `DESTDIR`                        | Allows for staged installs.
| `LUA_INITIALIZATION_SCRIPT_DIR`  | LuaTeX initialization script location. Should be the same as the `LUATEXDIR` environment variable. The option is provided to cope with Windows paths.
| `FORMAT_DIR`                     | LuaTeX format location. Should be the same as the configuration option. The option is provided to cope with Windows paths.
| `BINDIR`                         | Shell programs location.

As an example:

    $  DESTDIR='stage_install/' LUA_INITIALIZATION_SCRIPT_DIR='/path/to/lua/initialization/scripts' FORMAT_DIR='/path/to/luatex/formats' TARGET_OS= BASH_PATH='/path/to/bash' BINDIR='/bin' bash --noprofile --norc -- install.bash


##  Motivation

While working on a document which included many images, I noticed that LuaTeX took a lot of time to include each PNG, whereas PDF versions of the same pictures were included much faster. I thus looked for programs which could convert PNGs to PDFs while also being able to be executed by a build system. The build system requirement came from the desire to automatize the conversion process. This excluded the many web tools out there, leaving the popular tool `convert`, provided by ImageMagick. I didn't have it installed, however, and had an idea to accomplish it using just LuaTeX.