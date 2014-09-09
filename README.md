
# Consulのテスト環境構築(OS X)

## できること

```
Node    Address         Status  Type    Build  Protocol
node01  127.0.0.1:8301  alive   server  0.4.0  2
node02  127.0.0.2:8301  alive   server  0.4.0  2
node03  127.0.0.3:8301  alive   server  0.4.0  2
node04  127.0.0.4:8301  alive   client  0.4.0  2
```

のConsul Clusterをスクリプトで簡単に構築できる


## 手順

### 1. loopbackのエイリアスを貼る

[Mac OS X – Adding a loopback alias](http://astralbodi.es/2011/02/04/mac-os-x-adding-a-loopback-alias/)

```
# 追加
$ sudo ifconfig lo0 alias 127.0.0.2
$ sudo ifconfig lo0 alias 127.0.0.3
$ sudo ifconfig lo0 alias 127.0.0.4

# 確認
$ ifconfig lo0
```

### 2. consulのインストール

[http://www.consul.io/intro/getting-started/install.html](http://www.consul.io/intro/getting-started/install.html)

```
# インストール
$ brew install caskroom/cask/brew-cask
$ brew cask install consul

# 確認
$ consul -h
```

### 3. このリポジトリのファイルのダウンロード

```
$ git clone git@github.com:kenjiskywalker/consul-test.git
$ cd consul-test/
```

### 3. consulのweb uiのダウンロード

> /consul-test/

[http://www.consul.io/downloads_web_ui.html](http://www.consul.io/downloads_web_ui.html)

```
$ curl -L -o ./web_ui.zip https://dl.bintray.com/mitchellh/consul/0.4.0_web_ui.zip
$ unzip ./web_ui.zip
```

### 4. 起動

> /consul-test/


```
$ sudo ./consul-start.sh

# 確認
$ consul members -detailed
```

#### 4-1. ウェブでも確認

[http://localhost:8500](http://localhost:8500)

#### 4-2. 名前解決でも確認

```
$ dig @127.0.0.1 -p 8600 node0{1,2,3,4}.node.consul.
```

### 5. 停止

> /consul-test/

```
$ sudo ./consul-stop.sh
```

### 6. loopbackのエイリアスを削除

```
# 削除
$ sudo ifconfig lo0 -alias 127.0.0.2
$ sudo ifconfig lo0 -alias 127.0.0.3
$ sudo ifconfig lo0 -alias 127.0.0.4

# 確認
$ ifconfig lo0
```


## watchesでnodes を監視する

watches で nodes を見るようにして  
nodeの増減時に特定のスクリプトを実行するようにした


```
['-']% head node0*/_hosts
==> node01/_hosts <==
node01   127.0.0.1
node02   127.0.0.2
node03   127.0.0.3
node04   127.0.0.4

==> node02/_hosts <==
node01   127.0.0.1
node02   127.0.0.2
node03   127.0.0.3
node04   127.0.0.4

==> node03/_hosts <==
node01   127.0.0.1
node02   127.0.0.2
node03   127.0.0.3
node04   127.0.0.4

==> node04/_hosts <==
node01   127.0.0.1
node02   127.0.0.2
node03   127.0.0.3
node04   127.0.0.4
['-']%
['-']% consul leave -rpc-addr=127.0.0.4:8400
    2014/09/09 22:47:37 [INFO] agent.rpc: Accepted client: 127.0.0.4:60046
    2014/09/09 22:47:37 [INFO] agent.rpc: Graceful leave triggered
    2014/09/09 22:47:37 [INFO] consul: client starting leave
    2014/09/09 22:47:38 [INFO] serf: EventMemberLeave: node04 127.0.0.4
    2014/09/09 22:47:38 [INFO] serf: EventMemberLeave: node04 127.0.0.4
    2014/09/09 22:47:38 [INFO] agent: requesting shutdown
    2014/09/09 22:47:38 [INFO] consul: shutting down client
Graceful leave complete
    2014/09/09 22:47:38 [INFO] agent: shutdown complete
['-']%
['-']%
['-']% head node0*/_hosts
==> node01/_hosts <==
node01   127.0.0.1
node02   127.0.0.2
node03   127.0.0.3

==> node02/_hosts <==
node01   127.0.0.1
node02   127.0.0.2
node03   127.0.0.3

==> node03/_hosts <==
node01   127.0.0.1
node02   127.0.0.2
node03   127.0.0.3

==> node04/_hosts <==
node01   127.0.0.1
node02   127.0.0.2
node03   127.0.0.3
['-']%
['-']%
['-']% head node0*/_hosts
==> node01/_hosts <==
node01   127.0.0.1
node02   127.0.0.2

==> node02/_hosts <==
node01   127.0.0.1
node02   127.0.0.2

==> node03/_hosts <==
node01   127.0.0.1
node02   127.0.0.2

==> node04/_hosts <==
node01   127.0.0.1
node02   127.0.0.2
node03   127.0.0.3
['-']%
['-']% ls -la  node0*/_hosts
-rw-r--r--  1 root  staff  36  9  9 22:48 node01/_hosts
-rw-r--r--  1 root  staff  36  9  9 22:48 node02/_hosts
-rw-r--r--  1 root  staff  36  9  9 22:48 node03/_hosts
-rw-r--r--  1 root  staff  54  9  9 22:47 node04/_hosts
['-']%
```
