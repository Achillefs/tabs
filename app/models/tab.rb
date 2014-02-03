class Tab < ActiveRecord::Base
  INSTRUMENTS = %W[ guitar 7string-guitar bass 5string-bass mandolin 4string-bouzouki 3string-bouzouki ]
  
  before_save :default_values
  validates :title, :content, presence: true, uniqueness: true, allow_nil: false
  attr_accessible :title, :content, :instrument
  
  def has_user?
    self.user_id == 0 ? false : true
  end
  
  
=begin rdoc
  Return an old-style text-only tab
=end
  def to_text
    text = "#{title.center(fretboard.first.size)}\n"
    text << fretboard.join("\n")
  end
  
  def to_page width = 80
    if fretboard.first.size > width
      fixed_length_fretboard = fretboard.map do |string|
        string.scan(/.{1,#{width}}/)
      end
      page = "#{title.center(width)}\n"
      data = (0..(fixed_length_fretboard.first.size-1)).map { |row| fixed_length_fretboard.map {|string| string[row]} }
      page << data.map {|row| row.map {|r| r.ljust(width,'-')}.join("\n")}.join("\n\n")
    else
      to_text
    end
  end
  
=begin rdoc
  returns an array representing a fretboard. Right now time is not represented, only finger positions on strings
=end
  def fretboard
    return @fretboard if @fretboard.present? and !self.content_changed?
    fretboard = (1..string_count).collect {(1..tab_length).collect { "---" }}
    
    vertical_count = 0
    verticals.each do |strum|
      
      if strum.first.is_a?(Integer)
        if strum == [0] # it's a pause
          fretboard[0][vertical_count] = '---'
        else # it's a single note
          string, fret = strum
          fretboard[string-1][vertical_count] = fret >= 10 ? "#{fret}-" : "#{fret}--"
        
        end
      # it's a chord
      else
        strum.each do |note|
          begin
            string, fret = note
            fretboard[string-1][vertical_count] = fret >= 10 ? "#{fret}-" : "#{fret}--"
          rescue Exception => e
            raise 'Error parsing ' + note.inspect
          end
          
          
        end
      end
      vertical_count += 1
    end
    @fretboard = fretboard.map(&:join).reverse
  end
  
  def tab_length
    verticals.size
  end
  
  def string_count
    case self.instrument
    when '7string-guitar'
      7
    when 'guitar'
      6
    when '5string-bass'
      5
    when 'mandolin', '4string-bouzouki', 'bass'
      4
    when '3string-bouzouki'
      3
    end
  end
  
  def verticals
    JSON.parse(content)
  end
protected
  def default_values
    self.instrument = 'guitar' if self.instrument.blank?
  end
end