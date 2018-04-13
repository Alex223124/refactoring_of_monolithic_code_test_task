# refactoring_of_monolithic_code_test_task

Short explanation of what the code does:

1) As an argument, the code takes the name of the directory in which the group of data files lies (presumably the marketing company for a particular brand) + 2 variables for further calculations;
2) sorts these documents;
3) selects the newest document;
4) sorts the contents of the document;
5) creates the result of this sort in the form of a CSV file;
6) based on the data from the sorting, applies a group of functions to calculate the "right" values (probably chooses and calculates the best results of a marketing campaign);
7) creates a separate CSV file with the results of the calculations

How to improve:
- Add a module to validate the CSV file, because some data may not be full or filled correctly (+ to correctness)
- add caching for data that is obtained after sorting (it is possible that reading CSV from the disk will require more resources than using caching) (+ to performance)
- Perhaps the intermediate result in the form of a file with the prefix "_sorted" we do not need. Then you can shorten several steps inside the application (+ to performance)
- Select files from ruby_std_library_extensions in something like german_localization.rb, but at the moment I think this optimization is premature (+ readability)

100 Commits! Ouch! =)


----
### How to use

Preparation:

    - app has errors handlers, you can try to use any folder as first argument and just follow instructions
    - example of valid data - /sample_data/workspace/example_directory

run app :

        ruby run.rb folder_name 1 0.4

run specs:

        rspec
----