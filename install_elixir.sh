#!/bin/bash
set -x

# Languages and frameworks
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && sudo dpkg -i erlang-solutions_1.0_all.deb
sudo apt update
sudo apt install esl-erlang elixir unzip

rm erlang-solutions_1.0_all.deb
