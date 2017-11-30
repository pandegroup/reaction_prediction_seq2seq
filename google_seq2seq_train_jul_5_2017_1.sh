#!/usr/bin/env bash

export CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export MODEL_DIR=${CURRENT_DIR}/model_working_directory/jul_5_2017_1
export DATA_PATH=${CURRENT_DIR}/processed_data

export VOCAB_SOURCE=${DATA_PATH}/vocab
export VOCAB_TARGET=${DATA_PATH}/vocab
export TRAIN_SOURCES=${DATA_PATH}/train_sources
export TRAIN_TARGETS=${DATA_PATH}/train_targets
export DEV_SOURCES=${DATA_PATH}/valid_sources
export DEV_TARGETS=${DATA_PATH}/valid_targets

export TRAIN_STEPS=1000000

mkdir -p $MODEL_DIR

python -m bin.train \
  --config_paths="
      ./example_configs/nmt_large_jul_5_2017_1.yml,
      ./example_configs/train_seq2seq_jul_5_2017_1.yml,
      ./example_configs/text_metrics_bpe.yml" \
  --model_params "
      vocab_source: $VOCAB_SOURCE
      vocab_target: $VOCAB_TARGET" \
  --input_pipeline_train "
    class: ParallelTextInputPipeline
    params:
      source_files:
        - $TRAIN_SOURCES
      target_files:
        - $TRAIN_TARGETS" \
  --input_pipeline_dev "
    class: ParallelTextInputPipeline
    params:
       source_files:
        - $DEV_SOURCES
       target_files:
        - $DEV_TARGETS" \
  --batch_size 32 \
  --output_dir $MODEL_DIR \
  --eval_every_n_steps 4000 \
  --save_checkpoints_steps 4000 \
  --keep_checkpoint_max 0
