#!/usr/bin/env bash

pkill waybar
sleep 0.75
hyprctl dispatch exec waybar
