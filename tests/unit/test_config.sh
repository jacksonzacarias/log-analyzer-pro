#!/bin/bash

echo "Testando configuração..."

# Carrega configuração
source config/paths.conf

echo "PROJECT_ROOT: $PROJECT_ROOT"
echo "CONFIG_DIR: $CONFIG_DIR"
echo "SRC_DIR: $SRC_DIR"
echo "ANALOGS_DIR: $ANALOGS_DIR"
echo "RESULTS_DIR: $RESULTS_DIR"
echo "SYSTEM_DIR: $SYSTEM_DIR"
echo "PAYLOADS_DIR: $PAYLOADS_DIR"
echo "TEMP_DIR: $TEMP_DIR"
echo "LOGS_DIR: $LOGS_DIR"
echo "DOCS_DIR: $DOCS_DIR"
echo "TESTS_DIR: $TESTS_DIR"
echo "SCRIPTS_DIR: $SCRIPTS_DIR"

echo "Teste concluído!" 