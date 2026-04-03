#!/bin/bash
light -G 2>/dev/null | awk '{printf "%d", $1}'
