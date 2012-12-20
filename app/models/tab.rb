class Tab < ActiveRecord::Base
  before_save :default_values
  validates_uniqueness_of :title
  validates_uniqueness_of :content
  
  def has_user?
    self.user_id == 0 ? false : true
  end
  
  
=begin rdoc
  Return an old-style text-only tab
=end
  def to_text
    fretboard = (1..string_count).collect {(1..tab_length).collect { "---" }}
    vertical_count = 0
    notes.each do |strum|
      # it's a single note
      if strum.first.is_a?(Integer)
        string, fret = strum
        fretboard[string-1][vertical_count] = "#{fret}--"
      # it's a chord
      else
        strum.each do |note|
          string, fret = note
          fretboard[string-1][vertical_count] = "#{fret}--"
        end
      end
      vertical_count += 1
    end
    fretboard = fretboard.map(&:join).reverse
    fretboard.join("\n")
  end
  
  def tab_length
    notes.size
  end
  
  def string_count
    case self.instrument
    when 'guitar'
      6
    end
  end
  
=begin rdoc
  Returns content as structured array. Old school, yeah!
=end
  def notes
    content.split.map do |vertical| 
      if vertical.include? '-'
        vertical.split('-').map {|n| n.split('|').map(&:to_i)}
      else
        vertical.split('|').map(&:to_i)
      end
    end
  end
protected
  def default_values
    self.instrument = 'guitar' if self.instrument.blank?
  end
end