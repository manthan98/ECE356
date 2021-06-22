#
# ECE356 - Lab 3
# Fall 2020

# Modify this file to achieve the requirements listed in Part 4-2 of the Lab 3
# specifications.

use yelp_db_small;
DROP INDEX idx_1 ON Review(user_id);
CREATE INDEX idx_1 ON Review(user_id);

SELECT User_data.name name, review_id review_ids, Business.name business_names FROM (User_data INNER JOIN Review ON User_data.user_id = Review.user_id) INNER JOIN Business ON Business.business_id = Review.business_id WHERE Review.user_id = 'KGYM_D6JOkjwnzslWO0QHg';
