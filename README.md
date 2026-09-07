# gyazo-uploader

Gyazo に画像ファイルをアップロードできる CLI プログラム．
Gyazo に登録した画像の URL をクリップボードにコピーするため，画像のアップロードと URL の利用を同時に行いたい場面で利用できる．

## Prerequisites

Wayland 環境で動作する．
以下のパッケージをインストールする．

```bash
sudo apt install file curl jq wl-clipboard
```

## Setup
1. Gyazo の[ダッシュボード](https://gyazo.com/oauth/applications)からアプリケーションを作成する．
2. 作成したアプリケーションのアクセストークンを生成する．
3. `.env.sample` をコピーし，`.env` を作成する．また，`.env` 内の`GYAZO_ACCESS_TOKEN`に，生成したアクセストークンを設定する．

## gyazo-uploader.sh

画像ファイルを Gyazo にアップロードし，アップロードした画像の URL をクリップボードにコピーする．

```bash
./gyazo-uploader.sh <image_path>
```

## gyazo-clipboard.sh

スクリーンショットによりクリップボードにコピーされる画像を Gyazo にアップロードし，アップロードした画像の URL をクリップボードにコピーする．

```bash
./gyazo-clipboard.sh
```
