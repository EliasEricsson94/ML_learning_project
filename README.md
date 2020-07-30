# ML_learning_project

Introduction:<br/>
In this project a machine learning model was created, trained and evaluated a to predict ECG signals. 
The intended goal is to learn about machine learning and neural networks and to gain experience with TensorFlow. 

The data is from a part of a challange in which ECG data from patients was to be predicted if on of multiple connected electrodes stopped functioning. 
The presented challenge was about much more and isn't directly relevant to this project. Challenge is linked below.

Background:<br/>
Two years ago I worked with the same data and created recursive MLS & RLS filters. Each patient has three electrodes monitoring signals to their heart for 10 minutes.
One of the electrodes are removed after 9.5 minutes and the goal is to reconstruct the missing 30 seconds by using only the other two electrode signals. 
The challenge asked for two evalution parameters called Q1 and Q2. They are functions alike MSE and all we need to know is that they go from zero to one with one being the best score.
More about the Q1 and Q2 functions can be found on the challenge homepage.

Method and Results:<br/>
If you want to run the code, the data files used are attached and you need to skip the second cell with SQL commands (Server is offline now). 

The final model is a neural network with three non-linear relu layers, containing 12 neurons each, and a single neuron end-layer. 
Training was done with 150 epochs, adam as optimizer, mse as lossfunction and hyperparameters were left untouched. 
More about the model can be seen in the codes, even without running them. 

The model predicts the continuation of the signals well. Result plots for each patient are displayed in the code without running it. 
In the series data where RLS did a good job of predicting, the ML model had even better values. 
In the data which was more difficult to predict the RLS filter had better values than the ML model. 
There isn't a linear cut-off around a metric where the ML or the RLS does better, instead it seems to have to do with how the signal is structured. 

There is very little optimization in the ML model and I believe the RLS filter could also be improved apon. The intent was not to optimize. 
The matlab script and report for the RLS filter is attached.


Required software are TensorFlow, tf-nightly, python3. 
Required libraries, see code. 

Physionet challenge:
https://physionet.org/content/challenge-2010/1.0.0/


