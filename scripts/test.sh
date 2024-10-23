#!/bin/bash

cd widgets
gleam test
gleam format --check src test
cd ..

cd editor
gleam test
gleam format --check src test
cd ..

cd backend
gleam test
gleam format --check src test
cd ..