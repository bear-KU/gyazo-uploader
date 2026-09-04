#!/bin/bash

#############################
# .env の読み込み
#############################
ENV_FILE="$(dirname "$0")/.env"

if [ ! -f "$ENV_FILE" ]; then
  echo "Error: .env file not found."
  exit 1
fi

source "$ENV_FILE"

##############################
# 画像ファイルのパスを取得
##############################
image_path="$1"

if [ -z "$image_path" ]; then
  echo "Usage: $(basename "$0") <image_path>"
  exit 1
fi

if [ ! -f "$image_path" ]; then
  echo "Error: File '$image_path' does not exist."
  exit 1
fi

# ファイルが画像であるか確認
file_type=$(file --brief --mime-type "$image_path")

case "$file_type" in
  image/*)
    ;;
  *)
    echo "Error: File '$image_path' is not an image."
    exit 1
    ;;
esac

###############################
# Gyazo API へのアップロード
###############################
if [ -z "$GYAZO_ACCESS_TOKEN" ]; then
  echo "Error: GYAZO_ACCESS_TOKEN is not set"
  exit 1
fi

# 基本的に，Gyazo には撮影時の日時で登録される(ことがあった)
# しかし，Gyazo は投稿時間の最新10件しか画像を確認することができない
# そのため，投稿時間をスクリプト実行時の時間にすることで常に最新の投稿として扱われるようにする
current_time=$(date +%s)

response=$(curl -fsS \
  -H "Authorization: Bearer $GYAZO_ACCESS_TOKEN" \
  -F "imagedata=@$image_path" \
  -F "created_at=$current_time" \
  https://upload.gyazo.com/api/upload)

if [ $? -ne 0 ]; then
  echo "Error: Failed to upload image to Gyazo."
  exit 1
fi

################################
# 写真の URL を取得してクリップボードにコピー
################################
permalink=$(echo "$response" | jq -r '.permalink_url')

if ! echo "$permalink" | wl-copy; then
  echo "Error: Failed to copy URL to clipboard."
  exit 1
fi

################################
# レスポンスの表示
################################
# echo "$response" | jq
echo "Successfully uploaded: $image_path"
echo "Gyazo URL: $permalink"
