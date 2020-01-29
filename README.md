# Code for "Retrosynthetic reaction prediction using neural sequence-to-sequence models" paper
http://pubs.acs.org/doi/full/10.1021/acscentsci.7b00303

# Requirements
All requirements for https://github.com/google/seq2seq

Additionally:
* numpy
* networkx
* rdkit

## Model training
The data has already been preprocessed for training the seq2seq model

Model training can be started by running the google_seq2seq_train_jul_5_2017_1.sh script

Also, a pretrained model checkpoint can be found at: http://deepchem.io.s3-website-us-west-1.amazonaws.com/trained_models/jul_5_2017_1.tar.gz. Copy the folder into model_working_directory. Then from within the train_options.json file, modify the vocab_target and vocab_source flag to the actual vocab path in the processed data folder

## Model inference

### Note- If you use the pretrained model for inferencing then make sure you are working on TF 1.0.1 GPU. Else it throws Key not found error.

Model inference can be performed by running the google_seq2seq_infer_jul_5_2017_1_x.sh scripts. 

The google_seq2seq_infer_jul_5_2017_1_nobeam.sh file will perform inference with no beam search. The output will be a prediction text file

The google_seq2seq_infer_jul_5_2017_1_x.sh will perform inference with beam search. The outputs will be a prediction text file, as well as a .npz that contains the raw beams which will be processed during the model evaluation 

The ---checkpoint_path flag within the script should be changed to the relevant checkpoint file that you want to perform inference on.

## Model evaluation
The prediction can be evaluated using reaction_evaluation.ipynb in the evaluation folder. For the no beam search predictions, need to change pred_path to the relevant prediction file. For the beam search predictions, need to change beam_width and beam_path to the relevant beam widths used for each particular .npz beam prediction file. 
