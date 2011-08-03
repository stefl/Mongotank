MongoTank
=========


Usage
-----

Quick example:

    class Post
      include Mongoid::Document
      include MongoTank
      search_in :title, :body, :author_sn, :realtime => false
    end
  
    search = MongoTank::Query.new
    search.where(:body => "MongoTank").with(:author_sn => "abhishiv")
    results = search.execute