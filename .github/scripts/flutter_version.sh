#!/bin/bash

grep '^flutter ' .tool-versions | awk '{print $2}' | sed 's/-stable//'