#!/bin/bash

consul agent -server -bootstrap-expect 1 -config-dir node01 -join 127.0.0.1 &
consul agent -server -config-dir node02 -join 127.0.0.1 &
consul agent -server -config-dir node03 -join 127.0.0.1 &
consul agent -config-dir node04 -join 127.0.0.1 &
