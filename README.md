
# Consulのテスト環境構築(OS X)

1. loopbackのエイリアスを貼る

[Mac OS X – Adding a loopback alias](http://astralbodi.es/2011/02/04/mac-os-x-adding-a-loopback-alias/)

```
# 追加
$ sudo ifconfig lo0 alias 127.0.0.2
$ sudo ifconfig lo0 alias 127.0.0.3
$ sudo ifconfig lo0 alias 127.0.0.4

# 確認
$ ifconfig lo0
```

2. consulのインストール

[http://www.consul.io/intro/getting-started/install.html](http://www.consul.io/intro/getting-started/install.html)

```
# インストール
$ brew install caskroom/cask/brew-cask
$ brew cask install consul

# 確認
$ consul -h
```

3. consulのweb uiのダウンロード

[http://www.consul.io/downloads_web_ui.html](http://www.consul.io/downloads_web_ui.html)

```
$ curl -L -o ./web_ui.zip https://dl.bintray.com/mitchellh/consul/0.4.0_web_ui.zip
$ unzip ./web_ui.zip
```

2. 起動

```
$ git clone git@github.com:kenjiskywalker/consul-test.git
$ cd consul-test/
$ sudo ./consul-start.sh

# 確認
$ consul members -detailed
```

ウェブでも確認

[http://localhost:8500](http://localhost:8500)

名前解決でも確認

```
$ dig @127.0.0.1 -p 8600 node0{1,2,3,4}.node.foo.
```

3. 停止

```
$ sudo ./consul-stop.sh
```
