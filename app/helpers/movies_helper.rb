module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def check_box_highlight(sec)
    if session[:sort] == sec
      return "hilite"
    end
  end
end
