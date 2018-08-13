# Matlab-optimizations-examples
Provides simple examples of advanced mathematical optimization methods in application to control engineering problems.

For the time being the project allows to tune a PID controller gains for simple plant and actuator system. You can use one of the three integral error criterias:
  * integral of the absolute value of error (__IAE__),
  * integral of the squared error (__ISE__),
  * integral of time weighted absolute error (__ITAE__).

For optimization methods you can choose from:
  * _lsqnonlin_ (levenberg-marquardt method),
  * _fminunc_ (quasi-newton,  Broyden, Fletcher, Goldfarb and Shanno method),
  * _fminsearch_ (simplex search method),
  * _ga_ (genetic algorithm),
  * _particleswarm_ (particle swarm optimization),
  * _aco_ (ant colony optimization).

## Getting started
### Prerequisites
The project is written in Matlab 2018a, so it is recommended to have this version due to likely lack of backward compatibility of Simulink models. It should nevertheless work on versions down to 2012 since they support .slx format. You will also need to have:
  * Optimization Toolbox to use:
    * _lsqnonlin_,
    * _fminunc_.
  * Global Optimization Toolbox to use:
    * _ga_,
    * _particleswarm_.

### Installing
Simply copy or download the repository to you drive. Set the current folder in Matlab to the repository directory. Running the code automatically adds folders dependencies.

## Usage
Run the _PID_tuning_example.m_ or type `PID_tuning_example` in Command Window. You will see a short description and a menu for pick out the algorithm. The script is looped. You can run any of the algorithm multiple times without starting the script again. To exit press 7. For algorithms 2 - 6 you must pick the integral error criteria. For the _lsqnonlin_ the last square method is required and a suitable objective function is already provided. After successful  optimization you will see the total error rate and gains for all terms of the controller. For evaluation reasons two plots will be presented. First shows a step response for the starting point gains (see Command Windows description for exact values) and the second a step response after gains optimization. Some of the algorithms can really take a while so be patient. You can always use `Ctrl + c` to cancel the run. All options and parameters are pre-selected.

## Credite
Idea and model based on [lsqnonlin with a Simulink Model](https://www.mathworks.com/help/optim/ug/lsqnonlin-with-a-simulink-model.html)

## License
This project is licensed under the GNU General Public License - see the LICENSE.md file for details.
