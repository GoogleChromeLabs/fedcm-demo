# !/bin/bash

#  Copyright 2025 Google LLC
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#
#  NOTE: This is not an officially supported Google product

LOG_FILE="caddy.log"


echo "Attempting to stop any running Caddy instances..."
npx caddy stop > /dev/null 2>&1 || sudo killall caddy > /dev/null 2>&1 || true

printf "Starting Caddy local cross-site environment proxy. Logs will appear in \e]8;;file://$PWD/caddy.log\acaddy.log\e]8;;\a\n"

( 
    npx caddy run --config Caddyfile > "${LOG_FILE}" 2>&1
) || {
  # This code runs ONLY if the Caddy process exits with a non-zero status (an error).
  echo "Caddy process failed. See ${LOG_FILE} for details." >&2
  exit 1 # Ensure the script exits with a failure code
}