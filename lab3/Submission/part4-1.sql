#
# ECE356 - Lab 3
# Fall 2020

# Modify this file to achieve the requirements listed in Part 4-1 of the Lab 3
# specifications.

use yelp_db_small;
DROP INDEX idx_date ON Review(date);
CREATE INDEX idx_date ON Review(date);

SELECT count(*) FROM Review WHERE (date >= "2014-05-01 00:00:00" AND date <= "2014-05-31 23:59:59");