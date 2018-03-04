#!/usr/bin/env sh


rm -fr build

pub run build_runner build --output build

firebase deploy

