#!/usr/bin/env python2

import os
import sys
import time
import shutil
import hashlib
import copy
import difflib

def print_error(message):
    print >> sys.stderr, '\033[91m' + message + '\033[0m'


def print_success(message):
    print '\033[92m' + message + '\033[0m'


# Removes the string liteal ending from the string thestring only if thestring ends with ending
# Eg: rchop('.vimrc.symlink', '.symlink') #> '.vimrc'
def rchop(thestring, ending):
    if thestring.endswith(ending):
        return thestring[:-len(ending)]
    return thestring


# List files and directories ending with the name extension.
# Used to list files and directories matching *.symlink and *.copy
def list_files(rootdir, extension):
    result = []
    for root, directories, files in os.walk(rootdir):
        files.extend(directories)
        for f in files:
            if f.endswith(extension):
                result.append(os.path.join(root, f))
    return result


# Prefixes dot at the beginning
def dot_it(thestring):
    return '.' + thestring


# Returns destination path of the *.symlink and *.copy files(or directories)
# Eg: get_dotfile_destination('/home/nikhil/dotfiles/zsh/zshrc.copy') #> '/home/nikhil/.zshrc'
def dotfile_destination(source):
    home_dir = os.path.normpath(os.getenv("HOME"))

    if source.endswith('.symlink'):
        return os.path.join(home_dir, dot_it(os.path.basename(rchop(source, '.symlink'))))
    elif source.endswith('.copy'):
        return os.path.join(home_dir, dot_it(os.path.basename(rchop(source, '.copy'))))


# Creates a directory if not exists
def create_directory_if_required(pathstr):
    if os.path.exists(pathstr) and not os.path.isdir(pathstr):
        raise Exception('Cannot create directory because a file with similar name exist')
    elif not os.path.exists(pathstr):
        os.mkdir(pathstr)


# Copy file/directory
# Copying file and directory use different methods in python
# This method provides common interface for copying both files and directories
def copy(source, destination):
    if os.path.isfile(source):
        shutil.copyfile(source, destination)
    else:
        shutil.copytree(source, destination)


def file_hex_digest(filepath):
    # Open File
    file_object = open(filepath)

    # Calculate hex digest using sha1
    hexdigest = hashlib.sha1(file_object.read()).hexdigest()

    # Important: Explicitly close file.
    # Relying on destructor doesn't guarantee closing of file
    file_object.close()

    return  hexdigest


# Backups existing dotfiles into timestamped directory inside ~/dotfiles_backup/
def backup_existing_dot_files(files):
    home_dir = os.path.normpath(os.getenv("HOME"))

    # ~/dotfiles_backup directory
    dotfiles_backup_dir = os.path.join(home_dir, 'dotfiles_backup')

    # Determine backup directory to for backing up existing files
    # Backed up into ~/dotfiles_backup/{timestamp}
    timestamped_backup_dir = os.path.join(dotfiles_backup_dir, time.strftime('%d-%b-%y at %H.%M hours'))

    for f in files:
        existing_file = dotfile_destination(f)
        if os.path.islink(existing_file):
            os.remove(existing_file)
        elif os.path.isfile(existing_file) or os.path.isdir(existing_file):

            existing_file_backup_path = os.path.join(timestamped_backup_dir, os.path.basename(existing_file))

            # Only backup if files are different
            file_digest = file_hex_digest(f)
            existing_file_digest = file_hex_digest(existing_file)

            if not (file_digest == existing_file_digest):
                # Create ~/dotfiles_backup
                create_directory_if_required(dotfiles_backup_dir)

                # Create timestamped backup directory, if there is atleast one file to backup
                create_directory_if_required(timestamped_backup_dir)

                # Print info about backup
                print('Backing up ' + existing_file + ' into ' + existing_file_backup_path)

                # Move existing file to the timestamped_backup_dir
                shutil.move(existing_file, existing_file_backup_path)


def install_precondition(home_dir):

    # Check if ~/dotfiles directory exist
    dotfiles_dir = os.path.join(home_dir, 'dotfiles')
    if not os.path.exists(dotfiles_dir) and os.path.isdir(dotfiles_dir):
        print_error("This script requires repository to be cloned in home directory. Exiting...")

    # Check if ~/dotfiles_backup is not a directory if it exist
    dotfiles_backup_dir = os.path.join(home_dir, 'dotfiles_backup')
    if os.path.exists(dotfiles_backup_dir) and not os.path.isdir(dotfiles_backup_dir):
        print_error("A file named ~/dotfiles_backup exist. Delete/Rename that file. Exiting...")

def handle_special_files():
    home_dir = os.path.normpath(os.getenv("HOME"))
    dotfiles_dir = os.path.join(home_dir, 'dotfiles')
    source = os.path.join (dotfiles_dir, 'osx/com.github.nikhildamle.dotfiles.environment.plist')
    destination = os.path.join(home_dir, 'Library/LaunchAgents/')
    shutil.copy(source, destination)
    
def install_dotfiles():
    home_dir = os.path.normpath(os.getenv("HOME"))
    dotfiles_dir = os.path.join(home_dir, 'dotfiles')

    # Check if installation precondition match
    install_precondition(home_dir)

    filestosymlink = list_files(dotfiles_dir, '.symlink')
    filestocopy = list_files(dotfiles_dir, '.copy')

    # Create an array of both *.symlink and *.copy files
    filestobackup = filestosymlink[:]

    # Calling backup only once puts all backup files in same directory
    # If called multiple times, it might not be the case if time changes between calls
    backup_existing_dot_files(filestobackup)

    # Create symlink in home directory for files ending with .symlink
    for f in filestosymlink:
        destination = dotfile_destination(f)
        os.symlink(f, destination)
        print_success("Symlinking " + f + " => " + destination)


    # Copy into home directory for the files/directories matching .copy
    for f in filestocopy:
        destination = dotfile_destination(f)
        if os.path.exists(destination):
            existing_file = open(destination)
            f_to_copy = open(f)
            if not(f_to_copy.read() in existing_file.read()):
                print_error("File " + destination + " already exist. Manual merge might be required")
            existing_file.close()
            f_to_copy.close()
        else:
            copy(f, dotfile_destination(f))
            print_success("Copying " + f + " => " + destination)
    
    # Handle Special Files
    handle_special_files()

# Run script
install_dotfiles()
