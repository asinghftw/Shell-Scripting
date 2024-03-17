# File Watcher Script

The File Watcher Script is a Bash script designed to monitor a specific file for changes and update a status file accordingly.

## Overview

This script continuously monitors a specified file for changes. When changes are detected, it updates a status file with information about the alterations made to the monitored file.

## Usage

1. **Prerequisites**: Ensure you have Bash installed on your system.
2. **Installation**: Clone or download the repository containing the script.
3. **Configuration**: Open the script file (`fw.sh`) and modify the following variables according to your environment:
   - `_watch_dir`: Directory to monitor for changes.
   - `_grab_stat`: Status file to update.
   - `_looking_file`: File to monitor.
   - `_time_zone`: Timezone used for time comparison.

4. **Execution**: Run the script using the following command:
   ```bash
   ./fw.sh

## Output

The script continuously monitors the specified file. It updates the status file (gstat.txt) with information about any alterations made to the monitored file.
   
   - File Available
   - Alteration: Data Updated at `_time_stamp`
   - Script exited after 18:00 in `_time_zone`

## Author

   - Author: asinghftw
   - Date: Mar 15, 2024