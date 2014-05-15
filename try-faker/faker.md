# Faker

Perlの`Data::Faker`ライブラリのように偽データを生成します。

## 使い方

### サンプルコード

```ruby

require 'faker'

p Faker::Name.name      # => "Evan Hayes"
p Faker::Internet.email # => "alexander@hagenes.com"

```

`クラス（データの分類）.メソッド（データ名）`で指定するだけ。

### それっぽいデータをDBに投入するタスクのサンプル

[RAILS CASTS #126 Populating a Database](http://railscasts.com/episodes/126-populating-a-database)


## データの分類

|種類        |クラス               |データ例（一部）            |
|:-----------|:--------------------|:---------------------------|
|住所        |Faker::Address       |都市名、緯度・経度          |
|ビットコイン|Faker::Bitcoin       |ビットコインアドレス        |
|取引        |Faker::Business      |クレジットカード番号        |
|コード      |Faker::Code          |ISBNコード                  |
|商業        |Faker::Commerce      |商品名、価格、色            |
|会社        |Faker::Company       |会社名、謳い文句、キャッチフレーズ|
|インターネット|Faker::Internet    |メールアドレス、URL、スラッグ、IPアドレス|
|リプサム    |Faker::Lorem         |文字列、行、文章            |
|名前        |Faker::Name          |氏、名、接尾辞、タイトル    |
|数          |Faker::Number        |数字（桁を指定）、桁数      |
|電話番号    |Faker::PhoneNumber   |電話番号                    |
|アバター    |Faker::Avatar        |プロフィール（アバター）画像URL|

各分類で生成できるデータについて詳しくはドキュメント参照。

http://rubydoc.info/gems/faker/1.3.0/frames

## 日本語データ

faker-japanese
