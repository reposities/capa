#!/usr/bin/env bash
# Copyright (C) 2020 FireEye, Inc. All Rights Reserved.
# Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
# You may obtain a copy of the License at: [package root]/LICENSE.txt
# Unless required by applicable law or agreed to in writing, software distributed under the License
#  is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.

set -euo pipefail

GIT_DIR=$(git rev-parse --show-toplevel);
cd "$GIT_DIR";

# hooks may exist already (e.g. git-lfs configuration)
# If the `.git/hooks/$arg` file doesn't exist it, initialize with `#!/bin/sh`
# After that append `scripts/hooks/$arg` and ensure they can be run
create_hook() {
  if [[ ! -e .git/hooks/$1 ]]; then
    echo "#!/bin/sh" > ".git/hooks/$1";
  fi
  cat scripts/hooks/"$1" >> ".git/hooks/$1";
  chmod +x .git/hooks/"$1";
}

printf '\n#### Copying hooks into .git/hooks';
create_hook 'post-commit';
create_hook 'pre-push';
