#!/bin/bash

################################
# クリップボードに画像があるか確認
################################
if ! wl-paste --list | grep -q '^image/'; then
  echo "Error: Clipboard does not contain an image."
  exit 1
fi

################################
# 一時ファイルの作成
################################
temp_file=$(mktemp --suffix=.png)

################################
# 一時ファイル削除用にトラップを設定
################################
trap 'rm -f "$temp_file"' EXIT

################################
# クリップボードから画像を取得
################################
if ! wl-paste --type image/png > "$temp_file"; then
  echo "Error: Failed to get image from clipboard."
  exit 1
fi

##############################
# gyazo-uploader を用いて Gyazo にアップロード
##############################
"$(dirname "$0")/gyazo-uploader.sh" "$temp_file"
