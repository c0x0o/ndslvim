import os
import os.path
import fnmatch
import logging
import ycm_core
import re

BASE_FLAGS = [
        '-Wall',
        '-Wextra',
        '-Werror',
        '-Wno-long-long',
        '-Wno-variadic-macros',
        '-fexceptions',
        '-ferror-limit=10000',
        '-DNDEBUG',
        '-isystem',
        '/usr/include/',
        '-isystem',
        '/usr/lib/',
        '-I',
        '.'
        ]

SOURCE_EXTENSIONS = [
        '.cpp',
        '.cxx',
        '.cc',
        '.c'
        ]

C_SOURCE_EXTENSIONS = [
        '.cc',
        '.c'
        ]

CPP_SOURCE_EXTENSIONS = [
        '.cpp',
        '.cxx'
        ]

SOURCE_DIRECTORIES = [
        'src',
        'lib'
        ]

HEADER_EXTENSIONS = [
        '.h',
        '.hxx',
        '.hpp',
        '.hh'
        ]

HEADER_DIRECTORIES = [
        'include',
        'src'
        ]

BUILD_DIRECTORY = 'build';

def isHeaderFile(filename):
    ext = os.path.splitext(filename)[1]
    return ext in HEADER_EXTENSIONS

def isCSourceFile(filename):
    ext = os.path.splitext(filename)[1];
    return ext in C_SOURCE_EXTENSIONS;

def isCPPSourceFile(filename):
    ext = os.path.splitext(filename)[1];
    return ext in CPP_SOURCE_EXTENSIONS;

def findNearest(path, target):
    candidate = os.path.join(path, target)
    if(os.path.isfile(candidate) or os.path.isdir(candidate)):
        return candidate;

    parent = os.path.dirname(os.path.abspath(path));
    if(parent == path):
        return None

    return findNearest(parent, target)

def getModuleIncludeFlags(module_root):
    flags = [];

    for dirname in os.listdir(module_root):
        if dirname in HEADER_DIRECTORIES:
            flags = flags + ['-I', os.path.join(module_root, dirname)];

    return flags;


def getIncludeFlags(root, filename):
    include_flags = [];

    # find nearest dir in HEADER_DIRECTORIES
    for dirname in HEADER_DIRECTORIES:
        include_path = findNearest(root, dirname)
        if include_path:
            include_flags = include_flags + ['-I', include_path];

    # collection third party include info
    for dirname in os.listdir(root):
        if (os.path.isdir(dirname)):
            include_flags = include_flags + getModuleIncludeFlags(os.path.join(root, dirname))

    return include_flags;

def getLanguageFlags(filename):
    if isCSourceFile(filename):
        return ['-xc', '-std=c99']
    elif isCPPSourceFile(filename):
        return ['-xc++', '-std=c++11']
    else:
        return None;


def FlagsForFile(filename):
    root = os.path.dirname(os.path.realpath(filename));

    include_flags = getIncludeFlags(root, filename);
    language_flags = getLanguageFlags(filename);

    final_flags = BASE_FLAGS;
    if language_flags:
        final_flags = final_flags + language_flags
    if include_flags:
        final_flags = final_flags + include_flags
    return {
            'flags': final_flags,
            'do_cache': True
            }
