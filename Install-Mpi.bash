#!/bin/bash

# Runs this script as root if it is not root.
function run_as_root() {
  if [ "$(whoami)" != "root" ]; then
    echo "This script is not running as root"
    echo "Elevating privileges..."
    if [ "$(command -v sudo)" ]; then
      sudo bash "$0"
      exit $?
    else
      echo "Sudo is not installed"
      exit 1
    fi
  fi
}

# Running as root
run_as_root

# Installing MPI
dnf install --assumeyes openmpi
dnf install --assumeyes openmpi-devel

# Getting the executable path
mpi_executable_path_32="/usr/lib/openmpi/bin/mpirun"
mpi_executable_path_64="/usr/lib64/openmpi/bin/mpirun"
if [ -f "$mpi_executable_path_64" ]; then
  mpi_executable_path="$mpi_executable_path_64"
elif [ -f "$mpi_executable_path_32" ]; then
  mpi_executable_path="$mpi_executable_path_32"
fi

# Creating executable symbolic link
ln --symbolic "$mpi_executable_path" "/bin/mpirun"

# Getting the compiler path
mpi_compiler_path_32="/usr/lib/openmpi/bin/mpicc"
mpi_compiler_path_64="/usr/lib64/openmpi/bin/mpicc"
if [ -f "$mpi_compiler_path_64" ]; then
    mpi_compiler_path="$mpi_compiler_path_64"
elif [ -f "$mpi_compiler_path_32" ]; then
    mpi_compiler_path="$mpi_compiler_path_32"
fi

# Creating executable symbolic link
ln --symbolic "$mpi_compiler_path" "/bin/mpicc"