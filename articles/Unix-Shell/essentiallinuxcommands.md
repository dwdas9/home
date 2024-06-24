---
layout: default
title: Essential Unix Commands
parent: Unix
---
# Some essential unix commands

| **Command**               | **Description**                                                                                      | **Example**                                      |
|---------------------------|------------------------------------------------------------------------------------------------------|--------------------------------------------------|
| `id`                      | Displays user and group information for the current user.                                            | `id dwdas`                                       |
| `sudo su`                 | Switches to the root user.                                                                           | `sudo su`                                        |
| `ls -la`                  | Lists all files and directories, including hidden ones, with detailed information.                   | `ls -la`                                         |
| `chown`                   | Changes the ownership of files and directories.                                                      | `chown -R dwdas:dwdas /user/hive`                |
| `rm -rf`                  | Removes everything inside a specified directory but leaves the directory itself intact.              | `rm -rf /home/dwdas/*`                           |
| `mkdir -p`                | Creates directories, including parent directories if they don't exist.                               | `mkdir -p /user/hive/warehouse`                  |
| `whoami`                  | Displays the current username.                                                                       | `whoami`                                         |
| `printenv`                | Displays environment variables.                                                                      | `printenv SPARK_HOME`                            |
| `cd`                      | Changes the current directory.                                                                       | `cd /user/hive`                                  |
| `pwd`                     | Prints the current working directory.                                                                | `pwd`                                            |
| `cp`                      | Copies files or directories.                                                                         | `cp source_file destination_file`                |
| `mv`                      | Moves or renames files or directories.                                                               | `mv old_name new_name`                           |
| `chmod`                   | Changes the permissions of files or directories.                                                     | `chmod 755 script.sh`                            |
| `top`                     | Displays real-time system information and process details.                                           | `top`                                            |
| `ps`                      | Displays currently running processes.                                                                | `ps aux`                                         |
| `kill`                    | Terminates a process.                                                                                | `kill -9 process_id`                             |
| `grep`                    | Searches for patterns within files.                                                                  | `grep "search_term" filename`                    |
| `find`                    | Searches for files and directories.                                                                  | `find /path -name filename`                      |
| `df`                      | Displays disk space usage.                                                                           | `df -h`                                          |
| `du`                      | Displays disk usage of files and directories.                                                        | `du -sh directory`                               |
| `tar`                     | Archives files.                                                                                      | `tar -cvf archive_name.tar directory`            |
| `curl`                    | Transfers data from or to a server.                                                                  | `curl -O http://example.com/file`                |
| `wget`                    | Downloads files from the internet.                                                                   | `wget http://example.com/file`                   |
| `nano`                    | A simple text editor.                                                                                | `nano filename`                                  |
| `vim`                     | A more advanced text editor.                                                                         | `vim filename`                                   |
| `ssh`                     | Connects to a remote machine via SSH.                                                                | `ssh user@hostname`                              |
| `scp`                     | Copies files between hosts over SSH.                                                                 | `scp local_file user@remote_host:/remote_path`   |
| `docker`                  | Manages Docker containers.                                                                           | `docker ps`                                      |
| `systemctl`               | Manages system services.                                                                             | `systemctl status service_name`                  |
| `service`                 | Manages system services (older systems).                                                             | `service service_name start`                     |
| `alias`                   | Creates a shortcut for a command.                                                                    | `alias ll='ls -la'`                              |
| `history`                 | Shows the command history.                                                                           | `history`                                        |

