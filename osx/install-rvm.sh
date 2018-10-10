#!/usr/bin/env bash
# https://rvm.io

curl -sSL https://get.rvm.io | bash -s stable

# sudo usermod -aG rvm `whoami`

# Installing RVM to /work/rvm/
# chown: you are not a member of group rvm
#     could not set group of '/work/rvm/man/man1', prefix the command with 'rvmsudo' to fix it, if the situation persist report a bug.
# chown: you are not a member of group rvm
#     could not set group of '/work/rvm/man/man1/rvm.1.gz', prefix the command with 'rvmsudo' to fix it, if the situation persist report a bug.
# chown: you are not a member of group rvm
#     could not set group of '/work/rvm/man/man1/rvm.1', prefix the command with 'rvmsudo' to fix it, if the situation persist report a bug.
#     Warning! Installing RVM in system mode without root permissions, make sure to modify PATH / source rvm when it's needed.
#     Found 1900 files not belonging to 'rvm',
# use `--debug` to see the list, run `rvmsudo rvm get stable` to fix it., prefix the command with 'rvmsudo' to fix it, if the situation persist report a bug.
#     Found 445 directories with mode different than '775',
# use `--debug` to see the list, run `rvmsudo rvm get stable` to fix it., prefix the command with 'rvmsudo' to fix it, if the situation persist report a bug.
#     Found 1441 files with mode different than '664' or '775',
# use `--debug` to see the list, run `rvmsudo rvm get stable` to fix it., prefix the command with 'rvmsudo' to fix it, if the situation persist report a bug.
# Installation of RVM in /work/rvm/ is almost complete:

#   * First you need to add all users that will be using rvm to 'rvm' group,
#     and logout - login again, anyone using rvm will be operating with `umask u=rwx,g=rwx,o=rx`.

#   * To start using RVM you need to run `source /work/rvm/scripts/rvm`
#     in all your open shell windows, in rare cases you need to reopen all shell windows.
