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
        '-I', '.',
        '-I', '/usr/include',
        '-I', '/usr/local/include'
        ]

SOURCE_EXTENSIONS = [
        '.cpp',
        '.cxx',
        '.cc',
        '.c'
        ]

C_SOURCE_EXTENSIONS = [
        '.c'
        ]

CPP_SOURCE_EXTENSIONS = [
        '.cc',
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
        'src',
        'googletest/googletest/include'
        ]

CPP_SYSTEM_INCLUDE = [
        '-I',
        '/usr/include/c++/7',
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

def getIncludeFlags(root, filename):
    include_flags = [];

    # find nearest dir in HEADER_DIRECTORIES
    for dirname in HEADER_DIRECTORIES:
        include_path = findNearest(root, dirname)
        if include_path:
            include_flags = include_flags + ['-I', include_path, '-isystem', include_path];

    return include_flags;

def getLanguageFlags(filename):
    if isCSourceFile(filename):
        return ['-x', 'c','-std=c99']
    elif isCPPSourceFile(filename):
        return ['-x', 'c++', '-std=c++11'] + CPP_SYSTEM_INCLUDE
    elif isHeaderFile(filename):
        return ['-x', 'c++', '-std=c++11'] + CPP_SYSTEM_INCLUDE
    else:
        return None


def FlagsForFile(filename):
    root = os.path.dirname(os.path.realpath(filename));

    include_flags = getIncludeFlags(root, os.path.basename(filename));
    language_flags = getLanguageFlags(filename);

    final_flags = BASE_FLAGS;
    if language_flags:
        final_flags = final_flags + language_flags
    if include_flags:
        final_flags = final_flags + include_flags
    return {
            'flags': final_flags
            }
