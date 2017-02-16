class Movie < ActiveRecord::Base

  # self so that it is class method
  def self.all_ratings
    # return ['G', 'PG','PG-13','R']
    all_ratings = []
    Movie.all.each do |movie|
      all_ratings << movie.rating
    end
    return all_ratings.uniq!.sort!
  end
end
