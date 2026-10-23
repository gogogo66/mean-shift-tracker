% run_all_tests.m
% Entry point for the Mean-Shift tracker test suite.
%
% Usage:
%   From the project root, inside MATLAB (R2013a or newer):
%       run('tests/run_all_tests.m')
%   or run a single suite:
%       runtests('tests/epanechnikovTest.m')
%
% The suite targets Source/*.m; Source is added to the path automatically.
% Note: the suite cannot be run with plain Octave (no matlab.unittest).

testDir = fileparts(mfilename('fullpath'));
addpath(fullfile(testDir, '..', 'Source'));

results = runtests(testDir);

disp(results);
if any([results.Failed])
    error('run_all_tests:failed', 'One or more tests failed.');
end
disp('All tests passed.');