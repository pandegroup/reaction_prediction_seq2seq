#!/usr/bin/env bash

export CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export MODEL_DIR=${CURRENT_DIR}/model_working_directory/jul_5_2017_1
export DATA_PATH=${CURRENT_DIR}/processed_data
export PREDICTION_PATH=${CURRENT_DIR}/predictions

export TEST_SOURCES=${DATA_PATH}/test_sources

python -m bin.infer \
  --tasks "
    - class: DecodeText
    - class: DumpBeams
      params:
        file: ${PREDICTION_PATH}/beams_44000steps_3_test.npz" \
  --model_dir $MODEL_DIR \
  --model_params "
    inference.beam_search.beam_width: 3" \
  --input_pipeline "
    class: ParallelTextInputPipeline
    params:
      source_files:
        - $TEST_SOURCES" \
--checkpoint_path "${MODEL_DIR}/model.ckpt-44001"\
  > "${PREDICTION_PATH}/predictions_44000_steps_beam_3_test.txt"
