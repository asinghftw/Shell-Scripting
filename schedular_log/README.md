# Scheduler File Watcher

This bash script monitors a specified directory for the presence and updates of a specific file. It logs any changes made to the file and rotates the log files to prevent them from growing too large.

## Table of Contents

- [Usage](#usage)
- [Configuration](#configuration)
- [Features](#features)
- [Author](#author)
- [License](#license)

## Usage

1. Ensure you have Bash installed on your system.
2. Clone this repository to your local machine.
3. Navigate to the directory where the script is located.
4. Run the script using the following command:

```bash
./scd_fw.sh
```

## Configuration

You can configure the script by modifying the following variables:

   - `_watch_dir`: The directory to monitor for file changes.
   - `_looking_file`: The name of the file to monitor for changes.
   - `_time_zone`: The timezone used for logging timestamp.
   - `LOG_DIR`: The directory where log files will be stored.
   - `LOG_ROTATE_THRS`: The threshold size (in bytes) for log file rotation.


## Features

1. File Monitoring: Monitors the specified directory for the presence and updates of a specific file.
2. Logging: Logs any changes made to the file, including data updates and reductions.
3. Log Rotation: Rotates log files to prevent them from growing too large.

## Author

   - Author: asinghftw
   - Date: Mar 17, 2024