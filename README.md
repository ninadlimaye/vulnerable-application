# AppSec Problem Set

The Ruby on Rails application in this repository is a simple blogging framework. The admin user can publish blog posts and visitors to the site can vote on whether they like/dislike the posts.

I found out a possible SQL injection in the app which I have detailed it below.

### Running the application

You need to have Git, Postgres, Ruby and the `bundler` Gem installed. From there, you'll need to run

*  Clone the application anywhere and navigate to the main directory
*  Run `bundle install` which installs the dependencies needed to run the app
*  Next run `bundle exec rake db:migrate` to setup the Postgres database
*  Run `bundle exec rake` to verify that everything is setup now
*  Finally, run `bundle exec rails server` to start the local server at http://localhost:3000


### Vulnerable SQL Injection vulnerability

There is a scenario of a possible SQL Injection, that the parameter 'order' was not escaped. An example is that an apostrophe as a bad input would return an error page indicating that the string or column name was not found in the database.

I created a separate private class that the parameter 'order' should return back default values so that the apostrophe or other string characters are escaped. In other words, the parameter 'order' is sanitized before passing it on to the order by clause function.

### Patch to mitigate the vulnerability

To remediate it, open the posts_controller.rb and:

Replace the @posts variable from line 8 with 'Post.where("name LIKE ? OR body LIKE ?", query, query).order(ord)'

Add the following function before the last 'end' of the class

def ord
 +    Post.column_names.include?(params[:order]) ? params[:order] : "created_at"
 end
 
The error page is then fixed.
