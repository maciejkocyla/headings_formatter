#!/usr/bin/ruby

data = [
  {id: 1, title: "heading1", heading_level: 0},
  {id: 2, title: "heading2", heading_level: 2},
  {id: 3, title: "heading3", heading_level: 1},
  {id: 4, title: "heading4", heading_level: 1},
  {id: 5, title: "heading5", heading_level: 4},
  {id: 6, title: "heading1", heading_level: 6},
  {id: 6, title: "heading1", heading_level: 6},
  {id: 6, title: "heading9", heading_level: 6},
  {id: 6, title: "heading1", heading_level: 6},
  {id: 6, title: "heading15", heading_level: 6},
  {id: 5, title: "heading1", heading_level: 4},
  {id: 1, title: "heading1", heading_level: 0},
  {id: 6, title: "heading1", heading_level: 6},
  {id: 6, title: "heading1", heading_level: 0}
]

@last_heading_counter = [] #array for storing headers coutners


# changes the @last_heading_counter based on the level of current heading
def increment_level(level)

  if !@last_heading_counter[level] 
    @last_heading_counter[level] = 0
  end
  @last_heading_counter[level] += 1

  for i in 0..(@last_heading_counter.length - 1) do
    if i > level + 1
      @last_heading_counter[i] = 0
    elsif [0, nil].include?(@last_heading_counter[i])
      @last_heading_counter[i] = 1
    end
  end
end

#html file begining and end
html_file_header = "<html><head></head><body>"
html_file_footer = "</body></html>"

formatted_file = File.open("./formatted_headers.html", "w")

begin
  formatted_file.puts html_file_header
  data.each do |heading|
    # ensure that level is >= 0
    heading[:heading_level] = heading[:heading_level] >= 0 ? heading[:heading_level] : 0

    increment_level(heading[:heading_level])
    heading[:counter] = @last_heading_counter[0..heading[:heading_level]].join(".")

    # write to html file
    formatted_file.puts "<h4>"
    heading[:heading_level].times { formatted_file.puts "&nbsp;"}
    formatted_file.puts heading[:counter]
    formatted_file.puts heading[:title]
    formatted_file.puts "</h4>"

  end

  formatted_file.puts html_file_footer
ensure
  formatted_file.close
end
