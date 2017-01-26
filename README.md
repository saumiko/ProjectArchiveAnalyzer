# SUST Archives (beta)
This project was created to keep track of the project and assignment submissions of the students at SUST. Student will take a course, teacher will approve him and then will assign him his group and his project. Student will be able to submit his tasks accordingly. 

The project demonstration keynote can be seen in [YouTube](https://www.youtube.com/watch?v=ycyANyEoOLo).

This project was build using Spring framework. To control the dependencies we have used Maven.

### How to build and run
- Download and install [Spring Tool Suite™](https://spring.io/tools).
- Import the `Project300` folder as existing maven project in your STS.
- Install [mysql](http://dev.mysql.com/downloads/mysql/) in your system.
- Open the [Configuration file](https://github.com/saumiko/sustarchive/blob/master/Project300/src/main/resources/conf.properties) of the project and enter your root password at `line 21`.
- Import the [Schema Creator](https://github.com/saumiko/sustarchive/blob/master/Project300/sust_archive_schema_creator_1.0.sql) and [Populator](https://github.com/saumiko/sustarchive/blob/master/Project300/sust_archive_dummy_populator_2.0.sql) to your `mysql` local instance.
- Go back to `STS` and run the project on your installed server. 

You're good to go and explore.

© :bangladesh: Shahjalal University of Science and Technology, 2016
