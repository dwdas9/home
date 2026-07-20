
## How to Run a Service in the Background on Linux and Check if It’s Running

In this article, I will show you how to run a service in the background. I've used Apache Airflow as an example, but you can apply these methods to other services as well.

### Running a Service in the Background

1. **Using `nohup` (Linux/MacOS):**
   - The `nohup` command allows you to run the Airflow scheduler in the background and ensures it continues running even after you close the terminal.

   ```bash
   nohup airflow scheduler > scheduler.log 2>&1 &
   ```

   - Here, `nohup` keeps the process running, `> scheduler.log 2>&1` saves the output to a log file, and `&` runs it in the background.

2. **Using `screen` (Linux/MacOS):**
   - `screen` is a terminal multiplexer that lets you start a terminal session that you can detach from and reattach to later.

   ```bash
   screen -S airflow-scheduler
   airflow scheduler
   ```

   - After starting the scheduler, detach the screen session by pressing `Ctrl + A`, then `D`. To reattach to the session, use:

   ```bash
   screen -r airflow-scheduler
   ```

3. **Using `tmux` (Linux/MacOS):**
   - `tmux` is similar to `screen`, providing another way to manage terminal sessions that you can detach and reattach to.

   ```bash
   tmux new -s airflow-scheduler
   airflow scheduler
   ```

   - Detach from the session with `Ctrl + B`, then `D`. Reattach with:

   ```bash
   tmux attach -t airflow-scheduler
   ```

4. **Using `systemd` (Linux):**
   - To manage the Airflow scheduler as a service, you can create a `systemd` service file. This method is more permanent and reliable.

   Create a file at `/etc/systemd/system/airflow-scheduler.service` with the following content:

   ```ini
   [Unit]
   Description=Airflow Scheduler
   After=network.target

   [Service]
   ExecStart=/usr/local/bin/airflow scheduler
   Restart=always
   User=airflow
   Group=airflow
   StandardOutput=syslog
   StandardError=syslog
   SyslogIdentifier=airflow-scheduler

   [Install]
   WantedBy=multi-user.target
   ```

   - Then enable and start the service:

   ```bash
   sudo systemctl enable airflow-scheduler
   sudo systemctl start airflow-scheduler
   ```

5. **Using `&` (Linux/MacOS):**
   - For a quick and simple way to run the Airflow scheduler in the background, just append `&` to the command:

   ```bash
   airflow scheduler &
   ```

6. **Using Docker (If Airflow is running inside a container):**
   - If you're using Docker, you can run the Airflow scheduler in detached mode using the following command:

   ```bash
   docker run -d --name airflow-scheduler apache/airflow:latest scheduler
   ```

   - This command will start the scheduler in the background inside the Docker container.

### Checking if a Service is Running

1. **Checking the Airflow Scheduler:**
   - To see if the Airflow scheduler is running, use the `ps` command:

   ```bash
   ps aux | grep 'airflow scheduler'
   ```

   - This command will list the running processes, including the Airflow scheduler if it's active.

2. **Checking Apache Web Server:**
   - For Apache, which is a widely used web server, you can check its status with:

   ```bash
   sudo systemctl status apache2
   ```

   - If Apache is running, you'll see "active (running)" in the status output.

## Conclusion

So, the popular commands to run services in the background in linux like os are:`nohup`, `screen`, `tmux` and `systemctl`