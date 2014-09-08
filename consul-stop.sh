#!/bin/bash

consul leave -rpc-addr=127.0.0.1:8400
consul leave -rpc-addr=127.0.0.2:8400
consul leave -rpc-addr=127.0.0.3:8400
consul leave -rpc-addr=127.0.0.4:8400
